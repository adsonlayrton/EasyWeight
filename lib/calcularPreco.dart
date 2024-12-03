// ignore_for_file: camel_case_types, prefer_const_constructors, file_names, avoid_print
import 'package:easy_weight/administrador.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async'; // Importa a biblioteca para usar Timer

class calcularPreco extends StatefulWidget {
  const calcularPreco({super.key});
  @override
  State<calcularPreco> createState() => calcularPrecoState();
}

class calcularPrecoState extends State<calcularPreco> {
  String data = 'No data yet';
  double massa = 0.0, massaFinal = 0.0;
  Timer? timer;
  List<double> historicoMassas =
      []; // Lista para armazenar os últimos 10 valores de massa
  bool dentroDaFaixaDeErro =
      true; // Variável booleana para verificar se o massa está dentro da faixa de erro
  double erro = 0.02; // Erro permitido (em kg)
  int quantidadeUltimosmassas = 5; // Considera os últimos 5 massas

  @override
  void initState() {
    super.initState();
    fetchData(); // Chama a função ao abrir a tela
    timer = Timer.periodic(
        const Duration(milliseconds: 100), (Timer t) => fetchData());
    tararBalanca();
  }

  // Função para buscar dados da balança
  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:5000/data'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      setState(() {
        data = jsonResponse['data'];
        RegExp regExp =
            RegExp(r'(-?\d+(\.\d+)?)'); // Regex para encontrar números decimais
        Match? match = regExp.firstMatch(data);

        if (match != null) {
          String massaString = match.group(0)!;
          massa = double.parse(massaString); // Converte para double (em kg)
        }
        if (massa < 0) {
          massa = 0;
        }

        // Adiciona a nova massa à lista e garante que a lista tenha no máximo 30 valores
        historicoMassas.add(massa);
        if (historicoMassas.length > 30) {
          historicoMassas.removeAt(
              0); // Remove o valor mais antigo se a lista exceder 30 elementos
        }

        // Atualiza a moda diretamente dentro da função fetchData
        massaFinal = moda(historicoMassas); // Atualiza o massaFinal com a moda
        if (massaFinal < 0) {
          massaFinal = 0;
        }

        // Calcula a média das últimas 5 massas (ou menos se a lista for menor)
        List<double> ultimosmassas =
            historicoMassas.length > quantidadeUltimosmassas
                ? historicoMassas
                    .sublist(historicoMassas.length - quantidadeUltimosmassas)
                : historicoMassas;

        double media =
            ultimosmassas.reduce((a, b) => a + b) / ultimosmassas.length;

        // Verifica se a massaFinal está dentro da faixa de erro
        if (massaFinal > media + erro || massaFinal < media - erro) {
          dentroDaFaixaDeErro = false; // massa fora da faixa de erro
        } else {
          dentroDaFaixaDeErro = true; // massa dentro da faixa de erro
        }
      });
    } else {}
  }

  // Função para calcular a moda
  double moda(List<double> lista) {
    if (lista.isEmpty) return 0.0; // Caso a lista esteja vazia

    Map<double, int> contagem =
        {}; // Mapa para contar as ocorrências dos valores
    for (double valor in lista) {
      contagem[valor] = (contagem[valor] ?? 0) + 1; // Conta as ocorrências
    }

    double moda = lista[0];
    int maxOcorrencias = contagem[moda] ?? 0;

    contagem.forEach((valor, ocorrencias) {
      if (ocorrencias > maxOcorrencias) {
        moda = valor;
        maxOcorrencias = ocorrencias;
      }
    });

    return moda; // Retorna o valor que mais se repete
  }

  //Enviar dados à balança
  Future<void> tararBalanca() async {
    // URL do servidor Flask
    final url = Uri.parse('http://127.0.0.1:5000/send_data');

    // Dados a serem enviados
    final data = {
      'data': 't',
    };

    // Envia a solicitação POST
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data), // Codifica os dados em formato JSON
    );

    // Verifica a resposta do servidor
    if (response.statusCode == 200) {
      print('Dados enviados com sucesso!');
      print(response.body); // Exibe a resposta do servidor
    } else {
      print('Falha ao enviar dados. Status: ${response.statusCode}');
    }
  }

  @override
  void dispose() {
    timer?.cancel(); // Cancela o Timer ao descartar o widget
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 2200;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Align(
      alignment: Alignment.topCenter,
      child: Row(
        children: [
          Container(
            color: Colors.white,
            width: 0.65 * MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                      onPressed: () {
                        if (context.mounted) {
                          acessouAdm
                              ? Navigator.of(context)
                                  .pushReplacementNamed('/administrador')
                              : Navigator.of(context)
                                  .pushReplacementNamed('/selecionar');
                        }
                      },
                      iconSize: 50 * fem,
                      icon: Icon(Icons.arrow_back)),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    width: 100 * fem,
                    height: 100 * fem,
                    child: Stack(
                      children: [
                        Center(
                          child: Text(
                            "0",
                            style: TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.none,
                                fontSize: 25 * fem),
                          ),
                        ),
                        Center(
                          child: IconButton(
                              onPressed: () {
                                if (context.mounted) {
                                  historicoMassas.clear();
                                  tararBalanca();
                                }
                              },
                              iconSize: 60 * fem,
                              icon: Icon(
                                Icons.refresh,
                                color: Colors.black,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Produto Selecionado",
                        style: TextStyle(
                            color: const Color.fromARGB(255, 193, 194, 199),
                            decoration: TextDecoration.none,
                            fontSize: 30 * fem),
                      ),
                      SizedBox(height: 20),
                      Text(
                        nomeDoProduto,
                        style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.none,
                            fontSize: 30 * fem),
                      ),
                      SizedBox(height: 100),
                      Text(
                        "massa",
                        style: TextStyle(
                            color: const Color.fromARGB(255, 193, 194, 199),
                            decoration: TextDecoration.none,
                            fontSize: 30 * fem),
                      ),
                      SizedBox(height: 20),
                      Text(
                        massa < 1
                            ? (dentroDaFaixaDeErro
                                ? '${(massaFinal * 1000).toStringAsFixed(0)} g'
                                : '${(massa * 1000).toStringAsFixed(0)} g')
                            : (dentroDaFaixaDeErro
                                ? '${massaFinal.toStringAsFixed(3)} kg'
                                : '${massa.toStringAsFixed(3)} kg'),
                        style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.none,
                            fontSize: 40 * fem),
                      ), // Mostra o massa em kg com três casas decimais
                      SizedBox(height: 100),
                      Text(
                        "Valor Final",
                        style: TextStyle(
                            color: const Color.fromARGB(255, 193, 194, 199),
                            decoration: TextDecoration.none,
                            fontSize: 30 * fem),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "R\$ ${precoDoProduto.toStringAsFixed(2)} x $massaFinal Kg = R\$ ${(precoDoProduto * massaFinal).toStringAsFixed(2)}",
                        style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.none,
                            fontSize: 40 * fem),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 0.35 * MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 193, 194, 199),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16 * fem),
                bottomRight: Radius.circular(16 * fem),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x3f000000),
                  offset: Offset(5 * fem, 4 * fem),
                  blurRadius: 5 * fem,
                ),
              ],
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 80 * fem),
                child: SizedBox(
                  width: 500 * fem,
                  height: 200 * fem,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 200 * fem,
                        height: 200 * fem,
                        child: Image.asset('assets/imagens/logo.png'),
                      ),
                      SizedBox(
                        width: 300 * fem,
                        height: 400 * fem,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 24 * ffem,
                                  fontWeight: FontWeight.w500,
                                  height: 1.5 * ffem / fem,
                                  color: const Color(0xff000000),
                                ),
                                children: [
                                  TextSpan(
                                    text: 'EasyWeight\n',
                                    style: TextStyle(
                                      fontSize: 30 * ffem,
                                      fontWeight: FontWeight.w600,
                                      height: 1.5 * ffem / fem,
                                      color: const Color(0xff000000),
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Strain Gauge Application',
                                    style: TextStyle(
                                      fontSize: 20 * ffem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.5 * ffem / fem,
                                      color: const Color(0xff000000),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
