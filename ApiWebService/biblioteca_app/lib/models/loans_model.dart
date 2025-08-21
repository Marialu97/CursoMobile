class LoanModel {
  // Atributos
  final String? id; // pode ser nulo
  final String userId; // referência ao usuário que fez o empréstimo
  final String bookId; // referência ao livro emprestado
  final DateTime loanDate;
  final DateTime? returnDate; // pode ser nulo caso ainda não tenha sido devolvido

  // Construtor
  LoanModel({
    this.id,
    required this.userId,
    required this.bookId,
    required this.loanDate,
    this.returnDate,
  });

  // Métodos
  // toJson
  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "bookId": bookId,
        "loanDate": loanDate.toIso8601String(),
        "returnDate": returnDate?.toIso8601String(),
      };

  // fromJson
  factory LoanModel.fromJson(Map<String, dynamic> json) => LoanModel(
        id: json["id"]?.toString(),
        userId: json["userId"].toString(),
        bookId: json["bookId"].toString(),
        loanDate: DateTime.parse(json["loanDate"]),
        returnDate: json["returnDate"] != null ? DateTime.parse(json["returnDate"]) : null,
      );
}
