class Post {
  final String id;
  final String idPost;
  final List<String> images;
  String? bio;
  final List<String> likes;
  final DateTime datePost;
  Post({
    required this.id,
    required this.idPost,
    required this.bio,
    required this.images,
    required this.likes,
    required this.datePost,
  });

  set setBio(String _bio) => bio = _bio;

  factory Post.formJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      idPost: json['idPost'],
      bio: json['bio'],
      images: json['images'],
      likes: json['likes'],
      datePost: json['datePost'].toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idPost': idPost,
      'images': images,
      'bio': bio,
      'likes': likes,
      'datePost': datePost,
    };
  }
}
