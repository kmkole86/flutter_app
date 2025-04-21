import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/features/movies/bloc/movies_state.dart';
import 'package:flutter_app/features/widgets/favourite_button_widget.dart';
import 'package:flutter_app/features/widgets/poster_widget.dart';

class EndlessMoviesListWidget extends StatefulWidget {
  final void Function(int) onItemClicked;
  final void Function(int) onFavouriteClicked;
  final VoidCallback onRetryClicked;
  final VoidCallback onBottomOfPageReached;

  final MoviesState movies;

  const EndlessMoviesListWidget({
    super.key,
    required this.onItemClicked,
    required this.onFavouriteClicked,
    required this.onRetryClicked,
    required this.onBottomOfPageReached,
    required this.movies,
  });

  @override
  State<EndlessMoviesListWidget> createState() =>
      _EndlessMoviesListWidgetState();
}

class _EndlessMoviesListWidgetState extends State<EndlessMoviesListWidget> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController =
        ScrollController()..addListener(() {
          if (_scrollController.position.extentAfter < 300) {
            widget.onBottomOfPageReached();
          }
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: _scrollController,
      children: [
        ...widget.movies.movies.map(
          (e) => e.getWidget(
            onItemClicked: widget.onItemClicked,
            onFavouriteClicked: widget.onFavouriteClicked,
          ),
        ),
        ...widget.movies.getListTrailingWidget(
          onRetryClicked: widget.onRetryClicked,
        ),
      ],
    );
  }
}

class MovieItemWidget extends StatelessWidget {
  final Movie movie;
  final void Function(int) onItemClicked;
  final void Function(int) onFavouriteClicked;

  const MovieItemWidget({
    super.key,
    required this.movie,
    required this.onItemClicked,
    required this.onFavouriteClicked,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onItemClicked(movie.id);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: PosterWidget(posterPath: movie.posterPath),
              ),
              SizedBox(width: 16),
              Expanded(
                flex: 8,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            movie.title,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            movie.overview,
                            style: Theme.of(context).textTheme.bodySmall,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    FavouriteButtonWidget(
                      onFavouriteClicked: () {
                        onFavouriteClicked(movie.id);
                      },
                      isFavourite: movie.isFavourite,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MovieItemLoadingWidget extends StatelessWidget {
  const _MovieItemLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _MovieItemFailedWidget extends StatelessWidget {
  final VoidCallback onRetryClicked;

  const _MovieItemFailedWidget({super.key, required this.onRetryClicked});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(size: 54, Icons.error_outline),
        SizedBox(height: 8),
        Text(
          "Something went wrong. Please try again...",
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: SizedBox.shrink()),
            Expanded(
              child: FilledButton(
                onPressed: onRetryClicked,
                child: Text("Retry"),
              ),
            ),
            Expanded(child: SizedBox.shrink()),
          ],
        ),
      ],
    );
  }
}

extension MovieUiExtensions on Movie {
  MovieItemWidget getWidget({
    required void Function(int) onItemClicked,
    required void Function(int) onFavouriteClicked,
  }) => MovieItemWidget(
    key: ValueKey(id),
    movie: this,
    onItemClicked: onItemClicked,
    onFavouriteClicked: onFavouriteClicked,
  );
}

extension on MoviesState {
  List<Widget> getListTrailingWidget({required VoidCallback onRetryClicked}) {
    final List<Widget> widgets = [];
    switch (this) {
      case MoviesStateLoading():
        widgets.add(_MovieItemLoadingWidget(key: ValueKey(-1)));
      case MoviesStateFailed():
        widgets.add(
          _MovieItemFailedWidget(
            key: ValueKey(-2),
            onRetryClicked: onRetryClicked,
          ),
        );
      case MoviesStateSuccess():
        if (nextPageCursor != null) widgets.add(_MovieItemLoadingWidget());
    }
    return widgets;
  }
}
