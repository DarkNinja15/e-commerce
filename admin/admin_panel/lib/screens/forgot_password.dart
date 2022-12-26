import 'package:admin_panel/auth&database/authmethods.dart';
import 'package:admin_panel/shared/shared_properties.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailcontroller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset your password'),
        backgroundColor: const Color.fromRGBO(204, 82, 88, 1),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.1),
              child: TextField(
                controller: emailcontroller,
                style: const TextStyle(),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  fillColor: Colors.grey.shade100,
                  // filled: true,
                  hintText: "Enter your email",
                  icon: const Icon(
                    Icons.email,
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: _forgotpass,
              child: Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(204, 82, 88, 1),
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.1,
                    vertical: MediaQuery.of(context).size.width * 0.05),
                child: const Center(
                  child: Text(
                    'Reset Password',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _forgotpass() async {
    final res = await AuthMethods().resetPassword(
      emailcontroller.text,
    );
    if (res != 'Success') {
      Shared().snackbar(
        message: res,
        context: context,
      );
    } else {
      Shared().snackbar(
        message:
            'An email with a link for reseting the password has been sent to ${emailcontroller.text}\nPlease check your spam box if you have not received the email.',
        context: context,
      );
    }
  }
}
