import 'dart:typed_data';

import 'package:clone_facebook/day1/stf/home_page.dart';
import 'package:clone_facebook/module/user_app.dart';
import 'package:clone_facebook/service.dart/storage_service.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

// ignore: constant_identifier_names
const collection_user = "users";

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AuthencationProvider extends ChangeNotifier {
  late final FirebaseAuth _auth;
  late final FirebaseFirestore _db;
  late UserApp user;
  bool check = false;
  String avatar =
      "https://firebasestorage.googleapis.com/v0/b/facebook-80b4d.appspot.com/o/default%2Favatar.jpg?alt=media&token=7d7e80f0-652a-4577-8df9-5dfa64d483fd";
  String backgruond =
      "https://firebasestorage.googleapis.com/v0/b/facebook-80b4d.appspot.com/o/default%2Fbackground.jpg?alt=media&token=ed3d553a-679c-4595-bfb1-05ff7e2813b8";
  AuthencationProvider() {
    _auth = FirebaseAuth.instance;
    _db = FirebaseFirestore.instance;
    _auth.authStateChanges().listen((_user) async {
      if (_user != null) {
        DocumentSnapshot snapshot = await _db
            .collection(collection_user)
            .doc(_auth.currentUser!.uid)
            .get();
        user = UserApp.fromJson(snapshot.data() as Map<String, dynamic>);

        if (check == false) {
          navigatorKey.currentState!
              .push(MaterialPageRoute(builder: (_) => const HomePage()));
        }
      }
    });
  }

  Future<String> loginUser({
    required String email,
    required String pass,
  }) async {
    String res = "";
    try {
      if (email.isNotEmpty || pass.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(email: email, password: pass);
        res = 'success';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<UserApp> getUser({required String id}) async {
    UserApp user;

    DocumentSnapshot snapshot =
        await _db.collection(collection_user).doc(id).get();

    user = UserApp.fromJson(snapshot.data() as Map<String, dynamic>);

    return user;
  }

  Future<String> createUser({
    required String email,
    required String name,
    required String pass,
    required String phoneNumber,
  }) async {
    String res = "";
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      UserApp user = UserApp(
        id: cred.user!.uid,
        name: name,
        email: email,
        friends: [],
        bio: "",
        avatar: avatar,
        backgruond: backgruond,
        numberPhone: phoneNumber,
        status: Status.unknown,
        living: "",
        from: "",
        isActive: DateTime.now(),
      );

      _db.collection(collection_user).doc(cred.user!.uid).set(user.toJson());
      res = 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        res = 'The email is invalid';
      } else if (e.code == 'weak-password') {
        res = 'Password qua ngan';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> updateBio({required String bio}) async {
    String res = "";

    try {
      user.setBio = bio;

      await _db.collection(collection_user).doc(user.id).update({
        'bio': bio,
      });

      res = "success";
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future<String> updateLiving({required String living}) async {
    String res = "";

    try {
      user.setLiving = living;

      await _db.collection(collection_user).doc(user.id).update({
        'living': living,
      });

      res = "success";
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future<String> updateLocation({required String location}) async {
    String res = "";

    try {
      user.setFrom = location;

      await _db.collection(collection_user).doc(user.id).update({
        'from': location,
      });

      res = "success";
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future<String> updateStatus({required String status}) async {
    String res = "";
    Status _status;
    switch (status) {
      case 'singel':
        _status = Status.singel;
        break;
      case 'dating':
        _status = Status.dating;
        break;
      case 'research':
        _status = Status.research;
        break;
      case 'engaged':
        _status = Status.engaged;
        break;
      case "married":
        _status = Status.married;
        break;
      case "widow":
        _status = Status.widow;
        break;
      case "complicated":
        _status = Status.complicated;
        break;
      default:
        _status = Status.unknown;
    }

    try {
      user.setStatus = _status;

      await _db.collection(collection_user).doc(user.id).update({
        'status': status,
      });

      res = "success";
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future<String> change({
    required String name,
    required String id,
    required Uint8List file,
  }) async {
    String res = "";
    try {
      res = await StorageService()
          .uploadImageToStorage(name: name, file: file, id: id);

      await _db.collection(collection_user).doc(user.id).update({
        name: res,
      });
    } catch (e) {
      res = e.toString();
    }

    return res;
  }
}
