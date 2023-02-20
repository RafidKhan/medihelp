class MedicineModel {
  final String? image;
  final String? categoryId;
  final String? name;
  final String? id;
  final String? category;

  MedicineModel({
    this.image,
    this.categoryId,
    this.name,
    this.id,
    this.category,
  });

  MedicineModel.fromJson(Map<String, dynamic> json)
      : image = json['image'] ?? "",
        categoryId = json['category_id'] ?? "",
        name = json['name'] ?? "",
        id = json['id'] ?? "",
        category = json['category'] ?? "";

  Map<String, dynamic> toJson() => {
        'image': image,
        'category_id': categoryId,
        'name': name,
        'id': id,
        'category': category
      };
}
