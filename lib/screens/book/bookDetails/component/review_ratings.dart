import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final int rating;
  final double size;

  const StarRating({super.key, required this.rating, this.size = 24.0});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
        (index) {
          if (index < rating) {
            return Icon(Icons.star, size: size, color: Colors.amber);
          } else {
            return Icon(Icons.star_border, size: size, color: Colors.grey);
          }
        },
      ),
    );
  }
}
