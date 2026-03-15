class Post {
  final String id;
  final String username;
  final String profileImage;
  final List<String> images;
  final String caption;
  final int likesCount;

  bool isLiked;
  bool isSaved;

  Post({
    required this.id,
    required this.username,
    required this.profileImage,
    required this.images,
    required this.caption,
    required this.likesCount,
    this.isLiked = false,
    this.isSaved = false,
  });
}

class Story {
  final String id;
  final String username;
  final String profileImage;
  final bool isOwn;

  const Story({
    required this.id,
    required this.username,
    required this.profileImage,
    this.isOwn = false,
  });
}
