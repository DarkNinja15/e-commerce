import 'package:admin_panel/screens/order_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class OrderTile extends StatelessWidget {
  final dynamic snap;

  const OrderTile({super.key, required this.snap});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            // An action can be bigger than the others.
            flex: 2,
            onPressed: (_) {},
            backgroundColor: const Color.fromRGBO(204, 82, 88, 1),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            // An action can be bigger than the others.
            flex: 2,
            onPressed: (_) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => OrderDetail(snap: snap),
                ),
              );
            },
            backgroundColor: const Color.fromRGBO(255, 176, 57, 1),
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
          ),
        ],
      ),
      child: Container(
        height: 80,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.lightBlueAccent, Colors.lightGreenAccent],
            ),
            borderRadius: BorderRadius.circular(30)),
        child: Center(
          child: ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => OrderDetail(snap: snap),
                ),
              );
            },
            // leading: Image.network(
            //   snap['photoUrl'],
            // ),
            leading: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(snap['photoUrl']), fit: BoxFit.fill),
              ),
            ),
            title: Text(snap['name']),
            subtitle: Text(
              snap['desc'],
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '  Total Price : ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.deepPurple),
                ),
                Text(
                  '₹${(double.parse(snap['price'])) * double.parse(snap['quantity'])}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.teal),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
