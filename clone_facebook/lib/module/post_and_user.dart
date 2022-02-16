import 'package:clone_facebook/module/post.dart';
import 'package:clone_facebook/module/user_app.dart';

class PostAndUser {
  final UserApp user;
  final Post post;

  PostAndUser({
    required this.user,
    required this.post,
  });

  factory PostAndUser.fromJson(Map<String, dynamic> json) {
    return PostAndUser(user: json['user'], post: json['post']);
  }
}
