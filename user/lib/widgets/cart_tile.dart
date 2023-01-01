import 'package:flutter/material.dart';

Widget counter() {
  return Container(
    child: Row(
      children: [
        button1(),
        screen(1),
        button2(),
      ],
    ),
  );
}

Widget Cart_tile(String picUrl, String name, double price) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), color: Colors.white),
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.all(10),
    width: double.infinity,
    height: 125,
    child: Row(
      children: [
        Radio(value: true, groupValue: true, onChanged: (_) {}),
        Container(
          height: 90,
          width: 90,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.blueGrey.shade200),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(picUrl, fit: BoxFit.contain),
          ),
        ),
        SizedBox(width: 8),
        Container(
          width: 190,
            // decoration: BoxDecoration(
            //   border: Border.all(width: 1)
            // ),
          margin: EdgeInsets.all(7),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // decoration: BoxDecoration(
                //     border: Border.all(width: 1)
                // ),
                child: Text(
                  name,
                  style: TextStyle(
                      fontSize: 18,
                      overflow: TextOverflow.ellipsis,
                      color: Colors.teal),
                ),
              ),
              Container(
                // decoration: BoxDecoration(
                //     border: Border.all(width: 1)
                // ),
                child: Text(
                  '₹ ${price.ceil().toString()}',
                  style: TextStyle(fontSize: 17, color: Colors.green),
                ),
              ),
              Container(
                height: 40,
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    counter(),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.delete_outline_outlined, color: Colors.redAccent.shade200,))
                  ],
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}

Widget button1(){
  return Container(
    margin: EdgeInsets.all(4),
    height: 25,
    width: 25,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      border: Border.all(width: 0.7, color: Colors.teal),
    ),
    child: Icon(Icons.remove, color: Colors.teal,)
  );
}

Widget button2(){
  return Container(
    margin: EdgeInsets.all(4),
    height: 25,
    width: 25,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: Colors.teal,
    ),
    child: Icon(Icons.add, color: Colors.white,)
  );
}

Widget screen(int count){
  return Container(
      margin: EdgeInsets.all(4),
      height: 25,
      width: 25,
      child: Center(child: Text(count.toString(), style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),))
  );
}
