class MedicineModel {
  final String? image;
  final String? categoryId;
  final String? name;
  final String? id;
  final String? category;
  final String? price;
  final String? description;
  bool? isAddedToCart;
  int? cartAmount;

  MedicineModel({
    this.image,
    this.categoryId,
    this.name,
    this.id,
    this.category,
    this.price,
    this.description,
    this.isAddedToCart = false,
    this.cartAmount = 0,
  });

  MedicineModel.fromJson(Map<String, dynamic> json)
      : image = json['image'] ?? "",
        categoryId = json['category_id'] ?? "",
        name = json['name'] ?? "",
        id = json['id'] ?? "",
        price = json['price'] ?? "",
        description = json['description'] ?? "",
        isAddedToCart = json['isAddedToCart'] ?? false,
        cartAmount = json['cartAmount'] ?? 0,
        category = json['category'] ?? "";

  Map<String, dynamic> toJson() => {
        'image': image,
        'category_id': categoryId,
        'name': name,
        'id': id,
        'category': category,
        'price': price,
        'description': description,
      };
}
