import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/post.dart';
import '../providers/feed_provider.dart';

class StoriesList extends StatelessWidget {
  const StoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    final stories = context.watch<FeedProvider>().stories;

    if (stories.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      height: 105,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFEFEFEF), width: 1),
        ),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        itemCount: stories.length,
        itemBuilder: (context, index) {
          return _StoryItem(story: stories[index]);
        },
      ),
    );
  }
}

class _StoryItem extends StatelessWidget {
  final Story story;

  const _StoryItem({required this.story});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          story.isOwn ? _buildOwnStory() : _buildGradientRing(),
          const SizedBox(height: 4),
          SizedBox(
            width: 72,
            child: Text(
              story.username,
              style: const TextStyle(fontSize: 11, color: Colors.black),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradientRing() {
    return Container(
      width: 66,
      height: 66,
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
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      padding: const EdgeInsets.all(2.5),
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(2.5),
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: story.profileImage,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(color: Colors.grey[200]),
            errorWidget: (context, url, error) => const Icon(Icons.person),
          ),
        ),
      ),
    );
  }

  Widget _buildOwnStory() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          width: 66,
          height: 66,
          padding: const EdgeInsets.all(2),
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: story.profileImage,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(color: Colors.grey[200]),
              errorWidget: (context, url, error) => const Icon(Icons.person),
            ),
          ),
        ),
        Positioned(
          right: 2,
          bottom: 2,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: const Color(0xFF0095F6),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: const Icon(Icons.add, color: Colors.white, size: 14),
          ),
        ),
      ],
    );
  }
}
