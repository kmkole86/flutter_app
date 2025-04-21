import 'package:flutter/material.dart';

class GenericErrorWidget extends StatelessWidget {
  final VoidCallback onRetryClicked;

  const GenericErrorWidget({super.key, required this.onRetryClicked});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
