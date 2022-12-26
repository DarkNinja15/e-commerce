import 'dart:typed_data';
import 'package:admin_panel/auth&database/database.dart';
import 'package:admin_panel/shared/loading.dart';
import 'package:admin_panel/widgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../shared/shared_properties.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  Uint8List? image;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController desccontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController quantitycontroller = TextEditingController();
  TextEditingController discountcontroller = TextEditingController();
  TextEditingController dplcontroller = TextEditingController();

  _selectImage() async {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Select the path"),
        content:
            const Text("Choose the path from where you want to pick the image"),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              Navigator.of(ctx).pop();
              Uint8List im = await Shared().imagepicker(ImageSource.camera);
              setState(() {
                image = im;
              });
            },
            child: const Text("Camera"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(ctx).pop();
              Uint8List im = await Shared().imagepicker(ImageSource.gallery);
              setState(() {
                image = im;
              });
            },
            child: const Text("Gallery"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    namecontroller.dispose();
    pricecontroller.dispose();
    desccontroller.dispose();
    quantitycontroller.dispose();
    dplcontroller.dispose();
    discountcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    // print(MediaQuery.of(context).size.width);
    return isLoading
        ? const Scaffold(
            body: Loading(),
          )
        : Scaffold(
            drawer: const Drawerc(),
            appBar: AppBar(
              title: const Text('Add a Product'),
              centerTitle: true,
              backgroundColor: const Color.fromRGBO(204, 82, 88, 1),
              shadowColor: const Color.fromRGBO(204, 82, 88, 1),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.transparent,
                    height: size * 0.35,
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1,
                        vertical: MediaQuery.of(context).size.width * 0.05),
                    child: image == null
                        ? const Image(
                            image: AssetImage('assets/logo1.png'),
                            fit: BoxFit.contain,
                          )
                        : Image(
                            image: MemoryImage(
                              image!,
                            ),
                          ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Add a photo',
                          style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: const Color.fromRGBO(204, 82, 88, 1),
                          child: IconButton(
                            color: Colors.white,
                            onPressed: _selectImage,
                            icon: const Icon(
                              Icons.add_a_photo,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
                        hintText: "Name of the Product",
                        icon: const Icon(
                          Icons.shop_2,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1),
                    child: TextField(
                      controller: desccontroller,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(),
                      maxLines: 3,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        // filled: true,
                        hintText: "Enter Product description",
                        icon: const Icon(
                          Icons.notes,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1),
                    child: TextField(
                      controller: pricecontroller,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(),
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        // filled: true,
                        hintText: "Set Price",
                        icon: const Icon(
                          Icons.price_check,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1),
                    child: TextField(
                      controller: quantitycontroller,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(),
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        // filled: true,
                        hintText: "Enter Quantitiy",
                        icon: const Icon(
                          Icons.production_quantity_limits_outlined,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1),
                    child: TextField(
                      controller: discountcontroller,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(),
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        // filled: true,
                        hintText: "Enter Discount(%)",
                        icon: const Icon(
                          Icons.discount,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1),
                    child: TextField(
                      controller: dplcontroller,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(),
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        // filled: true,
                        hintText: "Discount Product limit",
                        icon: const Icon(
                          Icons.label_outline,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: _addProd,
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
                          'Add Product to Database',
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

  void _addProd() async {
    if (namecontroller.text.isEmpty ||
        desccontroller.text.isEmpty ||
        pricecontroller.text.isEmpty ||
        image == null ||
        quantitycontroller.text.isEmpty ||
        discountcontroller.text.isEmpty ||
        dplcontroller.text.isEmpty) {
      Shared().snackbar(
        message: "Please Enter all the details.",
        context: context,
      );
      return;
    }
    setState(() {
      isLoading = true;
    });
    final res = await Database().addProduct(
      namecontroller.text,
      desccontroller.text,
      pricecontroller.text,
      image,
      int.parse(quantitycontroller.text),
      double.parse(discountcontroller.text),
      int.parse(dplcontroller.text),
      FirebaseAuth.instance.currentUser!.uid,
    );
    setState(() {
      namecontroller.text = "";
      desccontroller.text = "";
      pricecontroller.text = "";
      discountcontroller.text = "";
      dplcontroller.text = "";
      quantitycontroller.text = "";
      image = null;
      isLoading = false;
    });
    if (res != "Success") {
      Shared().snackbar(
        message: res,
        context: context,
      );
    } else {
      Shared().snackbar(
        message: "Product added to database",
        context: context,
      );
    }
  }
}
