import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../bo/article.dart';
import '../bo/cart.dart';

class ConfirmPurchasePage extends StatelessWidget {
  const ConfirmPurchasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
            children: [
          Text("Finalisation de la commande",
              style: TextStyle(fontWeight: FontWeight.bold)),
          Spacer(),
        ]),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CartSummary(),
            ),
          Row(
            children: [
              Text("Adresse de livraison"),
              Spacer(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Theme.of(context).colorScheme.outline),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Michel le Poney"),
                        Spacer(),
                      ],
                    ),
                    Row(
                      children: [
                        Text("8 rue des ouvertures de portes"),
                        Spacer()
                      ],
                    ),
                    Row(
                      children: [
                        Text("93204 CORBEAUX"),
                        Spacer(),
                      ],
                    ),
                  ],
                )
            ),
          ),
          PaymentMethods()
        ]
      ),
      floatingActionButton:
        context.watch<Cart>().items.isNotEmpty ?
      FilledButton(
        onPressed: () => context.go('/confirm-purchase'),
        style: FilledButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary),
        child: const Text('Procéder au paiement'),
      )
            : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class CartSummary extends StatelessWidget {
  const CartSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (BuildContext context, cart , _) => Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Theme.of(context).colorScheme.outline),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      Text("Recapitulatif de la commande",
                          style: TextStyle(fontWeight: FontWeight.w800)),
                      Spacer(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:4),
                  child: Row(
                    children: [
                      Text("Sous-total"),
                      Spacer(),
                      Text("${cart.items.fold<num>(0, (previousValue, Article article) =>
                      previousValue + article.prix).round()}€")
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Text("TVA",
                          style: TextStyle(fontWeight: FontWeight.w600)
                      ),
                      Spacer(),
                      Text("${(cart.items.fold<num>(0, (previousValue, Article article) =>
                      previousValue + article.prix)*0.2).round()}€",
                        style: TextStyle(fontWeight: FontWeight.w600)
                        ,)
                    ],
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top:4),
                      child: Text("TOTAL",
                          style: TextStyle(fontWeight: FontWeight.w800)),
                    ),
                    Spacer(),
                    Text("${(cart.items.fold<num>(0, (previousValue, Article article) =>
                    previousValue + article.prix)*1.2).round()}€",
                        style: TextStyle(fontWeight: FontWeight.w800)
                    ),
                  ],
                ),
              ],
            ),
          )
      )

    );
  }
}


class PaymentMethods extends StatefulWidget {
  const PaymentMethods({ super.key });

  @override
  State<PaymentMethods> createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xFFFFE306)
    );
  }
}
