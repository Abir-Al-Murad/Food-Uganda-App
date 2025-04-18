import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:jervis/Pages/FoodPage.dart';

import '../Classes/dummy_data.dart';

class Menupage extends StatefulWidget {
  const Menupage({super.key});

  @override
  State<Menupage> createState() => _MenupageState();
}

class _MenupageState extends State<Menupage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 150,
                autoPlay: true,
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
                aspectRatio: 16/9,
                // autoPlayInterval: Duration(seconds: 2),
                viewportFraction: 0.85,
              ),
              items: resClass.expand((restaurant) {
                return restaurant.foodItems.map((foodItem) {
                  return Builder(
                    builder: (context) {
                      return Container(
                        height: 150,
                        width: MediaQuery.sizeOf(context).width,
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.deepOrangeAccent,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              restaurant.restuarantName,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              foodItem.name,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }).toList();
              }).toList(),
            ),
            SizedBox(height: 20,),
            Text("Restaurants",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
            Expanded(
              child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),itemCount: resClass.length,itemBuilder: (context,index){
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: Colors.grey),
                  ),
                  elevation: 5,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: Image.network(resClass[index].url,fit: BoxFit.fill,)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text("${resClass[index].restuarantName}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: FilledButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Foodpage(n: resClass[index].restuarantName, x: resClass[index].foodItems)));
                            }, child: Text("See"),),
                          ),
                        ],
                      ),
                    ],
                  ),
                );

              }),
            )

          ],
        ),
      ),
    );
  }
}
