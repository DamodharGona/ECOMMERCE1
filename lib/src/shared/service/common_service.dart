import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:ecommerce/src/core/model/firebase_response_model.dart';
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
}
