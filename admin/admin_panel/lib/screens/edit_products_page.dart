import 'package:flutter/material.dart';

class EditProduct extends StatefulWidget {
  final dynamic snap;
  const EditProduct({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController desccontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController quantitycontroller = TextEditingController();
  TextEditingController discountcontroller = TextEditingController();
  TextEditingController dplcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    String? image = widget.snap['photoUrl'];
    namecontroller.text = widget.snap['name'];
    desccontroller.text = widget.snap['desc'];
    pricecontroller.text = (widget.snap['price']).toString();
    quantitycontroller.text = (widget.snap['quantity']).toString();
    discountcontroller.text = (widget.snap['discount']).toString();
    dplcontroller.text = (widget.snap['discountProductLimit']).toString();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(204, 82, 88, 1),
        title: const Text('Edit Product'),
        centerTitle: true,
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
                      image: NetworkImage(
                        image,
                      ),
                    ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  image == null
                      ? const Text(
                          'Add a photo',
                          style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        )
                      : const Text(
                          'Photo Added',
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
                      onPressed: () {},
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
                    'Save Changes',
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
