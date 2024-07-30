class BrandModel {
  final String id;
  final String name;
  final String imageUrl;
  final String description;
  final List<String> categoryIds;

  const BrandModel({
    this.id = '',
    this.name = '',
    this.imageUrl = '',
    this.description = '',
    this.categoryIds = const <String>[],
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'description': description,
      'categoryIds': categoryIds,
    };
  }

  factory BrandModel.fromJson(Map<String, dynamic> map) {
    return BrandModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      description: map['description'] ?? '',
      categoryIds: map['categories'] != null
          ? List<String>.from((map['categories']))
          : const <String>[],
    );
  }
}
