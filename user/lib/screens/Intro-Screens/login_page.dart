import 'package:flutter/material.dart';
import 'package:user/screens/Intro-Screens/Register_Screen.dart';
import 'package:user/screens/Intro-Screens/forgot_password_screen.dart';
import 'package:user/widgets/loading.dart';
import 'package:user/widgets/textfield.dart';
import '../../provider/user_provider.dart';
import '../../services/Auth_Service.dart';
import '../../shared/shared_properties.dart';
import '../navigation_bar_pages/Navigation_Page.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  addData() async {
    await Provider.of<UserProvider>(context, listen: false).refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/screen1.png'),
          fit: BoxFit.fitWidth,
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.34,
                  padding: const EdgeInsets.only(top: 10),
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
                            controller: emailcontroller,
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
                            controller: passwordcontroller,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            decoration: textInputDecoration.copyWith(
                                labelText: "Password",
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Theme.of(context).primaryColor,
                                )),
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
                                if (emailcontroller.text.trim().isEmpty ||
                                    passwordcontroller.text.trim().isEmpty) {
                                  Shared().snackbar(
                                    'Please enter all the fields.',
                                    context,
                                  );
                                }
                                setState(() {
                                  isLoading = true;
                                });
                                String res = await Authentication().logmein(
                                  emailcontroller.text.trim(),
                                  passwordcontroller.text.trim(),
                                );
                                setState(() {
                                  isLoading = false;
                                });
                                if (res == 'Success') {
                                  if (!mounted) return;
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const NavigationPage(),
                                    ),
                                  );
                                } else {
                                  // ignore: use_build_context_synchronously
                                  Shared().snackbar(
                                    res,
                                    context,
                                  );
                                }
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
                              addData();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const NavigationPage(),
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
                            const Text('Do not have a account ? '),
                            InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterPage(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Register here .',
                                  style: TextStyle(
                                      color: Color.fromRGBO(255, 176, 57, 1)),
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
