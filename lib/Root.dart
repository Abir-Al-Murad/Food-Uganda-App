import 'package:flutter/material.dart';
import 'package:jervis/Pages/Category_Based.dart';
import 'package:jervis/Pages/MenuPage.dart';
import 'package:jervis/Pages/cart.dart';
import 'package:jervis/Pages/orders.dart';
import 'package:jervis/Pages/profile.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int selectedIndex = 0;
  List screeens = [
    Menupage(),
    CategoryBased(),
    Cart(),
    Orders(),
    Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        // backgroundColor: Color(0xfff1c40f),
        backgroundColor: Colors.white,
        title: Image.asset("assets/logo.png",height: 50,),
        centerTitle: true,
      ),
      body: screeens[selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 100,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      bottomItem(0, Icons.home_outlined, "Home", Icons.home),
                      bottomItem(1, Icons.fastfood_outlined, "Category", Icons.fastfood),
                      SizedBox(width: 10,),
                      bottomItem(3, Icons.food_bank_outlined, "Orders", Icons.food_bank),
                      bottomItem(4, Icons.person_2_outlined, "Profile", Icons.person),

                    ],
                  ),
                ),
              ),

              Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      selectedIndex=2;
                    });
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 10,
                          offset: Offset(0, 5)
                        )
                      ]
                    ),
                    child: Icon(selectedIndex == 2?Icons.shopping_cart:Icons.shopping_cart_outlined,color: Colors.black,),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
  Widget bottomItem(int index , IconData icon,String label,IconData selectedIcon){
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: (){
        setState(() {
          selectedIndex = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(isSelected?selectedIcon:icon,color: isSelected?Colors.lightGreen:Colors.black,),
          Text(label,style: TextStyle(fontSize: 12,color: isSelected?Colors.lightGreen:Colors.grey,fontWeight: isSelected?FontWeight.bold:FontWeight.normal),),
        ],
      ),
    );

  }
}

