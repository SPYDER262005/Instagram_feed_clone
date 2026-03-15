import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/post.dart';
import '../providers/feed_provider.dart';

class PostActions extends StatelessWidget {
  final Post post;

  const PostActions({super.key, required this.post});

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontSize: 13),
        ),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<FeedProvider>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // Like button
              IconButton(
                padding: const EdgeInsets.all(8),
                constraints: const BoxConstraints(),
                icon: Icon(
                  post.isLiked ? Icons.favorite : Icons.favorite_border,
                  size: 26,
                  color: post.isLiked ? Colors.red : Colors.black,
                ),
                onPressed: () => provider.toggleLike(post),
              ),
              const SizedBox(width: 4),
              // Comment button
              IconButton(
                padding: const EdgeInsets.all(8),
                constraints: const BoxConstraints(),
                icon: const Icon(
                  Icons.chat_bubble_outline,
                  size: 24,
                  color: Colors.black,
                ),
                onPressed: () =>
                    _showSnackbar(context, 'Feature coming soon'),
              ),
              const SizedBox(width: 4),
              // Share button
              IconButton(
                padding: const EdgeInsets.all(8),
                constraints: const BoxConstraints(),
                icon: const Icon(
                  Icons.send_outlined,
                  size: 24,
                  color: Colors.black,
                ),
                onPressed: () =>
                    _showSnackbar(context, 'Feature coming soon'),
              ),
            ],
          ),
          // Save button
          IconButton(
            padding: const EdgeInsets.all(8),
            constraints: const BoxConstraints(),
            icon: Icon(
              post.isSaved ? Icons.bookmark : Icons.bookmark_border,
              size: 26,
              color: Colors.black,
            ),
            onPressed: () => provider.toggleSave(post),
          ),
        ],
      ),
    );
  }
}
