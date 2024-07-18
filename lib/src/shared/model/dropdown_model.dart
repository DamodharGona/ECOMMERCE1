import 'package:equatable/equatable.dart';

class DropdownModel extends Equatable {
  final String id;
  final String value;

  const DropdownModel({
    this.id = '',
    this.value = '',
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'value': value,
    };
  }

  factory DropdownModel.fromJson(Map<String, dynamic> map) {
    return DropdownModel(
      id: map['id'] ?? '',
      value: map['value'] ?? '',
    );
  }

  factory DropdownModel.fromStatesJson(Map<String, dynamic> map) {
    return DropdownModel(
      id: map['code'] ?? '',
      value: map['name'] ?? '',
    );
  }

  @override
  List<Object?> get props => [id, value];
}
