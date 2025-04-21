import 'package:flutter/material.dart';

class PosterWidget extends StatelessWidget {
  const PosterWidget({super.key, required this.posterPath});

  final String? posterPath;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.67,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), // Adjust the radius as needed
        ),
        child: Image.network(
          "https://image.tmdb.org/t/p/w500$posterPath",
          errorBuilder: (_, _, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(Icons.error_outline), Text("Error")],
            );
          },
          loadingBuilder: (
            BuildContext context,
            Widget child,
            ImageChunkEvent? loadingProgress,
          ) {
            if (loadingProgress == null) return child;
            return Center(
              child: SizedBox(
                width: 25,
                height: 25,
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}
