import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/post_repository.dart';

class FeedProvider extends ChangeNotifier {
  final PostRepository _repo = PostRepository();

  List<Post> posts = [];
  List<Story> stories = [];
  bool isLoading = true;
  bool isLoadingMore = false;
  int _page = 0;

  Future<void> loadInitialPosts() async {
    isLoading = true;
    notifyListeners();

    _page = 0;
    posts = await _repo.fetchPosts(_page);
    stories = _repo.fetchStories();

    isLoading = false;
    notifyListeners();
  }

  Future<void> loadMorePosts() async {
    if (isLoadingMore) return;

    isLoadingMore = true;
    notifyListeners();

    _page++;
    final newPosts = await _repo.fetchPosts(_page);
    posts.addAll(newPosts);

    isLoadingMore = false;
    notifyListeners();
  }

  void toggleLike(Post post) {
    post.isLiked = !post.isLiked;
    notifyListeners();
  }

  void toggleSave(Post post) {
    post.isSaved = !post.isSaved;
    notifyListeners();
  }
}
