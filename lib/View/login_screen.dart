import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ViewModel/AuthProvider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confPasswordController = TextEditingController();

  FocusNode myFocusNodeEmail = FocusNode();
  FocusNode myFocusNodePassword = FocusNode();
  FocusNode myFocusNodeConfPassword = FocusNode();

  final _formKey = GlobalKey<FormState>();
  //Handling signup and signin
  bool signUp = true;

  @override
  void initState() {
    super.initState();
    myFocusNodeEmail.addListener(() {
      setState(() {});
    });

    myFocusNodePassword.addListener(() {
      setState(() {});
    });
    myFocusNodeConfPassword.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    myFocusNodePassword.dispose();
    myFocusNodeEmail.dispose();
    passwordController.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // backgroundColor: Colors.purple,
        title: Text(
          "Interview Preparation",
        ),
        shape: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(24))),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Text(
                  //   "Interview Preparation",
                  //   style: TextStyle(
                  //       color: Colors.black,
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 15),
                  // ),
                  Image.asset(
                    "asset/19197061.jpg",
                    height: 250,
                    // color: Colors.blue,
                    width: MediaQuery.of(context).size.width,
                  ),

                  TextFormField(
                    controller: emailController,
                    focusNode: myFocusNodeEmail,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.2),
                        prefixIcon: Icon(
                          Icons.email,
                          color: myFocusNodeEmail.hasFocus
                              ? Colors.blue
                              : Colors.grey.shade600,
                        ),
                        focusColor: Colors.blue,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        labelText: "Email",
                        labelStyle: TextStyle(
                          color: myFocusNodeEmail.hasFocus
                              ? Colors.blue
                              : Colors.grey.shade600,
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Email address';
                      }
                      return null;
                    },
                  ),

                  //password textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      controller: passwordController,
                      focusNode: myFocusNodePassword,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.withOpacity(0.2),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: myFocusNodePassword.hasFocus
                                ? Colors.blue
                                : Colors.grey.shade600,
                          ),
                          focusColor: Colors.blue,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          labelText: "Password",
                          labelStyle: TextStyle(
                            color: myFocusNodePassword.hasFocus
                                ? Colors.blue
                                : Colors.grey.shade600,
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Password';
                        }
                        return null;
                      },
                    ),
                  ),
                  signUp
                      ? Column(
                          children: [
                            TextFormField(
                                controller: confPasswordController,
                                focusNode: myFocusNodeConfPassword,
                                obscureText: true,
                                enableSuggestions: false,
                                autocorrect: false,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey.withOpacity(0.2),
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: myFocusNodeConfPassword.hasFocus
                                          ? Colors.blue
                                          : Colors.grey.shade600,
                                    ),
                                    focusColor: Colors.blue,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue),
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    labelText: "Conform Password",
                                    labelStyle: TextStyle(
                                      color: myFocusNodeConfPassword.hasFocus
                                          ? Colors.blue
                                          : Colors.grey.shade600,
                                    )),
                                validator: (val) {
                                  if (val!.isEmpty) return 'Empty';
                                  if (val != passwordController.text)
                                    return 'Not Match';
                                  return null;
                                }),
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Text("or"),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Divider(),
                            ),
                            InkWell(
                              onTap: () {
                                context
                                    .read<AuthenticationProvider>()
                                    .signInWithGoogle();
                              },
                              child: Ink(
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(24)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          "asset/google.png",
                                          height: 30,
                                          width: 30,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Text("Sign in with Google"),
                                        )
                                      ]),
                                ),
                              ),
                            )
                          ],
                        )
                      : SizedBox.shrink(),

                  //Sign in / Sign up button
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                                fixedSize: Size.fromHeight(45),
                                // backgroundColor: Colors.blue,
                                // foregroundColor: Colors.white,
                                shape: StadiumBorder()),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (signUp) {
                                  //Provider sign up method
                                  context.read<AuthenticationProvider>().signUp(
                                        context,
                                        email: emailController.text.trim(),
                                        password:
                                            passwordController.text.trim(),
                                      );
                                } else {
                                  //Provider sign in method
                                  context.read<AuthenticationProvider>().signIn(
                                        context,
                                        email: emailController.text.trim(),
                                        password:
                                            passwordController.text.trim(),
                                      );
                                }
                              }
                            },
                            child: signUp ? Text("Sign Up") : Text("Sign In"),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Sign up / Sign In toggler
                  TextButton(
                    onPressed: () {
                      setState(() {
                        signUp = !signUp;
                      });
                    },
                    child: signUp
                        ? Text(
                            "Have an account? Sign In",
                            style: TextStyle(color: Colors.blue),
                          )
                        : Text(
                            "Don't have an account",
                            style: TextStyle(color: Colors.blue),
                          ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
