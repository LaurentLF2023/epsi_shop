import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
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
            Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Theme.of(context).colorScheme.outline),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Recapitulatif de la commande"),
                        Spacer(),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Sous total"),
                        Spacer(),
                        Text("total - tva")
                      ],
                    ),
                    Row(
                      children: [
                        Text("TVA"),
                        Spacer(),
                        Text("20% du total")
                      ],
                    ),
                    Row(
                      children: [
                        Text("TOTAL"),
                        Spacer(),
                        Text("20% du total")
                      ],
                    ),
                  ],
                )
            ),
          Row(
            children: [
              Text("Adresse de livraison"),
              Spacer(),
            ],
          ),
          Card(
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
        ]
      ),
      floatingActionButton: FilledButton(
        onPressed: () => context.go('/confirm-purchase'),
        style: FilledButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary),
        child: const Text('Procéder au paiement'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
