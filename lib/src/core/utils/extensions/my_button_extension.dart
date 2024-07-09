import 'package:flutter/material.dart';

extension LoadingExtension on Widget {
  Widget withLoading(bool isLoading) {
    return isLoading
        ? Container(
            padding: const EdgeInsets.all(15),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        : this;
  }
}
