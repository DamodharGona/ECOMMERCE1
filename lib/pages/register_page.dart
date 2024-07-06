import 'package:ecommerce/components/my_button.dart';
import 'package:ecommerce/components/mytext_field.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({
    super.key,
    required this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    void showErrorMessage(String message) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.grey.shade300,
              title: Text(message),
              titleTextStyle: const TextStyle(color: Colors.white),
            );
          });
    }

    void signUpUser() async {
      showDialog(
          context: context,
          builder: (context) {
            return Center(child: CircularProgressIndicator());
          });
      try {
        if (passwordController.text == confirmPasswordController.text) {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );
        } else {
          showErrorMessage('password do not match');
        }
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        showErrorMessage(e.code);
      }
    }

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          const Text(
            'REGISTER PAGE',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          MyTextField(
            controller: emailController,
            text: 'enter your email',
            prefixIcon: null,
          ),
          const SizedBox(
            height: 25,
          ),
          MyTextField(
            controller: passwordController,
            text: 'enter your password',
            prefixIcon: null,
          ),
          const SizedBox(
            height: 25,
          ),
          MyTextField(
            controller: confirmPasswordController,
            text: 'confirm your password',
            prefixIcon: null,
          ),
          const SizedBox(
            height: 50,
          ),
          MyButton(
            text: 'Register',
            onPressed: signUpUser,
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text('Already have an account? '),
              GestureDetector(
                onTap: widget.onTap, // Corrected this line
                child: const Text(
                  'Login ',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
