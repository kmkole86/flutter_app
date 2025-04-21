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
    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (context, state) {
        //handled in the main layout
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              MoviesSearchWidget(initValue: state.searchText),
              Expanded(child: _MoviesListWidget(state: state)),
            ],
          ),
        );
      },
    );
  }
}

class _MoviesListWidget extends StatelessWidget {
  const _MoviesListWidget({required this.state, super.key});

  final MoviesState state;

  @override
  Widget build(BuildContext context) {
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
        movies: state,
        onBottomOfPageReached: () {
          context.read<MoviesBloc>().add(MoviesBottomOfPageReachedEvent());
        },
      );
    }
  }
}

extension on MoviesState {
  bool shouldShowLoadingLayout() => movies.isEmpty && isLoading;

  bool shouldShowErrorLayout() => movies.isEmpty && isFailed;

  bool shouldShowNoResultLayout() =>
      movies.isEmpty && isSuccess && searchText.isNotEmpty;
}
