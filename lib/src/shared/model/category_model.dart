import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final String id;
  final String name;
  final String imageUrl;

  const CategoryModel({
    this.id = '',
    this.name = '',
    this.imageUrl = '',
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
    };
  }

  factory CategoryModel.fromJson(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }

  @override
  List<Object?> get props => [id, name, imageUrl];
}
