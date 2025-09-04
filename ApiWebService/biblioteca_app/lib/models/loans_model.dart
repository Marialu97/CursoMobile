import 'package:biblioteca_app/models/book_model.dart';
import 'package:biblioteca_app/models/user_model.dart';

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

  bool? get active => null;

  static Future<LoanModel> fromMap(Map<String, dynamic> data) async {
    if (data == null) {
      throw ArgumentError('data cannot be null');
    }
    return LoanModel(
      id: data["id"]?.toString(),
      userId: data["userId"].toString(),
      bookId: data["bookId"].toString(),
      loanDate: DateTime.parse(data["loanDate"]),
      returnDate: data["returnDate"] != null ? DateTime.parse(data["returnDate"]) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "userId": userId,
      "bookId": bookId,
      "loanDate": loanDate.toIso8601String(),
      "returnDate": returnDate?.toIso8601String(),
    };
  }
}
