import 'package:flutter/material.dart';
import '../models/post.dart';

class PostCaption extends StatelessWidget {
  final Post post;

  const PostCaption({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Likes count
          Text(
              '${_formatCount(post.likesCount)} likes',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          // Caption
          RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black, fontSize: 13),
              children: [
                TextSpan(
                  text: post.username,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const TextSpan(text: '  '),
                TextSpan(text: post.caption),
              ],
            ),
          ),
          const SizedBox(height: 4),
          // Time
          Text(
            '2 hours ago',
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  String _formatCount(int count) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(count % 1000 == 0 ? 0 : 1)}K';
    }
    return count.toString();
  }
}
