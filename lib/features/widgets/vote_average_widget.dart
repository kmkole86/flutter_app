import 'package:flutter/material.dart';

class VoteAverageWidget extends StatelessWidget {
  const VoteAverageWidget({super.key, required this.voteAverage});

  final double voteAverage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(Icons.star),
        Text(
          voteAverage.toString(),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 18),
        ),
      ],
    );
  }
}
