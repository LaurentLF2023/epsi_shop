import 'package:epsi_shop/bo/article.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../bo/cart.dart';

class DetailPage extends StatelessWidget {
  final Article article;
  const DetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Badge(
            label: Text("${context.watch<Cart>().items.length}"),
            offset: const Offset(-6, 7),
            child: IconButton(
                onPressed: ()=> context.go('/cart'),
                icon: const Icon(Icons.shopping_cart)
            ),
          )
        ],
        title: Row(
            children: [
              Spacer(),
              Text("Détail " + article.nom,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Spacer(),
            ]
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea (
          child: DetailWidget(article)
      ),
    );
  }
}

class DetailWidget extends StatelessWidget {
  final Article article;
  const DetailWidget(this.article, {
    super.key,
});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Column(
            children: [
              Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.network(
                        article.image,
                        height: 350.0,
                        width: MediaQuery.of(context).size.width,
                        fit:BoxFit.fill
                      ),
                      Text(article.nom,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),

                      SizedBox(
                        height: 16.0,
                      ),
                      Text(article.prix.toString() + "€")
                    ],
                  )
                ],
              ),
            ],
          ),
          Spacer(),
          ElevatedButton(
            onPressed: () => context.read<Cart>()
              .addArticle(article),
                child: const Text('Ajouter')
          ),
        ],
      ),
    );
  }}
