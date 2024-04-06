import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_storage/get_storage.dart';
import 'package:store/data/exception/exception.dart';
import 'package:store/features/authentication/views/login/login.dart';
import 'package:store/utils/global_context/context_utils.dart';

class AuthenticationRepository {
  final _auth = FirebaseAuth.instance;
  AuthenticationRepository() {
    onReady();
  }

  // ! variable
  final deviceStorage = GetStorage();

  // ! call from main.dart on app launch
  onReady() async {
    FlutterNativeSplash.remove();
    // ! Local Storage
    await deviceStorage.writeIfNull("IsFirstTime", true);
  }

  // ! sign up data
  Future<UserCredential> signUpData(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
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

  // ! login in data
  Future<UserCredential> loginInWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
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

  // ! email verification
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
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

  // ! logout
  Future<void> logout() async {
    try {
      await _auth.signOut();
      Navigator.pushAndRemoveUntil(ContextUtility.context,
          MaterialPageRoute(builder: (_) => const Login()), (route) => false);
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
