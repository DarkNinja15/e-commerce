import 'package:admin_panel/auth&database/database.dart';
import 'package:admin_panel/shared/loading.dart';
import 'package:admin_panel/shared/shared_properties.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/drawer.dart';

class EditCategory extends StatefulWidget {
  const EditCategory({super.key});

  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  TextEditingController controller = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> cat = Provider.of<List<String>>(context);
    return isLoading
        ? const Scaffold(
            body: Loading(),
          )
        : Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.1),
                              child: TextField(
                                controller: controller,
                                keyboardType: TextInputType.text,
                                style: const TextStyle(),
                                decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  // filled: true,
                                  hintText: "Category",
                                  icon: const Icon(
                                    Icons.label_outline,
                                    // color: Colors.black,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 200,
                            ),
                            InkWell(
                              onTap: () {
                                _addcategory();
                              },
                              child: Container(
                                height: 40,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(255, 176, 57, 1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                margin: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width * 0.1,
                                    vertical:
                                        MediaQuery.of(context).size.width *
                                            0.05),
                                child: const Center(
                                  child: Text(
                                    'Add Category',
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
                      );
                    });
              },
              child: const Icon(Icons.add),
            ),
            drawer: const Drawerc(),
            appBar: AppBar(
              title: const Text('Edit Categories'),
              centerTitle: true,
            ),
            body: ListView.builder(
              itemCount: cat.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.1,
                    right: MediaQuery.of(context).size.width * 0.1,
                    top: MediaQuery.of(context).size.width * 0.01,
                  ),
                  child: Card(
                    child: ListTile(
                      title: Text(
                        cat[index],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          _deleteCategory(cat[index]);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          );
  }

  void _deleteCategory(String category) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "Are You sure You want to delete this category?",
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(
              Icons.delete,
              color: Color.fromRGBO(204, 82, 88, 1),
            ),
            onPressed: () async {
              setState(() {
                isLoading = true;
              });
              final res = await Database().delCat(category, context);
              setState(() {
                isLoading = false;
              });
              if (res != 'Success') {
                Shared().snackbar(
                  message: res,
                  context: context,
                );
              } else {
                Shared().snackbar(
                  message: 'Category deleted sucessfully',
                  context: context,
                );
              }
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
            },
            label: const Text(
              "Delete",
              style: TextStyle(
                color: Color.fromRGBO(204, 82, 88, 1),
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

  void _addcategory() {
    if (controller.text.isEmpty) {
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
              final res = await Database()
                  .addCat(controller.text.toLowerCase(), context);
              setState(() {
                isLoading = false;
                controller.text = "";
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
