import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserProfileImage extends StatelessWidget {
  final String? imageURL;
  final double radius;
  final bool showStatusDot;
  final Color? statusDotColor;

  const UserProfileImage({
    super.key,
    required this.imageURL,
    required this.radius,
    required this.showStatusDot,
    this.statusDotColor,
  });

  ImageProvider get image {
    if (imageURL != null) {
      return CachedNetworkImageProvider(imageURL!);
    } else {
      return const AssetImage("images/default_profile.png");
    }
  }

  Widget buildStatusDot() {
    if (statusDotColor == null) {
      return Container();
    } else {
      return Container(
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.white),
          borderRadius: BorderRadius.circular(90.0),
          color: statusDotColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(radius: radius, backgroundImage: image),
        if (showStatusDot)
          Positioned(right: 0, bottom: 0, child: buildStatusDot()),
      ],
    );
  }
}
