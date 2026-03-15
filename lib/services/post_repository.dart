import '../models/post.dart';

class PostRepository {
  Future<List<Post>> fetchPosts(int page) async {
    // Force a 1.5-second delay to demonstrate Shimmer Loading State
    await Future.delayed(const Duration(milliseconds: 1500));

    // Profile photos
    const profileImages = [
      "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200&h=200&fit=crop",
      "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200&h=200&fit=crop",
      "https://images.unsplash.com/photo-1527980965255-d3b416303d12?w=200&h=200&fit=crop",
      "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=200&h=200&fit=crop",
      "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=200&h=200&fit=crop",
      "https://images.unsplash.com/photo-1552058544-f2b08422138a?w=200&h=200&fit=crop",
    ];

    // User provided high-quality images - optimized for feed loading
    const userImages = [
      "https://images.unsplash.com/photo-1771926623926-a644527a40dc?w=800&auto=format&fit=crop&q=80",
      "https://images.unsplash.com/photo-1773398348702-500c3d26a6c1?w=800&auto=format&fit=crop&q=80",
      "https://images.unsplash.com/photo-1769583662086-9d1021c752e4?w=800&auto=format&fit=crop&q=80",
      "https://images.unsplash.com/photo-1764760764875-bae4e3a58835?w=800&auto=format&fit=crop&q=80",
      "https://images.unsplash.com/photo-1773083405790-20dd0bed4786?w=800&auto=format&fit=crop&q=80",
      "https://images.unsplash.com/photo-1764591696199-86732185c728?w=800&auto=format&fit=crop&q=80",
      "https://images.unsplash.com/photo-1772436756247-8c15cb5149f0?w=800&auto=format&fit=crop&q=80",
      "https://plus.unsplash.com/premium_photo-1772955479826-614b2b120b78?w=800&auto=format&fit=crop&q=80",
      "https://images.unsplash.com/photo-1772955527473-14ab0ae328af?w=800&auto=format&fit=crop&q=80",
      "https://images.unsplash.com/photo-1772955504930-55f0b0d032da?w=800&auto=format&fit=crop&q=80",
      "https://plus.unsplash.com/premium_photo-1772390760078-c337d4f62a0a?w=800&auto=format&fit=crop&q=80",
      "https://images.unsplash.com/photo-1772349289428-361ef4c0c0bd?w=800&auto=format&fit=crop&q=80",
      "https://images.unsplash.com/photo-1772748128689-ea22ff78cd3e?w=800&auto=format&fit=crop&q=80",
      "https://images.unsplash.com/photo-1769708526549-05310c4ade1d?w=800&auto=format&fit=crop&q=80",
      "https://images.unsplash.com/photo-1772441849348-c99fcd2dd2dc?w=800&auto=format&fit=crop&q=80",
      "https://images.unsplash.com/photo-1770110628704-86ba8c7b3b1c?w=800&auto=format&fit=crop&q=80",
    ];

    // Mix of single and carousel posts
    final List<List<String>> postImagesList = List.generate(userImages.length, (i) {
      if (i % 4 == 0) {
        return [
          userImages[i],
          userImages[(i + 1) % userImages.length],
        ];
      }
      return [userImages[i]];
    });

    const usernames = [
      "travel_enthusiast",
      "nature_seeker",
      "urban_explorer",
      "wanderlust_spirit",
      "daily_discoveries",
      "horizon_chaser",
    ];

    const captions = [
      "Stunning views that take your breath away ✨",
      "Just another day in paradise 🌿",
      "Finding beauty in every corner of the world 🌍",
      "Moments like these are why I travel 🚀",
      "The golden hour hits differently here 🌅",
      "Exploring the unexplored 🗺️",
    ];

    return List.generate(10, (index) {
      final dataIndex = (page * 10 + index);
      final imgIndex = dataIndex % postImagesList.length;
      final userIndex = dataIndex % usernames.length;
      final profileIndex = dataIndex % profileImages.length;
      final captionIndex = dataIndex % captions.length;

      return Post(
        id: "post_${page}_$index",
        username: usernames[userIndex],
        profileImage: profileImages[profileIndex],
        images: postImagesList[imgIndex],
        caption: captions[captionIndex],
        likesCount: (index + 1) * 324 + (page * 150),
      );
    });
  }

  List<Story> fetchStories() {
    const profileImages = [
      "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200&h=200&fit=crop",
      "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200&h=200&fit=crop",
      "https://images.unsplash.com/photo-1527980965255-d3b416303d12?w=200&h=200&fit=crop",
      "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=200&h=200&fit=crop",
      "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=200&h=200&fit=crop",
      "https://images.unsplash.com/photo-1552058544-f2b08422138a?w=200&h=200&fit=crop",
    ];

    const usernames = [
      "Your Story",
      "travel_diary",
      "nature_love",
      "city_night",
      "wild_life",
      "ocean_breeze",
    ];

    return List.generate(usernames.length, (index) {
      return Story(
        id: "story_$index",
        username: usernames[index],
        profileImage: profileImages[index],
        isOwn: index == 0,
      );
    });
  }
}
