import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String name;
  final String emailId;
  final bool isMerchant;
  final bool isSuperUser;

  const UserModel({
    this.id = '',
    this.name = '',
    this.emailId = '',
    this.isMerchant = false,
    this.isSuperUser = false,
  });

  Map<String, dynamic> toUserRegisterJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'emailId': emailId,
      'isMerchant': isMerchant,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      emailId: map['emailId'] ?? '',
      isMerchant: map['isMerchant'] ?? false,
    );
  }

  @override
  List<Object?> get props => [id, name, emailId, isMerchant];
}
