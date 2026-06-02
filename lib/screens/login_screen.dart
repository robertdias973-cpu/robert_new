import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  bool carregando = false;
  bool esconderSenha = true;

  Future<void> login() async {
    setState(() {
      carregando = true;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: senhaController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      String mensagem = "Erro ao entrar";

      if (e.code == 'user-not-found') {
        mensagem = "Usuário não encontrado";
      } else if (e.code == 'wrong-password') {
        mensagem = "Senha incorreta";
      } else if (e.code == 'invalid-email') {
        mensagem = "Email inválido";
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(mensagem)),
        );
      }
    }

    if (mounted) {
      setState(() {
        carregando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const verdeFit = Color(0xFF00E676);

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: Column(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E1E),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: verdeFit,
                      width: 3,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'FT',
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: verdeFit,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'fitTreino',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Seu treino organizado em um só lugar',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 40),

                TextField(
                  controller: emailController,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: const TextStyle(
                      color: verdeFit,
                    ),
                    prefixIcon: const Icon(
                      Icons.email,
                      color: verdeFit,
                    ),
                    filled: true,
                    fillColor: const Color(0xFF1E1E1E),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(15),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                TextField(
                  controller: senhaController,
                  obscureText: esconderSenha,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    labelStyle: const TextStyle(
                      color: verdeFit,
                    ),
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: verdeFit,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        esconderSenha
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: verdeFit,
                      ),
                      onPressed: () {
                        setState(() {
                          esconderSenha =
                              !esconderSenha;
                        });
                      },
                    ),
                    filled: true,
                    fillColor: const Color(0xFF1E1E1E),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(15),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed:
                        carregando ? null : login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: verdeFit,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(15),
                      ),
                    ),
                    child: carregando
                        ? const CircularProgressIndicator()
                        : const Text(
                            'ENTRAR',
                            style: TextStyle(
                              fontWeight:
                                  FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 20),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const RegisterScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Não possui conta? Cadastre-se',
                    style: TextStyle(
                      color: verdeFit,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}