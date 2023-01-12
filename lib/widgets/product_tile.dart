import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../models/product.dart';
import 'custom_cached_network_image_widget.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({
    Key? key,
    required this.prod,
    required this.onTap,
  }) : super(key: key);

  final Product prod;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.symmetric(horizontal: 7.5, vertical: 7.5),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CustomCachedNetworkImageWidget(imageUrl: prod.thumbnail),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    prod.title,
                    maxLines: 2,
                  ),
                ),
                const SizedBox(width: 10),
                Text("₹ ${prod.price}"),
              ],
            ),
            RatingBar.builder(
              initialRating: prod.rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemSize: 15,
              itemCount: 5,
              ignoreGestures: true,
              itemBuilder: (context, _) =>
                  const Icon(Icons.star, color: Colors.amber),
              onRatingUpdate: (rating) {},
            ),
          ],
        ),
      ),
    );
  }
}
