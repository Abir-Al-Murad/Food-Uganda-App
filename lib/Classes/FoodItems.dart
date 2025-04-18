class FoodItems{
  String name;
  String url;
  String category;
  double price;
  FoodItems({required this.name,required this.url,required this.category,required this.price});
}

class Restuarant {
  String restuarantName;
  String url;
  List<FoodItems> foodItems;

  Restuarant({required this.restuarantName, required this.foodItems,required this.url});
}
