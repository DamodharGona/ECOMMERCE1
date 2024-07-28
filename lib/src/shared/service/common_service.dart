import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:ecommerce/src/core/model/firebase_response_model.dart';
import 'package:ecommerce/src/core/service/firebase_service.dart';
import 'package:ecommerce/src/shared/model/category_model.dart';
import 'package:ecommerce/src/shared/model/dropdown_model.dart';

class CommonService {
  CommonService._privateConstructor();
  static final CommonService instance = CommonService._privateConstructor();

  Future<List<DropdownModel>> fetchAllStates() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/json/states.json',
      );

      Map<String, dynamic> data = jsonDecode(response);

      return ApiResponse.fromJson<List<DropdownModel>, DropdownModel>(
        data,
        DropdownModel.fromStatesJson,
      ).data;
    } catch (e) {
      return [
        const DropdownModel(id: 'NA', value: 'NA'),
      ];
    }
  }

  Future<List<CategoryModel>> fetchAllCategoriesOrBrands(bool isBrand) async {
    try {
      ApiResponse<List<CategoryModel>> categories = await FirebaseService
          .instance
          .getAllDocuments<List<CategoryModel>, CategoryModel>(
        collection: isBrand ? 'brands' : 'categories',
        tFromJson: CategoryModel.fromJson,
        isList: true,
      );

      return categories.data;
    } catch (e) {
      return <CategoryModel>[];
    }
  }
}
