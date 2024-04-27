import 'package:equatable/equatable.dart';

class UserEntity extends Equatable{
  final String? uid;
  final String? name;
  final String? email;
  final String? password;


  const UserEntity({this.uid, this.name, this.email, this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [
    uid,
    name,
    email,
    password,

  ];




}