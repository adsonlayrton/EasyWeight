// ignore_for_file: camel_case_types, prefer_const_constructors, file_names
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final List<Map<String, dynamic>> listaDeProdutos = [];
String nomeDoProduto = "";
double precoDoProduto = 0.0;
bool acessouAdm = false;

class administrador extends StatefulWidget {
  const administrador({super.key});
  @override
  State<administrador> createState() => administradorState();
}

class administradorState extends State<administrador> {
  String data = 'No data yet';
  double massa = 0.0;
  TextEditingController controllerNomeProduto = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    acessouAdm = true;
  }

  List<Map<String, dynamic>> filtrarProdutos() {
    return listaDeProdutos
        .where((produto) => produto['descricao']
            .toLowerCase()
            .contains(controllerNomeProduto.text.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 1900;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Material(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Container(
          color: Colors.white,
          alignment: Alignment.center,
          width: 1484 * fem,
          height: 957 * fem,
          child: Scrollbar(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                children: [
                  SizedBox(
                    width: 0.65 * MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Botão voltar e home
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              50 * fem, 50 * fem, 50 * fem, 0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: SizedBox(
                              width: 20 * fem,
                              height: 23.14 * fem,
                              child: TextButton(
                                onPressed: () {
                                  if (context.mounted) {
                                    acessouAdm = false;
                                    Navigator.of(context)
                                        .pushReplacementNamed('/inicio');
                                  }
                                },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                ),
                                child: Icon(
                                  Icons.home,
                                  size: 30 * fem,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Texto "Consultar Produto"
                        Text(
                          'Consultar Produto',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24 * ffem,
                            fontWeight: FontWeight.bold,
                            height: 1.5 * ffem / fem,
                            color: Colors.black,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        // Formulário
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              100 * fem, 130 * fem, 0 * fem, 0),
                          child: Container(
                            width: 600 * fem,
                            height: 150 * fem,
                            margin: EdgeInsets.zero,
                            child: Row(
                              children: [
                                Form(
                                  key: _formkey,
                                  child: SizedBox(
                                    width: 500 * fem,
                                    height: 70 * fem,
                                    child: TextFormField(
                                      controller: controllerNomeProduto,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      style: TextStyle(
                                        fontSize: 14 * ffem,
                                        fontWeight: FontWeight.w600,
                                        height: 1.5 * ffem / fem,
                                        color: const Color(0xff6b6a66),
                                        decoration: TextDecoration.none,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Produto',
                                        filled: true,
                                        fillColor: const Color.fromARGB(
                                            255, 224, 224, 224),
                                        border: const OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.zero),
                                        errorStyle: TextStyle(
                                          fontSize: 12 * ffem,
                                          fontWeight: FontWeight.w600,
                                          height: 1.5 * ffem / fem,
                                          color: Colors.red,
                                          decoration: TextDecoration.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.search),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Botões
                        Column(
                          children: [
                            //Calcular preço
                            Padding(
                              padding: EdgeInsets.only(bottom: 20 * fem),
                              child: SizedBox(
                                width: 352.02 * fem,
                                height: 54.97 * fem,
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: TextButton(
                                    onPressed: () {
                                      if (_formkey.currentState!.validate()) {
                                        if (context.mounted) {
                                          Navigator.of(context)
                                              .pushReplacementNamed(
                                                  '/calcular');
                                        }
                                      }
                                    },
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                    ),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          width: 352.02 * fem,
                                          height: 54.97 * fem,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30 * fem),
                                            color: const Color.fromARGB(
                                                255, 193, 194, 199),
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color(0x3f000000),
                                                offset:
                                                    Offset(3 * fem, 4 * fem),
                                                blurRadius: 2.5 * fem,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          'Calcular preço',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14 * ffem,
                                            fontWeight: FontWeight.bold,
                                            height: 1.5 * ffem / fem,
                                            color: Colors.black,
                                            decoration: TextDecoration.none,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            //Cadastrar produto
                            Padding(
                              padding: EdgeInsets.only(bottom: 20 * fem),
                              child: SizedBox(
                                width: 352.02 * fem,
                                height: 54.97 * fem,
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: TextButton(
                                    onPressed: () {
                                      if (_formkey.currentState!.validate()) {
                                        if (context.mounted) {
                                          Navigator.of(context)
                                              .pushReplacementNamed(
                                                  '/cadastrar');
                                        }
                                      }
                                    },
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                    ),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          width: 352.02 * fem,
                                          height: 54.97 * fem,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30 * fem),
                                            color: const Color.fromARGB(
                                                255, 193, 194, 199),
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color(0x3f000000),
                                                offset:
                                                    Offset(3 * fem, 4 * fem),
                                                blurRadius: 2.5 * fem,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          'Cadastrar novo produto',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14 * ffem,
                                            fontWeight: FontWeight.bold,
                                            height: 1.5 * ffem / fem,
                                            color: Colors.black,
                                            decoration: TextDecoration.none,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            //Editar Produto
                            Padding(
                              padding: EdgeInsets.only(bottom: 20 * fem),
                              child: SizedBox(
                                width: 352.02 * fem,
                                height: 54.97 * fem,
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: TextButton(
                                    onPressed: () {
                                      if (_formkey.currentState!.validate()) {
                                        if (context.mounted) {
                                          Navigator.of(context)
                                              .pushReplacementNamed('/editar');
                                        }
                                      }
                                    },
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                    ),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          width: 352.02 * fem,
                                          height: 54.97 * fem,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30 * fem),
                                            color: const Color.fromARGB(
                                                255, 193, 194, 199),
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color(0x3f000000),
                                                offset:
                                                    Offset(3 * fem, 4 * fem),
                                                blurRadius: 2.5 * fem,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          'Editar produto',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14 * ffem,
                                            fontWeight: FontWeight.bold,
                                            height: 1.5 * ffem / fem,
                                            color: Colors.black,
                                            decoration: TextDecoration.none,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            //Excluir Produto
                            Padding(
                              padding: EdgeInsets.only(bottom: 150 * fem),
                              child: SizedBox(
                                width: 352.02 * fem,
                                height: 54.97 * fem,
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        listaDeProdutos.removeWhere((produto) =>
                                            produto['descricao'] ==
                                                nomeDoProduto &&
                                            produto['preco'] == precoDoProduto);
                                        nomeDoProduto = "";
                                        precoDoProduto = 0.0;
                                      });
                                    },
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                    ),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          width: 352.02 * fem,
                                          height: 54.97 * fem,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30 * fem),
                                            color: const Color.fromARGB(
                                                255, 193, 194, 199),
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color(0x3f000000),
                                                offset:
                                                    Offset(3 * fem, 4 * fem),
                                                blurRadius: 2.5 * fem,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          'Excluir produto',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14 * ffem,
                                            fontWeight: FontWeight.bold,
                                            height: 1.5 * ffem / fem,
                                            color: Colors.black,
                                            decoration: TextDecoration.none,
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
                    child: Column(
                      children: [
                        // Logo
                        Align(
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
                                    child:
                                        Image.asset('assets/imagens/logo.png'),
                                  ),
                                  SizedBox(
                                    width: 300 * fem,
                                    height: 400 * fem,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                                  color:
                                                      const Color(0xff000000),
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    'Strain Gauge Application',
                                                style: TextStyle(
                                                  fontSize: 20 * ffem,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.5 * ffem / fem,
                                                  color:
                                                      const Color(0xff000000),
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
                        //Texto "Lista de Produtos:"
                        Padding(
                          padding: EdgeInsets.only(top: 90 * fem),
                          child: SizedBox(
                            width: 500 * fem,
                            height: 40 * fem,
                            child: Text(
                              "Lista de Produtos:",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 20 * ffem,
                                fontWeight: FontWeight.normal,
                                height: 1.5 * ffem / fem,
                                color: Colors.black,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                        ),
                        //Lista de produtos
                        Container(
                          color: Colors.white,
                          width: 500 * fem,
                          height: 460 * fem,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: filtrarProdutos().map((item) {
                                return Column(
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      height: 40 * fem,
                                      child: Stack(
                                        children: [
                                          TextButton(
                                            onPressed: () async {
                                              setState(() {});
                                              nomeDoProduto = item['descricao'];
                                              precoDoProduto = item['preco'];
                                            },
                                            style: TextButton.styleFrom(
                                              overlayColor: Colors.transparent,
                                            ),
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        0 * fem),
                                                color: Colors.transparent,
                                              ),
                                              child: Text(
                                                item['descricao'],
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: 20 * ffem,
                                                  fontWeight: FontWeight.normal,
                                                  height: 1.5 * ffem / fem,
                                                  color: Colors.black,
                                                  decoration:
                                                      TextDecoration.none,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    //SizedBox(height: 10 * fem),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        //Produto e preço selecionados
                        Padding(
                          padding: EdgeInsets.only(top: 20 * fem),
                          child: nomeDoProduto != ""
                              ? Text(
                                  "Produto Selecionado: $nomeDoProduto\nPreço do Produto: R\$ ${precoDoProduto.toStringAsFixed(2)}")
                              : null,
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
    );
  }
}
