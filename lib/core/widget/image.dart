import 'dart:io';
import 'package:lottie/lottie.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MSvg extends StatelessWidget {
  final String? name;
  final double width;
  final double height;
  final BoxFit fit;
  final Color? color;
  const MSvg({
    Key? key,
    this.name,
    this.height = 25,
    this.width = 25,
    this.fit = BoxFit.contain,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      name!,
      width: width,
      height: height,
      fit: fit,
      color: color,
    );
  }
}

class MAssetImage extends StatelessWidget {
  final String? name;
  final double width;
  final double height;
  final BoxFit fit;
  final Color? color;
  final double borderRadius;
  const MAssetImage({
    Key? key,
    this.borderRadius = 0,
    this.name,
    this.height = 25,
    this.width = 25,
    this.fit = BoxFit.contain,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.asset(
        name!,
        width: width,
        height: height,
        fit: fit,
        color: color,
        alignment: Alignment.topCenter,
      ),
    );
  }
}

class MFileImage extends StatelessWidget {
  final String file;
  final double width;
  final double height;
  final BoxFit fit;
  final Color? color;
  final double borderRadius;
  const MFileImage({
    Key? key,
    this.borderRadius = 0,
    required this.file,
    this.height = 25,
    this.width = 25,
    this.fit = BoxFit.contain,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.file(
        File(file),
        width: width,
        height: height,
        fit: fit,
        color: color,
        alignment: Alignment.topCenter,
      ),
    );
  }
}

class MNetworkImage extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final BoxFit fit;
  final Color? color;
  final double borderRadius;
  const MNetworkImage({
    Key? key,
    this.borderRadius = 0,
    this.url = "",
    this.height = 25,
    this.width = 25,
    this.fit = BoxFit.contain,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (url.contains('http')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: CachedNetworkImage(
          imageUrl: url,
          width: width,
          height: height,
          fit: fit,
          color: color,
          alignment: Alignment.center,
          errorWidget: (errorWidget, error, child) {
            return MSvg(
              name: 'assets/icons/empty-icon.svg',
              width: width,
              height: height,
              fit: fit,
              color: color,
            );
          },
          placeholder: (context, provider) => const SizedBox(
            width: 22.0,
            height: 22.0,
            child: Center(
              child: SpinKitPouringHourGlass(
                color: Colors.white,
                duration: Duration(milliseconds: 1200),
              ),
            ),
          ),
        ),
      );
    } else {
      return MAssetImage(
        name: 'assets/no-image.png',
        width: width,
        height: height,
        fit: fit,
        color: color,
        borderRadius: borderRadius,
      );
    }
  }
}

class MLottie extends StatelessWidget {
  final double? width;
  final double? height;
  final BoxFit? fit;
  final String name;
  const MLottie({
    super.key,
    required this.name,
    this.fit,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return LottieBuilder.asset(
      name,
      height: height,
      width: width,
      fit: fit,
    );
  }
}
