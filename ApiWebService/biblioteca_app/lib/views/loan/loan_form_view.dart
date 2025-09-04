import 'package:biblioteca_app/models/loans_model.dart';
import 'package:flutter/material.dart';
import 'package:biblioteca_app/models/loan_model.dart';
import 'package:biblioteca_app/models/user_model.dart';
import 'package:biblioteca_app/models/book_model.dart';
import 'package:biblioteca_app/controllers/loan_controller.dart';
import 'package:biblioteca_app/controllers/user_controller.dart';
import 'package:biblioteca_app/controllers/book_controller.dart';
import 'package:biblioteca_app/views/home_view.dart';

class LoanFormView extends StatefulWidget {
  final LoanModel? loan;

  const LoanFormView({super.key, this.loan});

  @override
  State<LoanFormView> createState() => _LoanFormViewState();
}

class _LoanFormViewState extends State<LoanFormView> {
  final _formKey = GlobalKey<FormState>();
  final _loanController = LoanController();
  final _userController = UserController();
  final _bookController = BookController();

  List<UserModel> _users = [];
  List<BookModel> _books = [];

  UserModel? _selectedUser;
  BookModel? _selectedBook;
  DateTime? _returnDate;
  bool _active = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUsersAndBooks();

    if (widget.loan != null) {
      _selectedUser = widget.loan!.userId as UserModel?;
      _selectedBook = widget.loan!.bookId as BookModel?;
      _returnDate = widget.loan!.returnDate;
      _active = widget.loan!.active;
    }
  }

  Future<void> _loadUsersAndBooks() async {
    final users = await _userController.fetchAll();
    final books = await _bookController.fetchAll();
    setState(() {
      _users = users;
      _books = books;
    });
  }

  Future<void> _saveOrUpdate() async {
    if (_formKey.currentState!.validate() &&
        _selectedUser != null &&
        _selectedBook != null &&
        _returnDate != null) {
      setState(() => _isLoading = true);

      final loan = LoanModel(
        id: widget.loan?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        user: _selectedUser!,
        book: _selectedBook!,
        returnDate: _returnDate!,
        active: _active, userId: '', bookId: '', loanDate: widget.loan?.loanDate ?? DateTime.now(),
      );

      try {
        if (widget.loan == null) {
          await _loanController.create(loan);
          _showSnackBar('Empréstimo salvo com sucesso!');
        } else {
          await _loanController.update(loan);
          _showSnackBar('Empréstimo atualizado com sucesso!');
        }
        // Aguarda o SnackBar antes de navegar
        await Future.delayed(const Duration(milliseconds: 500));
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeView()),
          );
        }
      } catch (e) {
        _showSnackBar('Erro ao salvar: $e');
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _returnDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _returnDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.loan == null ? "Novo Empréstimo" : "Editar Empréstimo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _users.isEmpty || _books.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Form(
                key: _formKey,
                child: ListView(
                  children: [
                    DropdownButtonFormField<UserModel>(
                      value: _selectedUser,
                      items: _users.map((user) {
                        return DropdownMenuItem(
                          value: user,
                          child: Text(user.name),
                        );
                      }).toList(),
                      onChanged: (value) => setState(() => _selectedUser = value),
                      decoration: const InputDecoration(labelText: "Usuário"),
                      validator: (value) => value == null ? "Selecione um usuário" : null,
                    ),
                    DropdownButtonFormField<BookModel>(
                      value: _selectedBook,
                      items: _books.map((book) {
                        return DropdownMenuItem(
                          value: book,
                          child: Text(book.title),
                        );
                      }).toList(),
                      onChanged: (value) => setState(() => _selectedBook = value),
                      decoration: const InputDecoration(labelText: "Livro"),
                      validator: (value) => value == null ? "Selecione um livro" : null,
                    ),
                    ListTile(
                      title: Text(
                        _returnDate == null
                            ? "Selecione a data de devolução"
                            : "Data de devolução: ${_returnDate!.day}/${_returnDate!.month}/${_returnDate!.year}",
                      ),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: _selectDate,
                    ),
                    SwitchListTile(
                      title: const Text("Ativo"),
                      value: _active,
                      onChanged: (value) => setState(() => _active = value),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _saveOrUpdate,
                      child: Text(_isLoading
                          ? "Processando..."
                          : widget.loan == null
                              ? "Salvar"
                              : "Atualizar"),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}