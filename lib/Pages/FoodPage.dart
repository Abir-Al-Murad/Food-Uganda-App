import 'package:flutter/material.dart';
import 'package:jervis/Classes/FoodItems.dart';
import 'package:jervis/Pages/Details.dart';

class Foodpage extends StatefulWidget {
  final String n;
  final List<FoodItems> x;

  Foodpage({super.key, required this.n, required this.x});

  @override
  State<Foodpage> createState() => _FoodpageState();
}

class _FoodpageState extends State<Foodpage> {
  List<String> categories = [];

  @override
  void initState() {
    super.initState();
    categories = widget.x.map((item) => item.category).toSet().toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.n,style: TextStyle(fontWeight: FontWeight.bold),),centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Restaurant : ${widget.n}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final currentCategory = categories[index];
                  final filteredItems = widget.x.where((item) => item.category == currentCategory).toList();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentCategory,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                      ),
                      SizedBox(height: 10),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: filteredItems.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.75,
                        ),

                        itemBuilder: (context, i) {
                          final food = filteredItems[i];
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> Details(url: food.url, name: food.name, category: food.category, price: food.price,item: food,)));

                            },
                            child: Hero(
                              tag: food.name.toString(),
                              child: Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),side: BorderSide(color: Colors.grey)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8)
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(8),
                                            child: food.url == "Null"
                                                ? Icon(Icons.fastfood, size: 60, color: Colors.grey)
                                                : Image.network(food.url, fit: BoxFit.cover),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(food.name, style: TextStyle(fontWeight: FontWeight.bold)),
                                      SizedBox(height: 4),
                                      Text("৳${food.price}", style: TextStyle(color: Colors.green[700])),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 20),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
