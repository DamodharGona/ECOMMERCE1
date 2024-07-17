import 'package:equatable/equatable.dart';

class MerchantModel {
  final String id;
  final String name;
  final String emalId;
  final Store store;

  const MerchantModel({
    this.id = '',
    this.name = '',
    this.emalId = '',
    this.store = const Store(),
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'emalId': emalId,
      'store': store.toJson(),
    };
  }

  factory MerchantModel.fromJson(Map<String, dynamic> map) {
    return MerchantModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      emalId: map['emalId'] ?? '',
      store: map['store'] != null
          ? Store.fromJson(map['store'] as Map<String, dynamic>)
          : const Store(),
    );
  }
}

class Store extends Equatable {
  final String id;
  final String name;
  final String address1;
  final String address2;
  final String address3;
  final int pinCode;
  final String townOrCity;
  final String stateId;

  const Store({
    this.id = '',
    this.name = '',
    this.address1 = '',
    this.address2 = '',
    this.address3 = '',
    this.pinCode = 0,
    this.townOrCity = '',
    this.stateId = '',
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'address1': address1,
      'address2': address2,
      'address3': address3,
      'pinCode': pinCode,
      'townOrCity': townOrCity,
      'stateId': stateId,
    };
  }

  factory Store.fromJson(Map<String, dynamic> map) {
    return Store(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      address1: map['address1'] ?? '',
      address2: map['address2'] ?? '',
      address3: map['address3'] ?? '',
      pinCode: map['pinCode'] ?? 000000,
      townOrCity: map['townOrCity'] ?? '',
      stateId: map['stateId'] ?? '',
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        address1,
        address2,
        address3,
        pinCode,
        townOrCity,
        stateId,
      ];
}
