class BookModel {
  // Atributos
  final String? id; // pode ser nulo
  final String title;
  final String author;
  final String genre;
  final int publicationYear;

  // Construtor
  BookModel({
    this.id,
    required this.title,
    required this.author,
    required this.genre,
    required this.publicationYear,
  });

  // Métodos
  // toJson
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "author": author,
        "genre": genre,
        "publicationYear": publicationYear,
      };

  // fromJson
  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        id: json["id"]?.toString(),
        title: json["title"].toString(),
        author: json["author"].toString(),
        genre: json["genre"].toString(),
        publicationYear: json["publicationYear"],
      );
}
