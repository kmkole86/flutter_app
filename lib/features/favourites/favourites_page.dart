import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/di/di.dart';
import 'package:flutter_app/features/favourites/bloc/favourites_bloc.dart';
import 'package:flutter_app/features/favourites/bloc/favourites_event.dart';
import 'package:flutter_app/features/movies/widgets/movie_list.dart';
import 'package:flutter_app/features/widgets/generic_loading_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'bloc/favourites_state.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({super.key});

  static const path = '/favourites';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavouritesBloc(moviesRepository: di()),
      child: _FavouritesPage(),
    );
  }
}

class _FavouritesPage extends StatelessWidget {
  const _FavouritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouritesBloc, FavouritesState>(
      builder: (context, state) {
        //handled in the main layout
        return switch (state) {
          FavouritesStatusLoading() => GenericLoadingWidget(),
          FavouritesStatusSuccess(movies: final favourites) =>
            favourites.isEmpty
                ? _FavouritesEmptyStateWidget()
                : _FavouritesListWidget(movies: state.movies),
        };
      },
    );
  }
}

class _FavouritesListWidget extends StatelessWidget {
  const _FavouritesListWidget({super.key, required this.movies});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView(
        children:
            movies
                .map(
                  (e) => e.getWidget(
                    onItemClicked: (int id) {
                      context.push('${FavouritesPage.path}/$id');
                    },
                    onFavouriteClicked: (int id) {
                      context.read<FavouritesBloc>().add(
                        ChangeMovieFavouriteStatusEvent(id: id),
                      );
                    },
                  ),
                )
                .toList(),
      ),
    );
  }
}

class _FavouritesEmptyStateWidget extends StatelessWidget {
  const _FavouritesEmptyStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("You have no favourites."));
  }
}
