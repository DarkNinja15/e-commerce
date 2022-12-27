import 'package:flutter/material.dart';

import '../auth&database/authmethods.dart';
import '../screens/login_page.dart';
import '../shared/shared_properties.dart';

void Logout(BuildContext ctx){
  showDialog(
    barrierDismissible: false,
      context: ctx, builder: (BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
      child: Container(
        padding: EdgeInsets.all(10),
        height: 150.0,
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
                  margin: EdgeInsets.fromLTRB(18, 7, 0, 7),
                  child: Text('Log Out ?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor),),),
                Container(
                  margin: EdgeInsets.fromLTRB(18, 2.5, 0, 15),
                  child: Text('Are you sure want to Log Out ?', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(18, 0, 18, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      child: Container(
                        height: 35,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: const Color.fromRGBO(255, 176, 57, 1),),
                          borderRadius: BorderRadius.circular(17),
                        ),
                        child: Center(child: Text('Cancel', style: TextStyle(color: const Color.fromRGBO(255, 176, 57, 1),),),),
                      ),
                      onTap: (){Navigator.of(context).pop();}
                  ),
                  GestureDetector(
                    child: Container(
                      height: 35,
                      width: 100,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 176, 57, 1),
                        borderRadius: BorderRadius.circular(17),
                      ),
                      child: Center(child: Text('Log Out', style: TextStyle(color: Colors.white),)),
                    ),
                    onTap: () async {
                      final res = await AuthMethods().signoutoftheapp();
                      if (res != 'Success') {
                        Shared().snackbar(
                          message: res,
                          context: context,
                        );
                      } else {
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  });
}