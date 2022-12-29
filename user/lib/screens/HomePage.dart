import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
      ),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => InkWell(
            onTap: (){
              Scaffold.of(context).openDrawer();
            },
            child: Padding(
              padding: const EdgeInsets.all(19),
              child: Image.asset('assets/drawer.png'),
            ),
          )
        ),
        elevation: 0,
        title: Text('B H R M A R', style: TextStyle(fontWeight: FontWeight.w300),),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Home_Page'),
      ),
    );
  }
}
