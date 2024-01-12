class Article {
  //construct avec named parameters and required
  String nom;
  String description;
  num prix;
  String image;
  String categorie;

  // méthode retournant le prix

  String getPrix() => "$prix€";



  Article({
    required this.nom,
    required this.description,
    required this.prix,
    required this.image,
    required this.categorie,
  });

  Map<String, dynamic> toMap() {
    return {
      'nom': this.nom,
      'description': this.description,
      'prix': this.prix,
      'image': this.image,
      'categorie': this.categorie,
    };
  }

  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      nom: map['title'] as String,
      description: map['description'] as String,
      prix: map['price'] as num,
      image: map['image'] as String,
      categorie: map['category'] as String,
    );
  }
}
