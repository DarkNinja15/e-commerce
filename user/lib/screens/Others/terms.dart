import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:user/widgets/loading.dart';

class Terms extends StatefulWidget {
  const Terms({super.key});

  @override
  State<Terms> createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  bool isLoading = false;
  List allTerms = [];

  @override
  void initState() {
    isLoading = true;
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('terms');
    DocumentSnapshot documentSnapshot =
        await collectionReference.doc('gQi0FcIcliFe1WXCWhVN').get();
    allTerms = (documentSnapshot.data() as Map<String, dynamic>)['tac'];
    Future.delayed(
        const Duration(
          seconds: 2,
        ), () {
      setState(() {
        isLoading = false;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
           Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
          //replace with our own icon data.
        ),
        elevation: 0,
        title: const Text('Terms and Conditions'),
        centerTitle: true,
      ),
      body: isLoading
          ? const Loading()
          : ListView.builder(
              itemCount: allTerms.length,
              itemBuilder: ((context, index) {
                return ListTile(
                  leading: Text(
                    (index + 1).toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  title: Text(allTerms[index]),
                );
              })),
    );
  }
}
