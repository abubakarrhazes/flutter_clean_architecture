import 'package:flutter_clean_architecture/features/auth/domain/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel extends UserEntity{
  final String? uid;
  final String? name;
  final String? email;
  final String? password;
  UserModel({
    this.uid,
    required this.name,
    required this.email,
    required this.password,
  }) : super(uid: uid, name: name, email: email, password: password);

  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
        uid: snapshot['uid'],
        name: snapshot['name'],
        email: snapshot['email'],
        password: snapshot['password']);
  }

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'name': name,
    'email': email,
    'password': password,
  };





}