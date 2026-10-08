import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../generated/app_assets.dart';
import '../theme/app_colors.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({
    super.key,
    required this.imgUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  final String? imgUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadiusGeometry? borderRadius;

  static ImageProvider getProvider(String? imgUrl) {
    if (imgUrl?.trim().isEmpty ?? true) {
      return AppAssets.images.fallbackUserImage.provider();
    }
    return CachedNetworkImageProvider(imgUrl!);
  }

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    if (imgUrl?.trim().isEmpty ?? true) {
      imageWidget = AppAssets.images.fallbackUserImage.image(
        width: width,
        height: height,
        fit: fit,
      );
    } else {
      imageWidget = CachedNetworkImage(
        imageUrl: imgUrl!,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: AppColors.shimmerBaseColor,
          highlightColor: AppColors.shimmerHighlightColor,
          child: Container(
            width: width ?? 50,
            height: height ?? 50,
            color: Colors.white,
          ),
        ),
        errorWidget: (context, url, error) => AppAssets.images.fallbackUserImage
            .image(width: width, height: height, fit: fit),
      );
    }

    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius!, child: imageWidget);
    }

    return imageWidget;
  }
}
