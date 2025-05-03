class Product {
  String id;
  String name;
  String image;
  double price;
  String description;
  Map<String, dynamic> attributes;
   bool isFavorite; // New field to store attributes (e.g., size, color)

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    this.attributes = const {},
       this.isFavorite = false,
  });

 

  // Method to update attributes
  void updateAttributes(Map<String, dynamic> newAttributes) {
    attributes = newAttributes;
  }
}
