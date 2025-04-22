import 'package:flutter/material.dart';
import 'package:flutter_app/di/di.dart';
import 'package:flutter_app/features/movies/bloc/movies_state.dart';
import 'package:flutter_app/features/movies/widgets/movie_list.dart';
import 'package:flutter_app/features/movies/widgets/movies_no_search_result_widget.dart';
import 'package:flutter_app/features/movies/widgets/movies_search_widget.dart';
import 'package:flutter_app/features/widgets/generic_error_widget.dart';
import 'package:flutter_app/features/widgets/generic_loading_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'bloc/movies_bloc.dart';
import 'bloc/movies_event.dart';

class MoviesPage extends StatelessWidget {
  const MoviesPage({super.key});

  static const path = '/movies';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoviesBloc(moviesRepository: di()),
      child: _MoviesPage(),
    );
  }
}

class _MoviesPage extends StatelessWidget {
  const _MoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
      child: Column(
        children: [
          BlocBuilder<MoviesBloc, MoviesState>(
            buildWhen:
                (previous, current) =>
                    previous.searchText != current.searchText,
            builder: (context, state) {
              return MoviesSearchWidget(initValue: state.searchText);
            },
          ),
          Expanded(child: _MoviesListWidget()),
        ],
      ),
    );
  }
}

class _MoviesListWidget extends StatelessWidget {
  const _MoviesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      buildWhen:
          (previous, current) =>
              previous.moviesListState != current.moviesListState,
      builder: (context, state) {
        if (state.shouldShowLoadingLayout()) {
          return GenericLoadingWidget();
        } else if (state.shouldShowErrorLayout()) {
          return GenericErrorWidget(
            onRetryClicked: () {
              context.read<MoviesBloc>().add(MoviesRetryEvent());
            },
          );
        } else if (state.shouldShowNoResultLayout()) {
          return MoviesNoSearchResultWidget();
        } else {
          //handled inside list
          return EndlessMoviesListWidget(
            onItemClicked: (int id) {
              context.push('${MoviesPage.path}/$id');
            },
            onFavouriteClicked: (int id) {
              context.read<MoviesBloc>().add(
                ChangeMovieFavouriteStatusEvent(id: id),
              );
            },
            onRetryClicked: () {
              context.read<MoviesBloc>().add(MoviesRetryEvent());
            },
            movies: state.moviesListState,
            onBottomOfPageReached: () {
              context.read<MoviesBloc>().add(MoviesBottomOfPageReachedEvent());
            },
          );
        }
      },
    );
  }
}

extension on MoviesState {
  bool shouldShowLoadingLayout() =>
      moviesListState.movies.isEmpty && moviesListState.isLoading;

  bool shouldShowErrorLayout() =>
      moviesListState.movies.isEmpty && moviesListState.isFailed;

  bool shouldShowNoResultLayout() =>
      moviesListState.movies.isEmpty &&
      moviesListState.isSuccess &&
      searchText.isNotEmpty;
}
