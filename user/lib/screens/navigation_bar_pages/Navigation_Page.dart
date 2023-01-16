// ignore_for_file: file_names, constant_identifier_names

import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'All_Categories.dart';
import 'ProfilePage.dart';
import 'WishList.dart';
import 'package:sizer/sizer.dart';

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
          height: MediaQuery.of(context).size.height * 0.075,
          width: double.infinity,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: const Color.fromRGBO(255, 176, 57, 1),
                  spreadRadius: 0.5.sp,
                  blurRadius: 1.sp)
            ],
            borderRadius: const BorderRadius.only(
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
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: width * 0.25,
                  child: _selectedIndex == 0
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.home_filled,
                                size: 17.sp,
                                color: const Color.fromRGBO(255, 176, 57, 1)),
                            SizedBox(height: 0.05.h),
                            Container(
                              width: 1.5.w,
                              height: 0.4.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color.fromRGBO(255, 176, 57, 1),
                              ),
                            ),
                          ],
                        )
                      : Container(
                          padding: const EdgeInsets.all(6),
                          child: Icon(
                            Icons.home_outlined,
                            size: 17.sp,
                          ),
                        ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                },
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: width * 0.25,
                  child: _selectedIndex == 1
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.category,
                              size: 17.sp,
                              color: const Color.fromRGBO(255, 176, 57, 1),
                            ),
                            const SizedBox(height: 3),
                            Container(
                              width: 1.5.w,
                              height: 0.4.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color.fromRGBO(255, 176, 57, 1),
                              ),
                            ),
                          ],
                        )
                      : Container(
                          padding: const EdgeInsets.all(6),
                          child: Icon(
                            Icons.category_outlined,
                            size: 17.sp,
                          )),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = 2;
                  });
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  // margin: EdgeInsets.fromLTRB(0, 0, 40, 0),
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: width * 0.25,
                  child: _selectedIndex == 2
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.favorite,
                                size: 17.sp,
                                color: const Color.fromRGBO(255, 176, 57, 1)),
                            const SizedBox(height: 3),
                            Container(
                              width: 1.5.w,
                              height: 0.4.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color.fromRGBO(255, 176, 57, 1)),
                            ),
                          ],
                        )
                      : Container(
                          padding: const EdgeInsets.all(6),
                          child: Icon(
                            Icons.favorite_outline_outlined,
                            size: 17.sp,
                          ),
                        ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = 3;
                  });
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: width * 0.25,
                  child: _selectedIndex == 3
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person,
                              color: const Color.fromRGBO(255, 176, 57, 1),
                              size: 17.sp,
                            ),
                            const SizedBox(height: 3),
                            Container(
                              width: 1.5.w,
                              height: 0.4.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color.fromRGBO(255, 176, 57, 1)),
                            ),
                          ],
                        )
                      : Container(
                          padding: const EdgeInsets.all(10),
                          child: Icon(
                            Icons.person_outline_outlined,
                            size: 17.sp,
                          )),
                ),
              ),
            ],
          ),
        ));
  }
}
