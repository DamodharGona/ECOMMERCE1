import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:ecommerce/src/core/model/firebase_response_model.dart';

class CommonService {
  CommonService._privateConstructor();
  static final CommonService instance = CommonService._privateConstructor();

  // A generic function to get JSON data from assets
  Future<T> loadJsonFromAssets<T, P>({
    required String path,
    required Function tFromJson,
    bool isList = false,
  }) async {
    try {
      // Load the asset file as a string
      final String jsonString = await rootBundle.loadString(path);

      // Decode the string into a JSON object
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);

      /* Convert the JSON object to the desired type using the 
         provided fromJson function */
      return ApiResponse.fromJson<T, P>(
        jsonMap,
        tFromJson,
        isList: isList,
      ).data;
    } catch (e) {
      throw Exception('Error loading JSON from assets: $e');
    }
  }
}
