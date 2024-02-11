import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email, password;
  final formKey = GlobalKey<FormState>();

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
                    border: OutlineInputBorder(),
                  ),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")),
                  ],
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
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  validator: (text){
                    if(text == null || text.isEmpty){
                      return 'Please enter your password';
                    }
                    password = text.trim();
                    return null;
                  },
                ),
                const Gap(16),
                ElevatedButton(onPressed: () {

                }, child: const Text('Login')),
                const Gap(16),
                TextButton(onPressed: () {}, child: const Text('SignUp Here!'))
              ],
            )),
      ),
    );
  }
}
