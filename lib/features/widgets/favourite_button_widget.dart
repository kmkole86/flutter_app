import 'package:flutter/material.dart';

class FavouriteButtonWidget extends StatelessWidget {
  final VoidCallback onFavouriteClicked;
  final bool isFavourite;

  const FavouriteButtonWidget({
    super.key,
    required this.onFavouriteClicked,
    required this.isFavourite,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onFavouriteClicked,
      icon: Icon(
        isFavourite ? Icons.favorite_outlined : Icons.favorite_border_outlined,
      ),
    );
  }
}
