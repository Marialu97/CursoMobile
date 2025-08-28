class BookModel {
  // Atributos
  final String? id; // pode ser nulo
  final String title;
  final String author;
  final bool avaliable;

  // Construtor
  BookModel({
    this.id,
    required this.title,
    required this.author,
    required this.avaliable
  });

  // Métodos
  // toJson
  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "author": author,
        "avaliable": avaliable
      };

  // fromJson
  factory BookModel.fromMap(Map<String, dynamic> map) => BookModel(
        id: map["id"]?.toString(),
        title: map["title"].toString(),
        author: map["author"].toString(),
        avaliable: map["avaliable"] == true ? true : false);
}
