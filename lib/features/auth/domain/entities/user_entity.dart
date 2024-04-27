import 'package:equatable/equatable.dart';

class User extends Equatable{
  final String? uid;
  final String? name;
  final String? email;
  final String? password;


  User({this.uid, this.name, this.email, this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [
    uid,
    name,
    email,
    password,
    
  ];




}