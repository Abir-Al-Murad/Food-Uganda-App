import 'package:flutter/material.dart';
import 'package:jervis/Classes/FoodItems.dart';
import 'package:jervis/Classes/dummy_data.dart';


class Details extends StatefulWidget {
  String url;
  String name;
  String category;
  double price;
  final FoodItems item;

  Details({
    super.key,
    required this.url,
    required this.name,
    required this.category,
    required this.price,
    required this.item,
  });

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  TextEditingController quantityController = TextEditingController(text: '1');

  double get quantity {
    final value = double.tryParse(quantityController.text);
    return (value == null || value < 1) ? 1 : value;
  }

  void updateQuantity(double newQty) {
    if (newQty < 1) return; // prevent going below 1
    quantityController.text = newQty.toStringAsFixed(0);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: widget.name.toString(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(widget.url, fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 10),
            Text("Food : ${widget.name}", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
            Text("Category : ${widget.category}", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
            Text("Price : ৳${widget.price}", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Row(
              children: [
                Text("Quantity: ", style: TextStyle(fontSize: 16)),
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    updateQuantity(quantity - 1);
                  },
                ),
                SizedBox(
                  width: 40,
                  height: 30,
                  child: TextField(
                    controller: quantityController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 5),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    updateQuantity(quantity + 1);
                  },
                ),
              ],
            ),
            SizedBox(width: 10),
            Text(
              "Total: ৳${(widget.price * quantity).toStringAsFixed(2)}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.deepPurpleAccent.withOpacity(0.5),
        width: double.infinity,
        height: 50,
        child: Center(
          child: GestureDetector(
            onTap: () {
              int quantity = int.tryParse(quantityController.text) ?? 1;
              cart_data.add(
                CartModel(quantity: quantity, total: widget.price * quantity, item: widget.item),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Item added to cart!")),
              );
            },
            child: Text(
              "Add to cart",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
