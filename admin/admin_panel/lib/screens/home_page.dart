import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../shared/shared_properties.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Uint8List? image;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController desccontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();

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
  }

  @override
  Widget build(BuildContext context) {
    final size =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    // print(MediaQuery.of(context).size.width);
    return Scaffold(
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
              color: Colors.amber,
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
            InkWell(
              onTap: () {},
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
}
