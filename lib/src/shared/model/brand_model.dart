class BrandModel {
  final String brandName;
  final String brandLogo;
  final String brandDescription;
  final String categoryId;

  const BrandModel({
    this.brandName = '',
    this.brandLogo = '',
    this.brandDescription = '',
    this.categoryId = '',
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'brandName': brandName,
      'brandLogo': brandLogo,
      'brandDescription': brandDescription,
      'categoryId': categoryId,
    };
  }

  factory BrandModel.fromJson(Map<String, dynamic> map) {
    return BrandModel(
      brandName: map['brandName'] ?? '',
      brandLogo: map['brandLogo'] ?? '',
      brandDescription: map['brandDescription'] ?? '',
      categoryId: map['categoryId'] ?? '',
    );
  }
}
