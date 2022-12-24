import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
              child: const Image(
                image: AssetImage('assets/logo1.png'),
                fit: BoxFit.contain,
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
                style: const TextStyle(),
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
                    horizontal: MediaQuery.of(context).size.width * 0.1),
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
