import 'package:biblioteca_app/models/loans_model.dart';
import 'package:biblioteca_app/services/api_service.dart';

class LoanController {
  // Buscar todos os empréstimos
  Future<List<LoanModel>> fetchAll() async {
    final list = await ApiService.getList("loans?_sort=returnDate");
    return list.map<LoanModel>((item) => LoanModel.fromMap(item)).toList();
  }

  // Buscar um empréstimo específico pelo ID
  Future<LoanModel> fetchOne(String id) async {
    final data = await ApiService.getOne("loans", id);
    return LoanModel.fromMap(data);
  }

  // Criar um novo empréstimo
  Future<LoanModel> create(LoanModel loan) async {
    final created = await ApiService.post("loans", loan.toMap());
    return LoanModel.fromMap(created);
  }

  // Atualizar um empréstimo existente
  Future<LoanModel> update(LoanModel loan) async {
    final updated = await ApiService.put("loans", loan.toMap(), loan.id!);
    return LoanModel.fromMap(updated);
  }

  // Deletar um empréstimo
  Future<void> delete(String id) async {
    await ApiService.delete("loans", id);
  }
}