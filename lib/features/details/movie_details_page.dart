import 'package:domain/src/entity/movie_details.dart';
import 'package:domain/src/entity/result/movie_details_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/di/di.dart';
import 'package:flutter_app/features/details/bloc/movie_details_event.dart';
import 'package:flutter_app/features/details/bloc/movie_details_state.dart';
import 'package:flutter_app/features/widgets/favourite_button_widget.dart';
import 'package:flutter_app/features/widgets/generic_error_widget.dart';
import 'package:flutter_app/features/widgets/generic_loading_widget.dart';
import 'package:flutter_app/features/widgets/poster_widget.dart';
import 'package:flutter_app/features/widgets/vote_average_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/movie_details_bloc.dart';

class MovieDetailsPage extends StatelessWidget {
  const MovieDetailsPage({required this.id, super.key});

  static const pathParamKey = 'movieId';
  static const path = ':$pathParamKey';

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieDetailsBloc(id: id, moviesRepository: di()),
      child: _MovieDetailsPage(),
    );
  }
}

class _MovieDetailsPage extends StatelessWidget {
  const _MovieDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
      builder: (context, state) {
        return switch (state.movieDetails) {
          MovieDetailsLoading() => GenericLoadingWidget(),
          MovieDetailsFailed() => GenericErrorWidget(
            onRetryClicked: () {
              context.read<MovieDetailsBloc>().add(RetryEvent());
            },
          ),
          MovieDetailsSuccess(movieDetails: final movieDetails) =>
            _ContentWidget(
              movieDetails: movieDetails,
              favouriteWidget: _FavouriteWidget(),
            ),
        };
      },
    );
  }
}

class _ContentWidget extends StatelessWidget {
  const _ContentWidget({
    super.key,
    required this.movieDetails,
    required this.favouriteWidget,
  });

  final MovieDetails movieDetails;
  final Widget favouriteWidget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView(
        children: [
          PosterWidget(posterPath: "https://image.tmdb.org/t/p/w500${movieDetails.posterPath}"),
          Row(
            children: [
              Expanded(
                child: Text(
                  movieDetails.title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              favouriteWidget,
            ],
          ),
          SizedBox(height: 8),
          Text(
            movieDetails.tagline,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          SizedBox(height: 24),
          Text(movieDetails.overview),
          SizedBox(height: 8),
          VoteAverageWidget(voteAverage: movieDetails.voteAverage),
        ],
      ),
    );
  }
}

class _FavouriteWidget extends StatelessWidget {
  const _FavouriteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
      buildWhen:
          (previous, current) => previous.isFavourite != current.isFavourite,
      builder:
          (context, state) => FavouriteButtonWidget(
            onFavouriteClicked: () {
              context.read<MovieDetailsBloc>().add(
                ChangeMovieFavouriteStatusEvent(),
              );
            },
            isFavourite: state.isFavourite,
          ),
    );
  }
}
