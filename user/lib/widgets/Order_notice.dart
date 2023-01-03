import 'package:flutter/material.dart';
import 'package:user/screens/Navigation_Page.dart';

void Order_Succes(BuildContext ctx) {
  showDialog(
      barrierDismissible: false,
      context: ctx,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0)), //this right here
          child: Container(
            padding: const EdgeInsets.all(10),
            height: 210.0,
            width: 320.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(18, 7, 0, 7),
                      child: Text(
                        'Order Successful',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(18, 2.5, 0, 15),
                      child: const Text(
                        '\nThanks for shopping from B H R M A R.\n\nClick on OK to go to the Main Page and continue shopping.',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(18, 0, 18, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          child: Container(
                            height: 35,
                            width: 200,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(255, 176, 57, 1),
                              borderRadius: BorderRadius.circular(17),
                            ),
                            child: const Center(
                              child: Text(
                                'Ok',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => const NavigationPage()));
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
