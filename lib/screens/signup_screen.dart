import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_assig/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool obscureText = true;

  final formKey = GlobalKey<FormState>();
  String? name, email, password, phone;


  var selectedGender;

  List<String> genderSelect = ['Male', 'Female'];

  @override
  void initState() {
    name;
    email;
    password;
    phone;
    super.initState();
  }

  @override
  void dispose() {
    name;
    email;
    password;
    phone;
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('SignUp'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
            key: formKey,
            child: ListView(
              children: [
                const Gap(16),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Please enter your name';
                    } else {
                      name = text.trim();
                      return null;
                    }
                  },
                ),
                const Gap(16),
                DropdownButtonFormField(
                  value: selectedGender,
                  decoration: const InputDecoration(
                    hintText: 'Select gender',
                    border: OutlineInputBorder(),
                  ),// assuming selectedGender is a variable holding the selected value
                  items: genderSelect.map((String val) {
                    return DropdownMenuItem(
                      value: val,
                      child: Text(val),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value; // assuming selectedGender is a variable in your stateful widget
                    });
                  },
                ),

                const Gap(16),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Email',
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
                  obscureText: true,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    hintText: 'Phone',
                    border: OutlineInputBorder(),
                  ),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Please enter your Phone No';
                    }
                    if (text.length < 11) {
                      return 'Enter valid Number';
                    } else {
                      phone = text.trim();
                      return null;
                    }
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
                    if (text.length < 6) {
                      return 'password must be grater then 6 digit';
                    }
                    password = text.trim();
                    return null;
                  },
                ),
                const Gap(16),
                ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        FirebaseAuth auth = FirebaseAuth.instance;
                        UserCredential? userCre =
                            await auth.createUserWithEmailAndPassword(
                                email: email.toString().trim(),
                                password: password.toString().trim());
                        if (userCre != null) {
                          // here we can store a data in firebaseDatabase.
                          FirebaseFirestore firebaseFirestore =
                              FirebaseFirestore.instance;
                          firebaseFirestore
                              .collection('users')
                              .doc(userCre.user!.uid)
                              .set({
                            'name': name.toString().trim(),
                            'mobile': phone.toString().trim(),
                            'gender': genderSelect.toString().trim(),
                            'email': email.toString().trim(),
                            'uid': userCre.user!.uid,
                            'createdOn': DateTime.now().millisecondsSinceEpoch,
                            'photo': null,
                          });

                          Fluttertoast.showToast(msg: 'Success', fontSize: 30);

                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                            return const LoginScreen();
                          }));
                        }
                      }
                    },
                    child: const Text('SignUp')),
                const Gap(16),
                TextButton(onPressed: () {}, child: const Text('Login Here!'))
              ],
            )),
      ),
    );
  }
}
