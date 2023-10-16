// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/cscaffoldmessage.dart';
import 'package:chat_app/screens/signup_screen.dart';
import 'package:chat_app/widgets/custombutton.dart';
import 'package:chat_app/widgets/customtextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Form(
            key: formKey,
            child: ListView(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Image.asset(
                  kLogo,
                  width: 200,
                  height: 200,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Scholar Chat",
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily:
                            "assets/fonts/Inter-VariableFont_slnt,wght.ttf",
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Text(
                      ' Sign In',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  onChanged: (data) {
                    email = data;
                  },
                  labelText: 'Email',
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Field is required';
                    } else {}
                  },
                ),
                CustomTextField(
                  onChanged: (data) {
                    password = data;
                  },
                  labelText: 'Password',
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Field is required';
                    }
                  },
                  isObscure: true,
                ),
                CustomButton(
                  buttonName: 'Sign In',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        await signInUser();
                        CustomScaffoldMessenger(
                            context, 'Sign In Successfully 😊 ✔');
                        Navigator.pushNamed(context, 'chatScreen',
                            arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code.toString() == 'user-not-found') {
                          CustomScaffoldMessenger(
                              context, 'No user found for that email.');
                        } else if (e.code.toString() == 'wrong-password') {
                          CustomScaffoldMessenger(context,
                              'Wrong password provided for that user.');
                        } else {
                          CustomScaffoldMessenger(context, e.code);
                        }
                      } catch (e) {
                        CustomScaffoldMessenger(context, e.toString());
                      }
                      setState(() {
                        isLoading = false;
                      });
                    } else {}
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account ? ',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, SignUpScreen.id);
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 85, 189, 253),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signInUser() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
