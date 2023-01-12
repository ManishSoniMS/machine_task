import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:machine_task/bloc/product_details/product_details_cubit.dart';

import '../widgets/image_slider_widget.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
              builder: (context, state) {
                return state.map(
                  initial: (_) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  loaded: (loaded) {
                    final prod = loaded.product;
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          ImageSliderWidget(images: prod.images),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        prod.title,
                                        maxLines: 2,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      "₹ ${prod.price}",
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: RatingBar.builder(
                                    initialRating: prod.rating,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemSize: 15,
                                    itemCount: 5,
                                    ignoreGestures: true,
                                    itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.amber),
                                    onRatingUpdate: (rating) {},
                                  ),
                                ),
                                const SizedBox(height: 40),
                                Text(
                                  "Description",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(height: 40),
                                Text(
                                  prod.description,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  error: (error) {
                    return Center(
                      child: Text(error.failure.message),
                    );
                  },
                );
              },
            ),
            Positioned(
              top: 10,
              left: 10,
              child: CircleAvatar(
                backgroundColor: Colors.black,
                child: BackButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
