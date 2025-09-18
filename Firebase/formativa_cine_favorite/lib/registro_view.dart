import 'package:firebase_auth/firebase_auth.dart'; // Biblioteca do Firebase para autenticação
import 'package:flutter/material.dart'; // Biblioteca para construir a interface

class RegistroView extends StatefulWidget {
  const RegistroView({super.key});

  @override
  State<RegistroView> createState() => _RegistroViewState();
}

class _RegistroViewState extends State<RegistroView> {
  // Aqui guardamos o que o usuário digita no campo de email
  final _emailField = TextEditingController();
  // Aqui guardamos o que o usuário digita na senha
  final _senhaField = TextEditingController();
  // Aqui guardamos a confirmação da senha, para verificar se as duas batem
  final _confSenhaField = TextEditingController();

  // Quem vai cuidar da criação da conta no Firebase
  final _authController = FirebaseAuth.instance;

  // Controla se a senha fica escondida ou visível (senha principal)
  bool _senhaOculta = true;
  // Controla se a senha fica escondida ou visível (confirmação da senha)
  bool _confSenhaOculta = true;

  // Função para tentar criar uma nova conta
  void _registrar() async {
    // Primeiro verifica se as senhas digitadas são iguais
    if (_senhaField.text != _confSenhaField.text) {
      // Se forem diferentes, não faz nada (você pode melhorar mostrando uma mensagem)
      return;
    }

    try {
      // Tenta criar a conta no Firebase usando email e senha
      await _authController.createUserWithEmailAndPassword(
        email: _emailField.text.trim(), // Pega o email e tira espaços extras
        password: _senhaField.text, // Pega a senha digitada
      );
      // Se deu certo, fecha essa tela e volta para a tela anterior (login)
      Navigator.pop(context);
      // Quando cria a conta, o usuário já fica logado automaticamente
    } catch (e) {
      // Se deu erro (email já usado, senha fraca...), mostra essa mensagem na tela
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Falha ao registrar: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registro")), // Barra no topo com o título
      body: Padding(
        padding: EdgeInsets.all(16), // Espaço ao redor do conteúdo
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centraliza na tela
          children: [
            // Campo para digitar email
            TextField(
              controller: _emailField,
              decoration: InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress, // Teclado para email
            ),
            // Campo para digitar senha
            TextField(
              controller: _senhaField,
              decoration: InputDecoration(
                labelText: "Senha",
                suffixIcon: IconButton(
                  onPressed: () => setState(() {
                    _senhaOculta = !_senhaOculta; // Troca entre mostrar e esconder senha
                  }),
                  icon: Icon(
                    _senhaOculta ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
              obscureText: _senhaOculta, // Se true, esconde a senha com bolinhas
            ),
            // Campo para confirmar a senha
            TextField(
              controller: _confSenhaField,
              decoration: InputDecoration(
                labelText: "Confirmar Senha",
                suffixIcon: IconButton(
                  onPressed: () => setState(() {
                    _confSenhaOculta = !_confSenhaOculta; // Troca visibilidade da confirmação
                  }),
                  icon: Icon(
                    _confSenhaOculta ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
              obscureText: _confSenhaOculta, // Esconde a confirmação da senha
            ),
            SizedBox(height: 20), // Espaço entre os campos e o botão

            // Botão para criar a conta
            ElevatedButton(
              onPressed: _registrar, // Quando clicar, tenta registrar
              child: Text("Registrar"),
            ),
          ],
        ),
      ),
    );
  }
}
