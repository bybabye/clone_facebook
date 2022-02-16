import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImageToStorage({
    required String name,
    required Uint8List file,
    required String id,
  }) async {
    Reference ref = _storage.ref().child(name).child(id);

    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snap = await uploadTask;

    String dowloadURL = await snap.ref.getDownloadURL();

    return dowloadURL;
  }

  Future<List<String>> uploadImagesToStorage({
    required String name,
    required List<XFile> file,
    required String id,
  }) async {
    List<String> images = [];

    for (int i = 0; i < file.length; i++) {
      Reference ref = _storage.ref().child(name).child(id).child(i.toString());

      UploadTask uploadTask = ref.putFile(File(file[i].path));

      TaskSnapshot snap = await uploadTask;

      String dowloadURL = await snap.ref.getDownloadURL();
      images.add(dowloadURL);
    }

    return images;
  }
}
