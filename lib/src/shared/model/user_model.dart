class UserModel {
  final String id;
  final String name;
  final String emailId;
  final bool isMerchant;

  const UserModel({
    this.id = '',
    this.name = '',
    this.emailId = '',
    this.isMerchant = false,
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
}
