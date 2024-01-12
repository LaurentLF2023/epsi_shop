import 'package:epsi_shop/bo/article.dart';
import 'package:flutter/material.dart';

class Cart with ChangeNotifier{
  final _items = <Article>[];

  List<Article> get items => _items;

  void addArticle(Article article) {
    _items.add(article);
    notifyListeners();
  }

  void removeArticles(){
    _items.clear();
    notifyListeners();
  }

  void removeArticle(Article article){
    _items.remove(article);
      notifyListeners();
  }

}