import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomCachedNetworkImageWidget extends StatelessWidget {
  const CustomCachedNetworkImageWidget({
    Key? key,
    required this.imageUrl,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      height: height ?? double.infinity,
      width: width ?? double.infinity,
      errorWidget: (context, _, __) {
        return CachedNetworkImage(
          imageUrl:
              "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg?20200913095930",
          fit: fit,
          height: height ?? double.infinity,
          width: width ?? double.infinity,
        );
      },
      progressIndicatorBuilder: (context, _, __) {
        return SizedBox.expand(
          child: Shimmer.fromColors(
            baseColor: Theme.of(context).colorScheme.tertiaryContainer,
            highlightColor:
                Theme.of(context).colorScheme.secondary.withOpacity(0.9),
            child: Container(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        );
      },
    );
  }
}
