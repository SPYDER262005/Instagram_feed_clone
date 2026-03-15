import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/post.dart';
import '../providers/feed_provider.dart';
import 'post_carousel.dart';
import 'post_caption.dart';
import 'post_actions.dart';

class PostWidget extends StatelessWidget {
  final Post post;

  const PostWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<FeedProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// POST HEADER
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: Colors.grey[200],
                backgroundImage: NetworkImage(post.profileImage),
              ),
              const SizedBox(width: 10),
              Text(
                post.username,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.more_horiz, size: 20),
                onPressed: () => _showPostOptions(context, post),
              )
            ],
          ),
        ),

        /// POST IMAGE / CAROUSEL
        PostCarousel(images: post.images),

        /// ACTION BUTTONS
        PostActions(post: post),

        /// CAPTION
        PostCaption(post: post),

        const SizedBox(height: 16),
      ],
    );
  }

  void _showPostOptions(BuildContext context, Post post) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Post options coming soon')));
  }
}
