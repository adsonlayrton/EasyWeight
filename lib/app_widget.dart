import 'package:easy_weight/cadastrarProduto.dart';
import 'package:easy_weight/calcularPreco.dart';
import 'package:easy_weight/administrador.dart';
import 'package:easy_weight/editarProduto.dart';
import 'package:easy_weight/selecionarProdutos.dart';
import 'package:easy_weight/inicio.dart';
import 'package:easy_weight/login.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/inicio',
      routes: {
        '/inicio': (context) => const inicio(),
        '/administrador': (context) => const administrador(),
        '/editar': (context) => const editarProduto(),
        '/calcular': (context) => const calcularPreco(),
        '/cadastrar': (context) => const cadastrarProduto(),
        '/login': (context) => const login(),
        '/selecionar': (context) => const selecionarProduto(),
      },
    );
  }
}
