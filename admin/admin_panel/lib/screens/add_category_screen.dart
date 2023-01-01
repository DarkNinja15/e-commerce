import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../auth&database/database.dart';
import '../shared/shared_properties.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  TextEditingController namecontroller = TextEditingController();
  Uint8List? image;
  bool isLoading = false;

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
              Uint8List im = await Shared().imagepicker1(
                ImageSource.camera,
              );
              setState(() {
                image = im;
              });
            },
            child: const Text("Camera"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(ctx).pop();
              Uint8List im = await Shared().imagepicker1(
                ImageSource.gallery,

              );
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
  Widget build(BuildContext context) {
    final size =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Category'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 15),
            Container(
              margin: EdgeInsets.all(15),
              child: const Text('Please choose a 9:16 (Landscape) size image', style: TextStyle(color: Colors.deepOrange),),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  width: 2.5,
                  color: const Color.fromRGBO(255, 176, 57, 1),
                ),
                color: Colors.white,
              ),
              // height: size * 0.35,
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.1,
                  vertical: MediaQuery.of(context).size.width * 0.05),
              child: image == null
                  ? const Image(
                      height: 141,
                      width: 335,
                      image: AssetImage('assets/icon_img.png'),
                      fit: BoxFit.contain,
                    )
                  : ClipRRect(
                    child: Image(
                        image: MemoryImage(
                          image!,
                        ),
                      ),
                borderRadius: BorderRadius.circular(22),
                  ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Add thumbnail',
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.w700,
                      color: Colors.blueGrey,
                    ),
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: const Color.fromRGBO(255, 176, 57, 1),
                    child: IconButton(
                      color: Colors.white,
                      onPressed: _selectImage,
                      icon: const Icon(
                        Icons.add_a_photo,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
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
                  hintText: "Name of the category",
                  icon: const Icon(
                    Icons.shop_2,
                    // color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 25),
            InkWell(
              onTap: _addcategory,
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
                    'Add Category to Database',
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

  void _addcategory() {
    if (namecontroller.text.isEmpty) {
      Shared().snackbar(
        message: 'Please enter the category',
        context: context,
      );
      return;
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "Are You sure You want to add this category?",
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(
              Icons.add_box,
              color: Colors.green,
            ),
            onPressed: () async {
              setState(() {
                isLoading = true;
              });
              final res = await Database().addCat(
                context,
                image!,
                namecontroller.text.trim(),
              );
              setState(() {
                isLoading = false;
                namecontroller.text = "";
              });
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
              if (res != 'Success') {
                Shared().snackbar(
                  message: res,
                  context: context,
                );
              } else {
                Shared().snackbar(
                  message: 'Category added sucessfully',
                  context: context,
                );
              }
            },
            label: const Text(
              "Add",
              style: TextStyle(
                color: Colors.green,
              ),
            ),
          ),
          TextButton.icon(
            icon: const Icon(
              Icons.cancel,
              color: Colors.grey,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            label: const Text(
              "Cancel",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
