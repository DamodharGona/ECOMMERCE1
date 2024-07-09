import 'package:equatable/equatable.dart';

class ApiResponse<T> extends Equatable {
  final T data;

  const ApiResponse({required this.data});

  static ApiResponse<T> fromJson<T, P>(
    Map<dynamic, dynamic> json,
    Function tFromJson, {
    bool isList = true,
  }) {
    return ApiResponse<T>(
      data: isList
          ? (json['results'] as List<dynamic>)
              .map((dynamic data) => tFromJson(data) as P)
              .toList()
          : tFromJson(json['results'] as P),
    );
  }

  @override
  List<Object?> get props => <Object?>[data];
}
