import 'package:biblioteca_app/models/user_model.dart';
import 'package:biblioteca_app/services/api_service.dart';

class UserControler {
  //obs: não precisa instaciar obj de ApiService (métodos static)
  // final Obj = ApiService();

  //métodos
  // GET dos Usuários
  Future<List<UserModel>> fetchAll() async {
    final list = await ApiService.getList(
      "users?_sort=name",
    ); //?_sort=name -> flag para organizar em order alfabetica
    // retorna a lista de Usuário Convertidas para User Model Lista<dynamic> => Lista<OBJ>
    return list.map<UserModel>((item) => UserModel.fromJson(item)).toList();
  }

  // POST -> Criar novo usuário
  Future<UserModel> create(UserModel u) async {
    final created = await ApiService.post("users", u.toJson());
    // adiciona um Usuário e Retorna o /usuário Criado -> ID
    return UserModel.fromJson(created);
  }

  // GET -> Buscar um Usuário
  Future<UserModel> fetchOne(String id) async {
    final user = await ApiService.getOne("users", id);
    // Retorna o Usuário Encontrado no Banco de Dados
    return UserModel.fromJson(user);
  }

  // PUT -> Atualizar Usuário
  Future<UserModel> updat(UserModel u) async {
    final updated = await ApiService.put("users", u.toJson(), u.id!);
    // retorna o Usuário Atualizado
    return UserModel.fromJson(updated);
  }

  Future<void> delete(String id) async {
    await ApiService.delete("users", id);
    // Não há retorno, usuário deletado com sucesso
  }

  Future<void> update(UserModel user) async {}
}
