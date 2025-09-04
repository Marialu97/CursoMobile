import 'package:biblioteca_app/controllers/book_controller.dart';
import 'package:biblioteca_app/models/book_model.dart';
import 'package:biblioteca_app/views/home_view.dart';
import 'package:flutter/material.dart';

class BookFormView extends StatefulWidget {
  final BookModel? book; // Pode ser nulo para novo livro

  const BookFormView({super.key, this.book});

  @override
  State<BookFormView> createState() => _BookFormViewState();
}

class _BookFormViewState extends State<BookFormView> {
  final _formKey = GlobalKey<FormState>();
  final _controller = BookControler();

  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  bool _avaliable = true; // padrão disponível

  @override
  void initState() {
    super.initState();
    if (widget.book != null) {
      _titleController.text = widget.book!.title;
      _authorController.text = widget.book!.author;
      _avaliable = widget.book!.avaliable;
    }
  }

  void _save() async {
    if (_formKey.currentState!.validate()) {
      final book = BookModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        author: _authorController.text,
        avaliable: _avaliable,
      );
      await _controller.create(book);
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeView()),
      );
    }
  }

  void _update() async {
    if (_formKey.currentState!.validate()) {
      final book = BookModel(
        id: widget.book!.id,
        title: _titleController.text,
        author: _authorController.text,
        avaliable: _avaliable,
      );
      await _controller.update(book);
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book == null ? "Novo Livro" : "Editar Livro"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: "Título"),
                validator: (value) =>
                    value!.isEmpty ? "Informe o título" : null,
              ),
              TextFormField(
                controller: _authorController,
                decoration: InputDecoration(labelText: "Autor"),
                validator: (value) =>
                    value!.isEmpty ? "Informe o autor" : null,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text("Disponível"),
                  Checkbox(
                    value: _avaliable,
                    onChanged: (value) {
                      setState(() {
                        _avaliable = value ?? false;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: widget.book == null ? _save : _update,
                child: Text(widget.book == null ? "Salvar" : "Atualizar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
