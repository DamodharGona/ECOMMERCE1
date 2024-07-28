import 'package:flutter/material.dart';

import 'package:easy_stepper/easy_stepper.dart';

class ProductStageStepper extends StatelessWidget {
  final int activeStep;
  final Function(int)? onStepReached;

  const ProductStageStepper({
    super.key,
    required this.activeStep,
    this.onStepReached,
  });

  @override
  Widget build(BuildContext context) {
    return EasyStepper(
      activeStep: activeStep,
      internalPadding: 0,
      padding: EdgeInsets.zero,
      maxReachedStep: activeStep - 1,
      lineStyle: LineStyle(
        lineLength: MediaQuery.sizeOf(context).width / 3.8,
        lineSpace: 2,
        lineThickness: 2,
        lineType: LineType.normal,
        unreachedLineType: LineType.dashed,
        unreachedLineColor: Colors.grey.withOpacity(0.5),
        finishedLineColor: Colors.indigoAccent,
        activeLineColor: Colors.grey.withOpacity(0.5),
      ),
      activeStepBorderColor: Colors.indigoAccent,
      activeStepIconColor: Colors.indigoAccent,
      activeStepTextColor: Colors.indigoAccent,
      activeStepBackgroundColor: Colors.white,
      unreachedStepBackgroundColor: Colors.grey.withOpacity(0.5),
      unreachedStepBorderColor: Colors.grey.withOpacity(0.5),
      unreachedStepIconColor: Colors.grey,
      unreachedStepTextColor: Colors.grey.withOpacity(0.5),
      finishedStepBackgroundColor: Colors.indigoAccent,
      finishedStepBorderColor: Colors.grey.withOpacity(0.5),
      finishedStepIconColor: Colors.grey,
      finishedStepTextColor: Colors.indigoAccent,
      borderThickness: 10,
      stepRadius: 10,
      showLoadingAnimation: false,
      fitWidth: true,
      steps: [
        EasyStep(
          customStep: CircleAvatar(
            radius: 8,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 7,
              backgroundColor:
                  activeStep >= 0 ? Colors.indigoAccent : Colors.white,
            ),
          ),
          title: 'Category & Brand',
        ),
        EasyStep(
          customStep: CircleAvatar(
            radius: 8,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 7,
              backgroundColor:
                  activeStep >= 1 ? Colors.indigoAccent : Colors.grey,
            ),
          ),
          title: 'Photos & Thumbnail',
          topTitle: true,
        ),
        EasyStep(
          customStep: CircleAvatar(
            radius: 8,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 7,
              backgroundColor:
                  activeStep >= 2 ? Colors.indigoAccent : Colors.grey,
            ),
          ),
          title: 'Product Details',
        ),
      ],
      onStepReached: onStepReached,
    );
  }
}
