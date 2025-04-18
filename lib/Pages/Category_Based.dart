import 'package:flutter/material.dart';
import 'package:jervis/Classes/dummy_data.dart';
import 'package:jervis/Pages/Details.dart';

class CategoryBased extends StatefulWidget {
  const CategoryBased({super.key});

  @override
  State<CategoryBased> createState() => _CategoryBasedState();
}

class _CategoryBasedState extends State<CategoryBased> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: ListView.builder(itemCount: all_categories.length,itemBuilder:(context,index){
            final currentCatagory = all_categories[index];
            final filteredItems = all_fooditems.where((x)=>x.category == currentCatagory).toList();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(currentCatagory,style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple),),
                SizedBox(height: 10,),
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
                    return Hero(
                      tag: food.name.toString(),
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),side: BorderSide(color: Colors.grey)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: food.url == "Null"
                                        ? Center(child: Icon(Icons.fastfood, size: 60, color: Colors.grey))
                                        : Image.network(
                                      food.url,
                                      fit: BoxFit.cover,
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                ),
                              ),
                      
                              SizedBox(height: 8),
                      
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween
                      
                                ,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                          width:100,
                                          child: Text(food.name, style: TextStyle(fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis))),
                      
                                      SizedBox(height: 4),
                      
                                      Text("৳${food.price}", style: TextStyle(color: Colors.green[700])),
                      
                                    ],
                                  ),
                                  FilledButton(onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Details(url: food.url, name: food.name, category: currentCatagory, price: food.price, item: food)));
                                  }, child: Text("Order")),
                                ],
                              ),
                      
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          },))
        ],
      ),
    );
  }
}
