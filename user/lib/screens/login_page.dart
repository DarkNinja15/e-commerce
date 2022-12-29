import 'package:flutter/material.dart';
import 'package:user/screens/forgot_password_screen.dart';
import 'package:user/widgets/loading.dart';
import 'package:user/widgets/textfield.dart';
import '../services/auth_service.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/screen1.png'),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.37,
                  padding: const EdgeInsets.only(top: 30),
                  child: Column(
                    children: const [
                      Text(
                        'Welcome',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Sign In to Continue',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Form(
                          // key: formKey,
                          child: Column(
                        children: [
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
                            onChanged: (val) {
                              setState(() {
                                // email = val;
                              });
                            },

                            // check tha validation
                            // validator: (val) {
                            //   return RegExp(
                            //               r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            //           .hasMatch(val!)
                            //       ? null
                            //       : "Please enter a valid email";
                            // },
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            // controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            decoration: textInputDecoration.copyWith(
                                labelText: "Password",
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Theme.of(context).primaryColor,
                                )),
                            // validator: (val) {
                            //   if (val!.length < 6) {
                            //     return "Password must be at least 6 characters";
                            //   } else {
                            //     return null;
                            //   }
                            // },
                            onChanged: (val) {
                              setState(() {
                                // password = val;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      )),
                      SizedBox(
                        height: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotPassword(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Forgot Password ?',
                                style: TextStyle(
                                    color: Color.fromRGBO(255, 176, 57, 1)),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      isLoading
                          ? const Loading()
                          : GestureDetector(
                              onTap: () async {
                                // formKey.currentState!.validate();
                                // setState(() {
                                //   isLoading = true;
                                // });
                                // String res = await AuthMethods().logmein(
                                //   email: emailController.text,
                                //   password: passwordController.text,
                                // );
                                // setState(() {
                                //   isLoading = false;
                                // });
                                // if (res == 'Success') {
                                //   // navigate
                                //   // print('success');
                                //   if (!mounted) return;
                                //   Navigator.of(context).pushReplacement(
                                //     MaterialPageRoute(
                                //       builder: (context) => const HomePage(),
                                //     ),
                                //   );
                                // } else {
                                //   Shared().snackbar(
                                //     message: res,
                                //     context: context,
                                //   );
                                // }
                              },
                              child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 10),
                                  width: double.infinity,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color:
                                          const Color.fromRGBO(255, 176, 57, 1),
                                      // border: Border.all(width: 1),
                                      borderRadius: BorderRadius.circular(35)),
                                  child: const Center(
                                    child: Text(
                                      'Sign In',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 17.5),
                                    ),
                                  )),
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
                                  builder: (context) => const HomePage(),
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
                                  '   Sign In With Google',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10),
                                )
                              ],
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Did not have a account ? '),
                            InkWell(
                                onTap: () {},
                                child: const Text(
                                  'Register here .',
                                  style: TextStyle(
                                    color: Color.fromRGBO(255, 176, 57, 1),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
