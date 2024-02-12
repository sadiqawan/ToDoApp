import 'package:firebase_assig/screens/home_screen.dart';
import 'package:firebase_assig/screens/signup_screen.dart';
import 'package:firebase_assig/screens/verification_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscureText = true;
  String? email, password;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    email;
    password;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
            key: formKey,
            child: ListView(
              children: [
                const Gap(16),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Please provide value';
                    }
                    email = text.trim();
                    return null;
                  },
                ),
                const Gap(16),
                TextFormField(
                  obscureText: obscureText,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                        icon: Icon(
                          obscureText ? Icons.visibility_off : Icons.visibility,
                        )),
                    border: const OutlineInputBorder(),
                  ),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Please enter your password';
                    }
                    password = text.trim();
                    return null;
                  },
                ),
                const Gap(16),
                ElevatedButton(
                    onPressed: () async {
                      try {
                        if (formKey.currentState!.validate()) {
                          FirebaseAuth auth = FirebaseAuth.instance;
                          UserCredential userCre = await auth.signInWithEmailAndPassword(
                            email: email.toString(),
                            password: password.toString(),
                          );
                          if (userCre.user!.emailVerified) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => const HomeScreen()),
                            );
                          } else {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                              return const VerificationScreen();
                            }));
                          }
                        }
                    } on FirebaseAuthException catch(e){
                      Fluttertoast.showToast(msg: e.message!, fontSize: 25 );
                    }
                    },
                    child: const Text('Login')),
                const Gap(16),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SignupScreen()));
                    },
                    child: const Text('SignUp Here!'))
              ],
            )),
      ),
    );
  }
}
