import 'package:flutter/material.dart';
import 'package:jervis/Classes/OrderStatusIcon.dart';
import 'package:jervis/Classes/dummy_data.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: order_data.isEmpty
          ? Center(child: Text("Empty"))
          : ListView.builder(
          itemCount: order_data.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(order_data[index].item.name),
              subtitle: Text("Quantity: ${order_data[index].quantity}, Total: ৳${order_data[index].total}"),
              leading: OrderStatusIcon(),
            );
          }),
    );
  }
}
