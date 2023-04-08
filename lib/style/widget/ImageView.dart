
import 'package:betna/style/widget/skeleton.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  final String? image;
  final double width;
  final double height;
  final bool loading;
  final int index;
  final BoxFit fit;

  const ImageView(
      {Key? key,
      this.image,
      this.width = 210,
      this.height = 260,
      this.loading = true, this.index = 0, this.fit = BoxFit.fill})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CachedNetworkImage(
      errorWidget: (context, string, error) {
        return Container(
          child: Image.asset(
            'assets/images/with_text.png',
            height: height,
            width: width,
            fit: BoxFit.contain,
          ),
        );
      },
      placeholder: (context, string) {
        return Container(
          height: height,
          width: width,
          child: Center(
            child: Skeleton(showCircular: false,width: width,height: height,cornerRadius: 0.0,),
          ),
        );
      },
      fadeInCurve: Curves.bounceOut,
      imageUrl:image!,
      height: height,
      width: width,
      fit: fit,
    );
  }
}
