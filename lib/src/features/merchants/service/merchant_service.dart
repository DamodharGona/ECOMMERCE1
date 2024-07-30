import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ecommerce/src/core/service/firebase_service.dart';
import 'package:ecommerce/src/shared/model/merchant_model.dart';
import 'package:ecommerce/src/shared/model/product_model.dart';
import 'package:ecommerce/src/shared/service/app_shared_pref.dart';
import 'package:ecommerce/src/shared/service/firebase_auth_service.dart';

class MerchantService {
  MerchantService._privateConstructor();
  static final MerchantService instance = MerchantService._privateConstructor();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final String currentUserId = FirebaseAuthService.instance.currentUser!.uid;

  Future<MerchantModel> fetchStoreDetails() async {
    try {
      final userId = FirebaseAuthService.instance.currentUser!.uid;

      final merchant = await FirebaseService.instance
          .getDocumentBasedOnId<MerchantModel, MerchantModel>(
        collection: 'merchants',
        documentId: userId,
        tFromJson: MerchantModel.fromJson,
      );

      final store = await FirebaseService.instance.customQuery<Store, Store>(
        tFromJson: Store.fromJson,
        isList: false,
        snapshot: await _db
            .collection('stores')
            .where('ownerId', isEqualTo: currentUserId)
            .get(),
      );

      MerchantModel merchantModel = merchant.data;

      return merchantModel.copyWith(store: store.data);
    } catch (e) {
      return const MerchantModel();
    }
  }

  Future<void> uploadProduct({
    required String ref,
    required List<File> productImages,
    required String name,
    required double price,
    required String description,
    required List<String> specifications,
    required double discountPercent,
    required bool isOutOfStock,
    required String categoryId,
    required String brandId,
  }) async {
    try {
      final merchantData = await AppSharedPrefs.instance.getMerchantData();

      List<String> imageUrls = [];

      for (int i = 0; i < productImages.length; i++) {
        final image = productImages[i];
        final imageRef = '$ref/$i';
        final imageUrl = await FirebaseService.instance.storeFileToFirebase(
          ref: imageRef,
          file: image,
        );
        imageUrls.add(imageUrl);
      }

      ProductModel productModel = ProductModel(
        categoryId: categoryId,
        shopId: merchantData.store.id,
        merchantId: merchantData.id,
        description: description,
        discountPercent: discountPercent,
        imageUrls: imageUrls,
        isOutOfStock: isOutOfStock,
        name: name,
        price: price,
        specifications: specifications,
        brandId: brandId,
      );

      await FirebaseService.instance.addDocument(
        collection: 'products',
        data: productModel.toJson(),
      );
    } catch (e) {
      throw Exception('Failed To add product $e');
    }
  }

  Future<List<ProductModel>> fetchCurrentMerchantProducts() async {
    try {
      final products = await FirebaseService.instance
          .customQuery<List<ProductModel>, ProductModel>(
        tFromJson: ProductModel.fromJson,
        isList: true,
        snapshot: await _db
            .collection('products')
            .where('merchantId', isEqualTo: currentUserId)
            .get(),
      );

      return products.data;
    } catch (e) {
      throw Exception('Error while fetching Products $e');
    }
  }
}
