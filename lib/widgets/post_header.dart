import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/post.dart';

class PostHeader extends StatelessWidget {
  final Post post;

  const PostHeader({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        children: [
          // Profile image
          Container(
            width: 38,
            height: 38,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Color(0xFFf09433),
                  Color(0xFFe6683c),
                  Color(0xFFdc2743),
                  Color(0xFFcc2366),
                  Color(0xFFbc1888),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: const EdgeInsets.all(2),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(2),
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: post.profileImage,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[200],
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.person,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          // Username + location
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.username,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          // More options
          GestureDetector(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.all(4),
              child: Icon(Icons.more_horiz, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
