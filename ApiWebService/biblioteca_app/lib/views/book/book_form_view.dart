import 'package:flutter/material.dart';
import 'package:biblioteca_app/controllers/book_controller.dart';
import 'package:biblioteca_app/models/book_model.dart';
import 'package:biblioteca_app/views/home_view.dart';

class BookFormView extends StatefulWidget {
  final BookModel? book;

  const BookFormView({super.key, this.book});

  @override
  State<BookFormView> createState() => _BookFormViewState();
}

class _BookFormViewState extends State<BookFormView> {
  final _formKey = GlobalKey<FormState>();
  final _controller = BookControler();

  final _titleController = TextEditingController();
  final _authorController = TextEditingController();

  bool _avaliable = true;

  @override
  void initState() {
    super.initState();
    if (widget.book != null) {
      _titleController.text = widget.book!.title;
      _authorController.text = widget.book!.author;
      _avaliable = widget.book!.avaliable;
    }
  }

  void _saveOrUpdate() async {
    if (_formKey.currentState!.validate()) {
      final book = BookModel(
        id: widget.book?.id,
        title: _titleController.text,
        author: _authorController.text,
        avaliable: _avaliable,
      );

      if (widget.book == null) {
        await _controller.create(book);
      } else {
        await _controller.update(book);
      }

      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.book != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Editar Livro" : "Novo Livro"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: "Título"),
                validator: (value) =>
                    value!.isEmpty ? "Informe o título" : null,
              ),
              TextFormField(
                controller: _authorController,
                decoration: const InputDecoration(labelText: "Autor"),
                validator: (value) =>
                    value!.isEmpty ? "Informe o autor" : null,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: _avaliable,
                    onChanged: (value) {
                      setState(() {
                        _avaliable = value ?? true;
                      });
                    },
                  ),
                  const Text("Disponível")
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveOrUpdate,
                child: Text(isEditing ? "Atualizar" : "Salvar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
