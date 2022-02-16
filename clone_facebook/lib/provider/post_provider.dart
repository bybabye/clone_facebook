import 'package:clone_facebook/module/post.dart';
import 'package:clone_facebook/module/post_and_user.dart';
import 'package:clone_facebook/module/user_app.dart';
import 'package:clone_facebook/provider/auth_provider.dart';
import 'package:clone_facebook/service.dart/storage_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class PostProvider extends ChangeNotifier {
  final AuthencationProvider _auth;
  late final FirebaseFirestore _db;
  final String collection_post = "posts";
  List<PostAndUser> posts = [];
  String error = "";
  PostProvider(this._auth) {
    _db = FirebaseFirestore.instance;
    getPost();
  }

  Future<String> post({
    required List<XFile> files,
    required String bio,
  }) async {
    String res = "";

    try {
      String idPost = const Uuid().v1();
      List<String> images = [];
      images = await StorageService()
          .uploadImagesToStorage(name: "Post", file: files, id: idPost);
      Post post = Post(
        id: _auth.user.id,
        idPost: idPost,
        bio: bio,
        images: images,
        likes: [],
        datePost: DateTime.now(),
      );
      await _db.collection(collection_post).doc(idPost).set(post.toJson());
      res = "success";
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  void getPost() async {
    try {
      QuerySnapshot snapshot = await _db
          .collection(collection_post)
          .orderBy('datePost', descending: true)
          .get();
      if (snapshot.docs.isNotEmpty) {
        posts = await Future.wait(snapshot.docs.map((e) async {
          Post post = Post.formJson(e.data() as Map<String, dynamic>);
          UserApp user = await _auth.getUser(id: e['id']);
          return PostAndUser(
            user: user,
            post: post,
          );
        }).toList());
        notifyListeners();
      }
    } catch (e) {
      error = e.toString();
    }
  }

  @override
  void dispose() {
    super.dispose();
    getPost();
  }
}
