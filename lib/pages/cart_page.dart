// import 'package:dart:html';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_tutorial_shop/util/data_class.dart';
import 'package:provider_tutorial_shop/widgets/product_gridview.dart';

class ShopCart extends StatefulWidget {
  const ShopCart({Key? key}) : super(key: key);

  @override
  State<ShopCart> createState() => _ShopCartState();
}

class _ShopCartState extends State<ShopCart> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<ShopProvider>(builder: (context, shopProvider, child) {
      return Scaffold(
          appBar: AppBar(
            title: const Text("Cart"),
          ),
          body: Stepper(
            type: StepperType.horizontal,
            physics: const ScrollPhysics(),
            currentStep: _currentStep,
            onStepTapped: (step) => tapped(step),
            onStepContinue: continued,
            onStepCancel: cancel,
            steps: <Step>[
              Step(
                  title: const Text("Cart"),
                  content: SizedBox(
                      height: 467,
                      child: ProductsGridView(
                          products: shopProvider.cartItems, isCart: true))),
              const Step(
                  title: const Text("Check Out & Payment"),
                  content: const PersonalDetails())
            ],
          ));
    });
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}

class PersonalDetails extends StatelessWidget {
  const PersonalDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: const InputDecoration(
                border: OutlineInputBorder(), labelText: "Full Name"),
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "Phone Number"),
            )),Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                  border: const OutlineInputBorder(), labelText: "Email Address"),
            )),Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                  border: const OutlineInputBorder(), labelText: "Visa/Master Card Number"),
            )),
      ],
    );
  }
}
