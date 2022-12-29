// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:user/screens/Intro-Screens/login_page.dart';
import '../../services/Auth_Service.dart';
import '../../widgets/textfield.dart';
import '../Others/Navigation_Page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Login.png'),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 130,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    child: Column(
                      children: const [
                        Text(
                          'Welcome',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Enter your details to create your account',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      Form(
                          child: Column(
                        children: [
                          TextFormField(
                            // controller: emailController,
                            decoration: textInputDecoration.copyWith(
                              labelText: "Name",
                              prefixIcon: Icon(
                                Icons.person,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            // controller: emailController,
                            keyboardType: TextInputType.phone,
                            decoration: textInputDecoration.copyWith(
                              labelText: "Contact Number",
                              prefixIcon: Icon(
                                Icons.phone,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            // controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: textInputDecoration.copyWith(
                              labelText: "Email",
                              prefixIcon: Icon(
                                Icons.email,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            // controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: textInputDecoration.copyWith(
                              labelText: "Password",
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            decoration: textInputDecoration.copyWith(
                                labelText: "Confirm Password",
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Theme.of(context).primaryColor,
                                )),
                            onChanged: (val) {
                              setState(() {});
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 10),
                            width: double.infinity,
                            height: 40,
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(255, 176, 57, 1),
                                // border: Border.all(width: 1),
                                borderRadius: BorderRadius.circular(35)),
                            child: const Center(
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17.5),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 100,
                          ),
                          InkWell(
                            onTap: () async {
                              await Authentication.signInWithGoogle(
                                      context: context)
                                  .then((val) {
                                if (val == true) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const NavigationPage(),
                                    ),
                                  );
                                }
                              });
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(width: 0.5),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: 30,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/Google.png',
                                      width: 20,
                                    ),
                                    const Text(
                                      '   Sign Up With Google',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10),
                                    )
                                  ],
                                )),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Already have an account ? '),
                                InkWell(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Sign In here .',
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(255, 176, 57, 1)),
                                    ))
                              ],
                            ),
                          ),
                        ],
                      )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
