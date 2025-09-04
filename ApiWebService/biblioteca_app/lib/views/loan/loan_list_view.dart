import 'package:biblioteca_app/models/loans_model.dart';
import 'package:flutter/material.dart';
import 'package:biblioteca_app/controllers/loan_controller.dart';
import 'package:biblioteca_app/views/loan/loan_form_view.dart';

class LoanListView extends StatefulWidget {
  const LoanListView({super.key});

  @override
  State<LoanListView> createState() => _LoanListViewState();
}

class _LoanListViewState extends State<LoanListView> {
  final _controller = LoanController();
  List<LoanModel> _loans = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() async {
    setState(() => _loading = true);
    _loans = await _controller.fetchAll();
    setState(() => _loading = false);
  }

  void _delete(LoanModel loan) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Excluir Empréstimo"),
        content: Text("Deseja excluir o empréstimo do livro ID '${loan.bookId}'?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text("Cancelar"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text("Excluir"),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await _controller.delete(loan.id!);
      _load();
    }
  }

  void _openForm({LoanModel? loan}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoanFormView(loan: loan),
      ),
    );
    _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: _loans.length,
              itemBuilder: (context, index) {
                final loan = _loans[index];
                return Card(
                  child: ListTile(
                    title: Text("Livro ID: ${loan.bookId}"),
                    subtitle: Text("Usuário ID: ${loan.userId}\n"
                        "Devolução: ${loan.returnDate != null ? "${loan.returnDate!.day}/${loan.returnDate!.month}/${loan.returnDate!.year}" : "Não definida"}"),
                    leading: Icon(
                      Icons.book,
                      color: Colors.green,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => _openForm(loan: loan),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _delete(loan),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openForm(),
        child: Icon(Icons.add),
      ),
    );
  }
}