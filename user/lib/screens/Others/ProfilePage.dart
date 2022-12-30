import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text('Your Profile', style: TextStyle(fontWeight: FontWeight.w400, letterSpacing: 0.8, color: Colors.teal),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                // image: DecorationImage(
                //     image: NetworkImage(url),
                //     fit: BoxFit.fill
                // ),
              ),
            ),


            const SizedBox(
              height: 20,
            ),
            const Text('Rishi Raj', style: TextStyle(
              fontSize: 30,
              // color: Colors.white
            ),
            ),
          ],
        ),
      )
    );
  }
}
