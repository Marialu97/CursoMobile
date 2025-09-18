import 'package:firebase_auth/firebase_auth.dart'; // Biblioteca que cuida do login pelo Firebase
import 'package:flutter/material.dart'; // Biblioteca para construir a tela e os botões
import 'package:formativa_cine_favorite/registro_view.dart'; // Tela para criar conta nova

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // Aqui guardamos o que o usuário digita no campo de email
  final _emailController = TextEditingController();
  // Aqui guardamos o que o usuário digita no campo de senha
  final _senhaController = TextEditingController();

  // Essa variável é quem vai fazer o login no Firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Essa variável controla se a senha aparece ou fica escondida
  bool _senhaOculta = true;

  // Função que tenta fazer o login usando o email e senha digitados
  void _login() async {
    try {
      // Tenta entrar com o email e senha
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(), // Pega o email e tira espaços extras
        password: _senhaController.text, // Pega a senha digitada
      );
      // Se der certo, a tela principal vai perceber e abrirá outra página automaticamente
    } catch (e) {
      // Se der erro (email errado, senha errada...), mostra essa mensagem na tela
      ScaffoldMessenger.of(
        context,
        ).showSnackBar(
        SnackBar(content: Text("Falha ao fazer login: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("CineFavorite - Login")), // Barra no topo com o título do app
      body: Padding(
        padding: EdgeInsets.all(16), // Espaço ao redor da tela
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centraliza tudo no meio da tela
          children: [
            // Campo onde o usuário digita o email
            TextField(
              controller: _emailController, // Guarda o que foi digitado
              decoration: InputDecoration(labelText: "Email"), // Mostra a palavra "Email" como dica
              keyboardType: TextInputType.emailAddress, // Teclado já adaptado para digitar email
            ),
            
            // Campo onde o usuário digita a senha
            TextField(
              controller: _senhaController, // Guarda a senha digitada
              decoration: InputDecoration(
                labelText: "Senha", // Mostra a palavra "Senha"
                suffixIcon: IconButton( // Botão pequeno no fim do campo para mostrar/esconder a senha
                  onPressed: () {
                    setState(() {
                      _senhaOculta = !_senhaOculta; // Muda de "escondido" para "visível" e vice-versa
                    });
                  },
                  icon: Icon(
                    _senhaOculta ? Icons.visibility : Icons.visibility_off, // Mostra o ícone certo
                  ),
                ),
              ),
              obscureText: _senhaOculta, // Se true, mostra bolinhas; se false, mostra a senha normal
            ),

            SizedBox(height: 20), // Espaço em branco entre os botões

            // Botão que chama a função para fazer login
            ElevatedButton(
              onPressed: _login, // Quando clicar aqui, tenta entrar
              child: Text("Entrar"), // Texto dentro do botão
            ),

            // Botão para quem não tem conta ainda e quer se cadastrar
            TextButton(
              onPressed: () {
                // Leva o usuário para a tela de cadastro
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegistroView()),
                );
              },
              child: Text("Não tem uma conta? Cadastre-se"), // Texto do botão
            ),
          ],
        ),
      ),
    );
  }
}
