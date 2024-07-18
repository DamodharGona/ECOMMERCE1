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
  final String ownerId;
  final String name;
  final String address1;
  final String address2;
  final String address3;
  final int pinCode;
  final String townOrCity;
  final String stateId;
  final bool isStoreVerified;
  final String createdAt;
  final String verifiedBy;
  final String verifiedAt;

  const Store({
    this.id = '',
    this.ownerId = '',
    this.name = '',
    this.address1 = '',
    this.address2 = '',
    this.address3 = '',
    this.pinCode = 0,
    this.townOrCity = '',
    this.stateId = '',
    this.isStoreVerified = false,
    this.createdAt = '',
    this.verifiedBy = '',
    this.verifiedAt = '',
  });

  Store copyWith({
    String? id,
    String? ownerId,
    String? name,
    String? address1,
    String? address2,
    String? address3,
    int? pinCode,
    String? townOrCity,
    String? stateId,
    bool? isStoreVerified,
    String? createdAt,
    String? verifiedBy,
    String? verifiedAt,
  }) {
    return Store(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      name: name ?? this.name,
      address1: address1 ?? this.address1,
      address2: address2 ?? this.address2,
      address3: address3 ?? this.address3,
      pinCode: pinCode ?? this.pinCode,
      townOrCity: townOrCity ?? this.townOrCity,
      stateId: stateId ?? this.stateId,
      isStoreVerified: isStoreVerified ?? this.isStoreVerified,
      createdAt: createdAt ?? this.createdAt,
      verifiedBy: verifiedBy ?? this.verifiedBy,
      verifiedAt: verifiedAt ?? this.verifiedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'ownerId': ownerId,
      'name': name,
      'address1': address1,
      'address2': address2,
      'address3': address3,
      'pinCode': pinCode,
      'townOrCity': townOrCity,
      'stateId': stateId,
      'isVerified': isStoreVerified,
      'createdAt': createdAt,
      'verifiedAt': verifiedAt,
      'verifiedBy': verifiedBy,
    };
  }

  factory Store.fromJson(Map<String, dynamic> map) {
    return Store(
      id: map['id'] ?? '',
      ownerId: map['ownerId'] ?? '',
      name: map['name'] ?? '',
      address1: map['address1'] ?? '',
      address2: map['address2'] ?? '',
      address3: map['address3'] ?? '',
      pinCode: map['pinCode'] ?? 000000,
      townOrCity: map['townOrCity'] ?? '',
      stateId: map['stateId'] ?? '',
      isStoreVerified: map['isVerified'] ?? false,
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
        ownerId,
        townOrCity,
        stateId,
        isStoreVerified,
      ];
}
