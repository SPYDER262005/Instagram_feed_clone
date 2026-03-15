import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/feed_provider.dart';
import '../widgets/stories_list.dart';
import '../widgets/post_widget.dart';
import '../widgets/shimmer_feed.dart';

class HomeFeedScreen extends StatefulWidget {
  const HomeFeedScreen({super.key});

  @override
  State<HomeFeedScreen> createState() => _HomeFeedScreenState();
}

class _HomeFeedScreenState extends State<HomeFeedScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final provider = context.read<FeedProvider>();
    // Load next page when 2 posts away (approx 1500px) from the bottom
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 1500) {
      provider.loadMorePosts();
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FeedProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: RefreshIndicator(
        onRefresh: () => provider.loadInitialPosts(),
        color: Colors.black,
        child: provider.isLoading
            ? const ShimmerFeed()
            : ListView.builder(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: provider.posts.length + 2, // +2: stories header + bottom loader/spacing
                itemBuilder: (context, index) {
                  // Story index
                  if (index == 0) {
                    return const StoriesList();
                  }

                  // Loader index
                  if (index == provider.posts.length + 1) {
                    return provider.isLoadingMore
                        ? const Padding(
                            padding: EdgeInsets.symmetric(vertical: 24),
                            child: Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.grey,
                              ),
                            ),
                          )
                        : const SizedBox(height: 50);
                  }

                  // Post index
                  final postIndex = index - 1;
                  final post = provider.posts[postIndex];
                  return PostWidget(post: post);
                },
              ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0.5,
      surfaceTintColor: Colors.white,
      title: const Text(
        'Instagram',
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          fontFamily: 'serif', // Simulate Instagram font
          color: Colors.black,
        ),
      ),
      centerTitle: false,
      actions: [
        IconButton(
          icon: const Icon(Icons.favorite_border, color: Colors.black),
          onPressed: () {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Notifications feature coming soon')));
          },
        ),
        IconButton(
          icon: const Icon(Icons.maps_ugc_outlined, color: Colors.black), // Messenger icon approximation
          onPressed: () {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Messages feature coming soon')));
          },
        ),
      ],
    );
  }
}
