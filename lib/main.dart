import 'package:firebase_assig/screens/home_screen.dart';
import 'package:firebase_assig/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyChBrZNQyuWdhPvUT0B0_4cknDGJRHlzD8',
    appId: '1:240910362155:android:0208e5e274579fbce82c6e',
    messagingSenderId: '240910362155',
    projectId: 'todo-nic-assig',
    storageBucket: 'todo-nic-assig.appspot.com',
  ));


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase assignment',
      theme: ThemeData(
        appBarTheme:const  AppBarTheme(color: Colors.lightBlueAccent, centerTitle: true),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: (FirebaseAuth.instance != null &&
              FirebaseAuth.instance.currentUser!.emailVerified)
          ? const HomeScreen()
          : const LoginScreen(),
    );
  }
}
