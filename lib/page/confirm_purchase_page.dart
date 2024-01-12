import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../bo/cart.dart';

class ConfirmPurchasePage extends StatefulWidget {
  const ConfirmPurchasePage({super.key});
  
  @override
  State<StatefulWidget> createState() => _ConfirmPurchasePage(); 
}

class _ConfirmPurchasePage extends State<ConfirmPurchasePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Row(
              children: [
                Text("Finalisation de la commande",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Spacer(),
              ]
          ),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        )
    );
  }
}