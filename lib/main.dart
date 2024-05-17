// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/pages/sign_up_screen.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/pages/splash_screen.dart';
import 'package:flutter_clean_architecture/firebase_options.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Foodie',
        debugShowCheckedModeBanner: false,
        home: SplashScreen());
  }
}
