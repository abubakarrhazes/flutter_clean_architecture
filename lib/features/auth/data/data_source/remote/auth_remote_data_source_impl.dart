import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_clean_architecture/features/auth/data/data_source/remote/auth_remote_data_source.dart';
import 'package:flutter_clean_architecture/features/auth/domain/entities/user_entity.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../../core/const.dart';
import '../../models/user_model.dart';

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource{

  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFireStore;
  final FirebaseStorage firebaseStorage;


  AuthRemoteDataSourceImpl({required this.firebaseAuth,required this.firebaseStorage, required this.firebaseFireStore });




  @override
  Future<void> createNewUser(UserEntity user) async {
    final userCollection = firebaseFireStore.collection(Const.firebaseUser);
    final uid = await getCurrentId();
    userCollection.doc(uid).get().then((userDoc) {
      final newUser = UserModel(
          uid: user.uid,
          name: user.name,
          email: user.email,
          password: user.password)
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
  Future<String> getCurrentId() async => firebaseAuth.currentUser!.uid;

  @override
  Future<bool> isSignIn() {
    // TODO: implement isSignIn
    throw UnimplementedError();
  }

  @override
  Future<void> resetPassword(String email) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }
  @override
  Future<void> signIn(UserEntity user) async {
    try {
      if (user.email!.isNotEmpty && user.password!.isNotEmpty) {
        await firebaseAuth.createUserWithEmailAndPassword(
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
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<void> signUp(UserEntity user) {
    // TODO: implement signUp
    throw UnimplementedError();
  }








}