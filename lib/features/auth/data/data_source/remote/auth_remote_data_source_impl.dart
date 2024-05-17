import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_clean_architecture/features/auth/data/data_source/remote/auth_remote_data_source.dart';
import 'package:flutter_clean_architecture/features/auth/domain/entities/user_entity.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/pages/auth_otp_verification_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/const.dart';
import '../../models/user_model.dart';

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFireStore;
  final FirebaseStorage firebaseStorage;
  var verId = "".obs;

  AuthRemoteDataSourceImpl(
      {required this.firebaseAuth,
      required this.firebaseStorage,
      required this.firebaseFireStore});

  @override
  Future<void> createNewUser(UserEntity user) async {
    final userCollection = firebaseFireStore.collection(Const.firebaseUser);
    final uid = await getCurrentId();
    userCollection.doc(uid).get().then((userDoc) {
      final newUser =
          UserModel(name: user.name, email: user.email, password: user.password)
              .toJson();

      if (!userDoc.exists) {
        userCollection.doc(uid).set(newUser);
      } else {
        userCollection.doc(uid).update(newUser);
      }
    }).catchError((error) {
      //utils.successShowToast(context, error);

      print(error);
    });
  }

  @override
  Future<String> getCurrentId() async {
    return firebaseAuth.currentUser!.uid;
  }

  @override
  Future<bool> isSignIn() async {
    if (firebaseAuth.currentUser == null) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Future<void> resetPassword(String email) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<void> signIn(UserEntity user) async {
    try {
      if (user.email!.isNotEmpty || user.password!.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: user.email!, password: user.password!);
      } else {
        print('Fields Cant be Empty');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == Const.firebaseUserNotFound) {
        print(Const.firebaseUserNotFound);
      } else if (e.code == Const.firebaseWrongPasswordOrEmail) {
        print(Const.firebaseWrongPasswordOrEmail);
      }
    } catch (e) {}
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<void> signUp(UserEntity user) async {
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(
              email: user.email!, password: user.password!)
          .then((value) async {
        if (value.user?.uid != null) {
          await createNewUser(user);
        }
      });
      return;
    } on FirebaseAuthException catch (e) {
      if (e.code == Const.firebaseUserAlreadyExist) {
        print(Const.firebaseUserAlreadyExist);
      } else {
        print('Something Went Wrong');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<bool> checkUserStatus(String docId) async {
    final userCollection = firebaseFireStore.collection(Const.firebaseUser);
    var doc = await userCollection.doc(docId).get();
    return doc.exists;
  }

  @override
  Future<void> authOtpVerification(String otp) async {
    try {
      final AuthCredential authCredential = PhoneAuthProvider.credential(
          verificationId: verId.value, smsCode: otp);
      await firebaseAuth.signInWithCredential(authCredential);
      // Get.to(() => const UberHomePage());
    } on FirebaseAuthException catch (e) {
      Get.snackbar('error', e.code.toString());
    }
  }

  @override
  Future<void> authPhoneVerification(String phoneNumber) async {
    return await firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {},
      verificationFailed: (FirebaseAuthException e) {
        Get.snackbar('error', e.code.toString(),
            snackPosition: SnackPosition.BOTTOM);
      },
      codeSent: (String verificationId, int? forceResendingToken) async {
        verId.value = verificationId;
        Get.closeAllSnackbars();
        Get.snackbar('done', "otp sent to $phoneNumber");
        Get.to(() => const AuthOtpVerificationScreen());
      },
      codeAutoRetrievalTimeout: (String verificationId) async {},
    );
  }
  
  @override
  Future<String> addProfileImg(String userId) async {
    final profileImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    File _profileImage = File(profileImage!.path);
    await firebaseStorage
        .ref('UserProfileImages/$userId')
        .putFile(_profileImage);
    return await firebaseStorage
        .ref('UserProfileImages/$userId')
        .getDownloadURL();
  }
}
