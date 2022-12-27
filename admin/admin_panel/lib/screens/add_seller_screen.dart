import 'package:admin_panel/auth&database/database.dart';
import 'package:admin_panel/shared/loading.dart';
import 'package:admin_panel/shared/shared_properties.dart';
import 'package:admin_panel/widgets/drawer.dart';
import 'package:flutter/material.dart';

class AddSeller extends StatefulWidget {
  const AddSeller({super.key});

  @override
  State<AddSeller> createState() => _AddSellerState();
}

class _AddSellerState extends State<AddSeller> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    namecontroller.dispose();
    phonecontroller.dispose();
    addresscontroller.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return isLoading
        ? const Scaffold(
            body: Loading(),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            drawer: const Drawerc(),
            appBar: AppBar(
              elevation: 0,
              title: const Text('Add a seller'),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.4,
                    child: const Image(
                      image: AssetImage(
                        'assets/seller.png',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.005,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1),
                    child: TextField(
                      controller: namecontroller,
                      style: const TextStyle(),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        // filled: true,
                        hintText: "Name of Seller",
                        icon: const Icon(
                          Icons.abc,
                          // color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1),
                    child: TextField(
                      controller: phonecontroller,
                      style: const TextStyle(),
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        // filled: true,
                        hintText: "Phone Number",
                        icon: const Icon(
                          Icons.phone,
                          // color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1),
                    child: TextField(
                      controller: addresscontroller,
                      style: const TextStyle(),
                      keyboardType: TextInputType.text,
                      maxLines: 3,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        // filled: true,
                        hintText: "Address",
                        icon: const Icon(
                          Icons.description,
                          // color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1),
                    child: TextField(
                      controller: emailcontroller,
                      style: const TextStyle(),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        // filled: true,
                        hintText: "email",
                        icon: const Icon(
                          Icons.email,
                          // color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1),
                    child: TextField(
                      controller: passwordcontroller,
                      style: const TextStyle(),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        // filled: true,
                        hintText: "password",
                        icon: const Icon(
                          Icons.password,
                          // color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1),
                    child: TextField(
                      controller: passwordcontroller,
                      style: const TextStyle(),
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        // filled: true,
                        hintText: "Confirm password",
                        icon: const Icon(
                          Icons.password,
                          // color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: _addSeller,
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 176, 57, 1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.1,
                          vertical: MediaQuery.of(context).size.width * 0.05),
                      child: const Center(
                        child: Text(
                          'Add Seller',
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

  void _addSeller() async {
    if (namecontroller.text.isEmpty ||
        phonecontroller.text.isEmpty ||
        addresscontroller.text.isEmpty ||
        emailcontroller.text.isEmpty ||
        passwordcontroller.text.isEmpty) {
      Shared().snackbar(
        message: 'Please enter all details',
        context: context,
      );
      return;
    }
    setState(() {
      isLoading = true;
    });
    final res = await Database().addSeller(
      namecontroller.text,
      phonecontroller.text,
      addresscontroller.text,
      emailcontroller.text,
      passwordcontroller.text,
    );
    setState(() {
      namecontroller.text = "";
      phonecontroller.text = "";
      addresscontroller.text = "";
      emailcontroller.text = "";
      passwordcontroller.text = "";
      isLoading = false;
    });
    if (res != 'Success') {
      Shared().snackbar(
        message: res,
        context: context,
      );
    } else {
      Shared().snackbar(
        message: 'Seller Added Successfully',
        context: context,
      );
    }
  }
}
