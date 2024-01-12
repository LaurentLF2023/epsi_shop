import 'package:epsi_shop/bo/article.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../bo/cart.dart';

class CartPage extends StatelessWidget {
  const CartPage ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text("Panier EPSI Shop",
            style: TextStyle(fontWeight: FontWeight.bold)),
            Spacer(),
          ]
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea (
          child:
            context.watch<Cart>().items.isNotEmpty ? ListCart() : EmptyCart(),
      ),
    );
  }
}

class EmptyCart extends StatelessWidget {
  const EmptyCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Text("Votre panier total est de",
               style: TextStyle(fontWeight: FontWeight.bold)),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(right:20.0),
                child: Text("0.00€",
                 style: TextStyle(fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
        Spacer(),
        Column(
          children: [
            Text("Votre panier est actuellement vide",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Icon(Icons.image)
          ],
        ),
        Spacer()
      ],
    );
  }
}

class ListCart extends StatelessWidget {
  const ListCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, cart, _) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Text("Votre panier total est de",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right:20.0),
                  child: Text( "${cart.items.fold<num>(0, (previousValue, Article article) =>
                    previousValue + article.prix)}€",
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),
          Flexible(
            child: ListView.builder(
                itemCount: cart.items.length,
                  itemBuilder: (context,index) => ListTile(
                      leading: Image.network(cart.items[index].image),
                      title: Text(cart.items[index].nom,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(cart.items[index].getPrix()),
                      trailing: TextButton(
                          onPressed: () => context.read<Cart>()
                              .removeArticle(cart.items[index]),
                          child: const Text('Supprimer')
                      )
                  )
              ),
          ),
          FilledButton(
            onPressed: () => context.go('/confirm-purchase'),
            style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary),
            child: const Text('Procéder au paiement'),
          ),
        ],
      ),
    );
  }
}

