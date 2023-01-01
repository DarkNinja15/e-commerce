import 'package:admin_panel/auth&database/database.dart';
import 'package:admin_panel/models/category_model.dart';
import 'package:admin_panel/screens/add_category_screen.dart';
import 'package:admin_panel/widgets/loading.dart';
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
    List<Category> cat = Provider.of<List<Category>>(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Add Category'),
        backgroundColor: const Color.fromRGBO(255, 176, 57, 1),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddCategory(),
            ),
          );
          // showModalBottomSheet(
          //     context: context,
          //     isScrollControlled: true,
          //     builder: (BuildContext context) {
          //       return Container(
          //         padding: EdgeInsets.only(
          //           top: 15,
          //           left: 15,
          //           right: 15,
          //           // this will prevent the soft keyboard from covering the text fields
          //           bottom: MediaQuery.of(context).viewInsets.bottom,
          //         ),
          //         child: Column(
          //           mainAxisSize: MainAxisSize.min,
          //           crossAxisAlignment: CrossAxisAlignment.end,
          //           children: [
          //             const SizedBox(
          //               height: 14,
          //             ),
          //             Padding(
          //               padding: EdgeInsets.symmetric(
          //                   horizontal:
          //                       MediaQuery.of(context).size.width * 0.04),
          //               child: TextField(
          //                 controller: controller,
          //                 keyboardType: TextInputType.text,
          //                 style: const TextStyle(),
          //                 decoration: InputDecoration(
          //                   fillColor: Colors.grey.shade100,
          //                   // filled: true,
          //                   hintText: "Category",
          //                   icon: const Icon(
          //                     Icons.label_outline,
          //                     // color: Colors.black,
          //                   ),
          //                   border: OutlineInputBorder(
          //                     borderRadius: BorderRadius.circular(10),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //             // const SizedBox(
          //             //   height: 200,
          //             // ),
          //             InkWell(
          //               onTap: () {
          //                 _addcategory();
          //               },
          //               child: Row(
          //                 mainAxisAlignment: MainAxisAlignment.end,
          //                 children: [
          //                   Container(
          //                     height: 40,
          //                     width: 150,
          //                     decoration: BoxDecoration(
          //                       color: const Color.fromRGBO(255, 176, 57, 1),
          //                       borderRadius: BorderRadius.circular(20),
          //                     ),
          //                     margin: EdgeInsets.symmetric(
          //                         horizontal:
          //                             MediaQuery.of(context).size.width * 0.04,
          //                         vertical:
          //                             MediaQuery.of(context).size.width * 0.05),
          //                     child: const Center(
          //                       child: Text(
          //                         'Add Category',
          //                         style: TextStyle(
          //                           color: Colors.white,
          //                           fontWeight: FontWeight.bold,
          //                         ),
          //                       ),
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             )
          //           ],
          //         ),
          //       );
          //     });
        },
      ),
      drawer: const Drawerc(),
      appBar: AppBar(
        title: const Text('Edit Categories'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: cat.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(10),
            margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.07,
              right: MediaQuery.of(context).size.width * 0.07,
              top: MediaQuery.of(context).size.width * 0.03,
              bottom: MediaQuery.of(context).size.width * 0.03,
            ),
            height: 80,
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.amberAccent, Colors.lightGreenAccent],
                ),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fitHeight,
                              image: NetworkImage(
                                cat[index].thumbnailPicUrl,
                              ))),
                      // child: ClipOval(child: Image(image: NetworkImage(cat[index].thumbnailPicUrl)))
                    ),
                    const SizedBox(width: 15),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Text(
                        cat[index].name,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                            fontSize: 20),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    _deleteCategory(cat[index]);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _deleteCategory(Category category) async {
    isLoading
        ? const Loading()
        : showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text(
                "Are You sure You want to delete this category?",
                textAlign: TextAlign.center,
              ),
              content: const Text(
                'The products having this category will still be in the data base but you will not be able to add new products for this category.',
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                TextButton.icon(
                  icon: const Icon(
                    Icons.delete,
                    color: Color.fromRGBO(255, 176, 57, 1),
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
                      color: Color.fromRGBO(255, 176, 57, 1),
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

  // void _addcategory() {
  //   if (controller.text.isEmpty) {
  //     Shared().snackbar(
  //       message: 'Please enter the category',
  //       context: context,
  //     );
  //     return;
  //   }
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: const Text(
  //         "Are You sure You want to add this category?",
  //         textAlign: TextAlign.center,
  //       ),
  //       actions: <Widget>[
  //         TextButton.icon(
  //           icon: const Icon(
  //             Icons.add_box,
  //             color: Colors.green,
  //           ),
  //           onPressed: () async {
  //             setState(() {
  //               isLoading = true;
  //             });
  //             final res = await Database()
  //                 .addCat(controller.text.toLowerCase(), context);
  //             setState(() {
  //               isLoading = false;
  //               controller.text = "";
  //             });
  //             // ignore: use_build_context_synchronously
  //             Navigator.of(context).pop();
  //             // ignore: use_build_context_synchronously
  //             Navigator.of(context).pop();
  //             if (res != 'Success') {
  //               Shared().snackbar(
  //                 message: res,
  //                 context: context,
  //               );
  //             } else {
  //               Shared().snackbar(
  //                 message: 'Category added sucessfully',
  //                 context: context,
  //               );
  //             }
  //           },
  //           label: const Text(
  //             "Add",
  //             style: TextStyle(
  //               color: Colors.green,
  //             ),
  //           ),
  //         ),
  //         TextButton.icon(
  //           icon: const Icon(
  //             Icons.cancel,
  //             color: Colors.grey,
  //           ),
  //           onPressed: () {
  //             Navigator.of(context).pop();
  //           },
  //           label: const Text(
  //             "Cancel",
  //             style: TextStyle(
  //               color: Colors.grey,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
