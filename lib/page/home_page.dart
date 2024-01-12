import 'dart:convert';
import 'dart:core';

import 'package:epsi_shop/bo/article.dart';
import 'package:epsi_shop/bo/cart.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage ({super.key});

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
          ),
          IconButton(
              onPressed: () => context.go("/about-us"),
              icon: const Icon(Icons.info_outline)
          )
        ],
        title: const Row(
            children: [
              Spacer(),
              Text("Les produits Shop",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Spacer(),
            ]
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea (
        child: FutureBuilder<List<Article>>(
            future: fetchListArticles(),
            builder: (context, snapshot) =>
                snapshot.hasData? ListView.separated(
                  itemCount:snapshot.data!.length,
                  padding: const EdgeInsets.all(8),
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    return ItemArticle(myArticleList: snapshot.data!, index: index);
                  }
                ) :
                  const Icon(Icons.error))
      ),
    );
  }

  Future<List<Article>> fetchListArticles() async{
    final response = await get(Uri.parse("https://fakestoreapi.com/products"));
    if(response.statusCode == 200 && response.body.isNotEmpty){
      final listMapArticles = jsonDecode(response.body) as List<dynamic>;
      final listArticles = <Article>[];
      for(Map<String,dynamic> map in listMapArticles){
        listArticles.add(Article.fromMap(map));
      }
      return listArticles;
    } else {
      throw Exception("Erreur lors de la réception des articles");
    }
  }
}


class ItemArticle extends StatelessWidget {
  const ItemArticle({
    super.key,
    required this.myArticleList,
    required this.index,
  });

  final List myArticleList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(myArticleList[index].image),
      // modifier le title avec un text + gesture detector OnTape
      title: TextButton(
        onPressed: () => context.go('/detail', extra:myArticleList[index]),
        child: Column(
          children: [
            Text('${myArticleList[index].nom}',
                style: const TextStyle(
                    color: Colors.black
                ),
            ),
            Row(
              children: [
                Text(myArticleList[index].getPrix(),
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black)
                ),
                Spacer()
              ],
            )
          ],
        ),
      ),
      trailing: TextButton(
        onPressed: () => context.read<Cart>()
            .addArticle(myArticleList[index]),
        child: const Text('Ajouter')
      )
    );
  }
}