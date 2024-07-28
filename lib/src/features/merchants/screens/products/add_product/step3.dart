import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce/src/shared/widgets/my_text_field_widget.dart';

class Step3 extends StatelessWidget {
  final TextEditingController productNameController;
  final TextEditingController productPriceController;
  final TextEditingController productDescriptionController;
  final TextEditingController specificationController;
  final TextEditingController discountPercentController;
  final List<String> specificationsList;
  final bool isOutOfStock;
  final Function(bool)? onChanged;

  const Step3({
    super.key,
    required this.productNameController,
    required this.productPriceController,
    required this.productDescriptionController,
    required this.specificationController,
    required this.discountPercentController,
    required this.specificationsList,
    required this.isOutOfStock,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        MyTextFieldWidget(
          text: 'Name',
          controller: productNameController,
        ),
        const SizedBox(height: 20),
        MyTextFieldWidget(
          text: 'Price',
          isDecimal: true,
          keyboardType: const TextInputType.numberWithOptions(
            decimal: true,
          ),
          controller: productPriceController,
        ),
        const SizedBox(height: 20),
        MyTextFieldWidget(
          text: 'Description',
          isAddress: true,
          controller: productDescriptionController,
        ),
        const SizedBox(height: 20),
        _SpecificationsInputWidget(
            specificationController: specificationController,
            specificationsList: specificationsList,
            onPressed: () {
              if (specificationController.text.isNotEmpty) {
                specificationsList.add(specificationController.text);
                (context as Element).markNeedsBuild();
              }
            },
            onDismissed: (String specification) {
              specificationsList.remove(specification);
              (context as Element).markNeedsBuild();
            }),
        const SizedBox(height: 20),
        MyTextFieldWidget(
          text: 'Discount Percent',
          isDecimal: true,
          maxLength: 4,
          keyboardType: const TextInputType.numberWithOptions(
            decimal: true,
          ),
          controller: discountPercentController,
        ),
        const SizedBox(height: 20),
        ListTile(
          title: const Text(
            'Is Out Of Stock',
            style: TextStyle(fontSize: 20),
          ),
          contentPadding: EdgeInsets.zero,
          trailing: CupertinoSwitch(
            value: isOutOfStock,
            activeColor: Colors.indigoAccent,
            onChanged: onChanged,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _SpecificationsInputWidget extends StatelessWidget {
  final TextEditingController specificationController;
  final List<String> specificationsList;
  final Function()? onPressed;
  final Function(String specification)? onDismissed;

  const _SpecificationsInputWidget({
    required this.specificationController,
    required this.specificationsList,
    this.onPressed,
    this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: TextFormField(
                  controller: specificationController,
                  decoration: InputDecoration(
                    hintText: 'Enter Specifications',
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                    contentPadding: const EdgeInsets.only(left: 10),
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(40, 40),
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.indigoAccent,
                  foregroundColor: Colors.white,
                ),
                child: const Icon(Icons.add, size: 30),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...specificationsList.map(
            (item) => Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        item,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    IconButton(
                      onPressed: () => onDismissed?.call(item),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const Divider(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
