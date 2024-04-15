import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store/data/exception/exception.dart';
import 'package:store/features/authentication/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  final _db = FirebaseFirestore.instance;

  // ! Funtion to save user to firestore
  Future<void> saveUserRecord(UserModel userModel) async {
    try {
      final user = await fetchUserDetails();
      if (user.id!.isEmpty) {
        await _db.collection("Users").doc(userModel.id).set(userModel.toJson());
      } else {
        return;
      }
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message!;
    } on FormatException catch (e) {
      throw SFormatException(e.message);
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message!;
    } catch (e) {
      throw "SomeThing went wrong. Please try again";
    }
  }

  // ! Funtion to fetch user details based on user ID
  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        return UserModel.fromJson(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FormatException catch (e) {
      throw SFormatException(e.message);
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message!;
    } catch (e) {
      throw "SomeThing went wrong. Please try again";
    }
  }

  // ! Function to update user data in firestore
  Future<void> updateUserDetails(UserModel updateUserModel) async {
    try {
      await _db
          .collection("Users")
          .doc(updateUserModel.id)
          .update(updateUserModel.toJson());
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message!;
    } on FormatException catch (e) {
      throw SFormatException(e.message);
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message!;
    } catch (e) {
      throw "SomeThing went wrong. Please try again";
    }
  }

  // ! Update any fields in specific Users Collection
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update(json);
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message!;
    } on FormatException catch (e) {
      throw SFormatException(e.message);
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message!;
    } catch (e) {
      throw "SomeThing went wrong. Please try again";
    }
  }

  // ! Funtion to remove user data from firestore

  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection("Users").doc(userId).delete();
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message!;
    } on FormatException catch (e) {
      throw SFormatException(e.message);
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message!;
    } catch (e) {
      throw "SomeThing went wrong. Please try again";
    }
  }

  // ! Upload any Image
  Future<String> uploadImage(String path, XFile image) async {
    try {
      String fileType = image.path.split('.').last;
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(
          File(image.path),
          SettableMetadata(
              contentType: 'images/$fileType',
              customMetadata: {'picked-file-path': image.path}));
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseAuthException catch (e) {
      throw SFirebaseAuthException(e.code).messages;
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message!;
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message!;
    } on FormatException catch (e) {
      throw SFormatException(e.message);
    } catch (e) {
      throw "SomeThing went wrong. Please try again.";
    }
  }
}
