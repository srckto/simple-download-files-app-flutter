import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BuildImage extends StatelessWidget {
  const BuildImage({
    Key? key,
    required this.url,
  }) : super(key: key);
  final String url;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      placeholder: (context, url) => Center(
        child: Text("Waiting.."),
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
      width: 83,
      height: 100,
      fit: BoxFit.cover,
    );
  }
}
