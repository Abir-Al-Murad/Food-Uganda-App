import 'package:flutter/material.dart';
import 'package:jervis/Classes/dummy_data.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  double totalprice = 0;
  @override
  void initState() {
    for(int i =0;i<cart_data.length;i++){
      totalprice = totalprice+cart_data[i].total;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: cart_data.isEmpty
          ? Center(child: Text("Your cart is empty."))
          : Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: ListView.builder(
                    itemCount: cart_data.length,
                    itemBuilder: (context, index) {
            final cartItem = cart_data[index];
            return ListTile(
              title: Text(cartItem.item.name),
              trailing: IconButton(onPressed: (){
                setState(() {
                  totalprice = totalprice - cart_data[index].total;
                  cart_data.removeAt(index);
                });
              }, icon: Icon(Icons.delete,color: Colors.red,)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Quantity : ${cartItem.quantity}"),
                  Text("Total Price : ৳${cartItem.total.toStringAsFixed(2)}"),
                ],
              ),
            );
                    },
                  ),
          ),
      floatingActionButton: cart_data.isEmpty
          ? null
          : Container(
        margin: EdgeInsets.only(bottom: 150),
            child: FloatingActionButton.extended(
                    onPressed: () {
            order_data.addAll(cart_data);
            setState(() {
              cart_data.clear();
              totalprice = 0;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Order Confirmed!")),
            );
                    },
                    backgroundColor: Colors.green.shade800,
                    foregroundColor: Colors.white,
                    elevation: 10,
                    icon: Icon(Icons.shopping_bag),
                    label: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "Order Now (৳${totalprice.toStringAsFixed(2)})",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
                    ),
                  ),
          ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,



    );
  }
}
