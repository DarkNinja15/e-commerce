// ignore_for_file: file_names, constant_identifier_names

import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'Others/All_Categories.dart';
import 'Others/ProfilePage.dart';
import 'Others/WishList.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {

  int _selectedIndex = 0;

  static const List<Widget> Page_List = <Widget>[
    HomePage(),
    All_Categories(),
    WishList(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Center(
          child: Page_List[_selectedIndex],
        ),
        bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.height * 0.072,
          width: double.infinity,
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(255, 176, 57, 1),
                  spreadRadius: 0.5,
                  blurRadius: 1.0)
            ],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24), topRight: Radius.circular(24)),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                },
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: width * 0.25,
                  child: _selectedIndex == 0
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.home_filled,
                                color: Color.fromRGBO(255, 176, 57, 1)),
                            const SizedBox(height: 3),
                            Container(
                              width: 6,
                              height: 3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color.fromRGBO(255, 176, 57, 1),
                              ),
                            ),
                          ],
                        )
                      : Container(
                          padding: const EdgeInsets.all(6),
                          child: const Icon(Icons.home_outlined),
                        ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                },
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: width * 0.25,
                  child: _selectedIndex == 1
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.category,
                              color: Color.fromRGBO(255, 176, 57, 1),
                            ),
                            const SizedBox(height: 3),
                            Container(
                              width: 6,
                              height: 3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color.fromRGBO(255, 176, 57, 1),
                              ),
                            ),
                          ],
                        )
                      : Container(
                          padding: const EdgeInsets.all(6),
                          child: const Icon(Icons.category_outlined)),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = 2;
                  });
                },
                child: SizedBox(
                  // margin: EdgeInsets.fromLTRB(0, 0, 40, 0),
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: width * 0.25,
                  child: _selectedIndex == 2
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.favorite,
                                color: Color.fromRGBO(255, 176, 57, 1)),
                            const SizedBox(height: 3),
                            Container(
                              width: 6,
                              height: 3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color.fromRGBO(255, 176, 57, 1)),
                            ),
                          ],
                        )
                      : Container(
                          padding: const EdgeInsets.all(6),
                          child: const Icon(Icons.favorite_outline_outlined)),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = 3;
                  });
                },
                child: SizedBox(
                  // margin: EdgeInsets.fromLTRB(0, 0, 40, 0),
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: width * 0.25,
                  child: _selectedIndex == 3
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.person,
                                color: Color.fromRGBO(255, 176, 57, 1)),
                            const SizedBox(height: 3),
                            Container(
                              width: 6,
                              height: 3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color.fromRGBO(255, 176, 57, 1)),
                            ),
                          ],
                        )
                      : Container(
                          padding: const EdgeInsets.all(10),
                          child: const Icon(Icons.person_outline_outlined)),
                ),
              ),
            ],
          ),
        ));
  }
}
