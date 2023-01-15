// ignore_for_file: file_names, unused_local_variable, use_build_context_synchronously, non_constant_identifier_names

import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:user/provider/user_provider.dart';
import '../../services/Database_Service.dart';
import '../../widgets/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  String url = 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png';
  File? _pickedImage;

  @override
  void dispose() {
    super.dispose();
    namecontroller.dispose();
    phonecontroller.dispose();
    addresscontroller.dispose();
    emailcontroller.dispose();
  }

  void chooseImage0() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
      maxWidth: 150,
    );
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    Navigator.pop(context);
    uploadtask();
  }

  void chooseImage1() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
      maxWidth: 150,
    );
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    Navigator.pop(context);
    uploadtask();
  }

  void uploadtask() async {
    String uid = FirebaseAuth.instance.currentUser!.uid.toString();

    final ref = FirebaseStorage.instance.ref().child('users').child('$uid.jpg');

    await ref.putFile(_pickedImage!).whenComplete(() async {
      String URL = await ref.getDownloadURL();
      url = URL;
    });
  }

  void showForm0(BuildContext context) async {
    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
              padding: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                // this will prevent the soft keyboard from covering the text fields
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        chooseImage0();
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.deepOrange,
                        ),
                        child: const Center(
                            child: Text(
                          'Open Camera',
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 1.5,
                    height: 15,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        chooseImage1();
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.deepOrange,
                        ),
                        child: const Center(
                            child: Text(
                          'Choose from Gallery',
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).getUser;
    namecontroller.text = user.userName;
    phonecontroller.text = user.phoneNo;
    addresscontroller.text = user.address;
    emailcontroller.text = user.email;
    var photoUrl = user.profilePicUrl;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text(
          'Your Profile',
          style: TextStyle(
              fontWeight: FontWeight.w400,
              letterSpacing: 0.8,
              color: Colors.teal),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              height: 2.h,
            ),
            Container(
              width: 15.h,
              height: 15.h,
              decoration: BoxDecoration(
                  border: Border.all(width: 1.7, color: Colors.yellow),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: _pickedImage == null
                          ? (user.profilePicUrl.isEmpty
                              ? NetworkImage(url)
                              : NetworkImage(user.profilePicUrl))
                          : FileImage(_pickedImage!) as ImageProvider,
                      fit: BoxFit.fitHeight)),
            ),
            SizedBox(
              height: 2.h,
            ),
            InkWell(
              onTap: () {
                showForm0(context);
              },
              child: Text(
                'Change Profile Pic',
                style: TextStyle(
                    color: const Color.fromRGBO(255, 176, 57, 1),
                    fontSize: 8.sp),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.lightGreenAccent.withOpacity(0.8)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 2.h),
                        TextFormField(
                          controller: namecontroller,
                          keyboardType: TextInputType.text,
                          decoration: textInputDecoration.copyWith(
                            labelText: "Name",
                            prefixIcon: Icon(
                              Icons.person,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        TextFormField(
                          controller: phonecontroller,
                          keyboardType: TextInputType.phone,
                          decoration: textInputDecoration.copyWith(
                            labelText: "Contact Number",
                            prefixIcon: Icon(
                              Icons.phone,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        TextFormField(
                          enabled: false,
                          controller: emailcontroller,
                          keyboardType: TextInputType.phone,
                          decoration: textInputDecoration.copyWith(
                            labelText: "Email Address",
                            prefixIcon: Icon(
                              Icons.email,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        TextFormField(
                          controller: addresscontroller,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: textInputDecoration.copyWith(
                            labelText: "Address",
                            prefixIcon: Icon(
                              Icons.location_city,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            Timer(const Duration(seconds: 2), () {
                              DatabaseService(
                                      uid: FirebaseAuth
                                          .instance.currentUser?.uid)
                                  .savechanges(
                                      url,
                                      namecontroller.text,
                                      phonecontroller.text,
                                      addresscontroller.text,
                                      context);
                            });
                            // setState(() {});
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 8),
                            width: double.infinity,
                            height: 40,
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(255, 176, 57, 1),
                                // border: Border.all(width: 1),
                                borderRadius: BorderRadius.circular(35)),
                            child: const Center(
                              child: Text(
                                'Save Changes',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17.5),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
