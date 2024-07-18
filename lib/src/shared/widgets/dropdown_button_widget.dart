import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce/src/shared/model/dropdown_model.dart';

class DropdownButtonWidget extends StatelessWidget {
  final DropdownModel? selectedState;
  final String hintText;
  final List<DropdownModel> dropdownList;
  final Function(DropdownModel?)? onChanged;

  const DropdownButtonWidget({
    super.key,
    required this.hintText,
    this.selectedState,
    this.dropdownList = const [],
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        value: selectedState,
        buttonStyleData: ButtonStyleData(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Colors.black,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15),
        ),
        dropdownStyleData: DropdownStyleData(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.white,
          ),
        ),
        hint: Text(
          hintText,
          style: const TextStyle(color: Colors.grey),
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.keyboard_arrow_down_outlined,
            color: Colors.black,
          ),
          iconSize: 32,
        ),
        items: dropdownList.map((DropdownModel state) {
          return DropdownMenuItem<DropdownModel>(
            value: state,
            child: Text(state.value),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
