class CategoryModel {
  final String? name;
  final String? id;

  CategoryModel({
    this.name,
    this.id,
  });

  CategoryModel.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? "",
        id = json['id'] ?? "";

  Map<String, dynamic> toJson() => {'name': name, 'id': id};
}
