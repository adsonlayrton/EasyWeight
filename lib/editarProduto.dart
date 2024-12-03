// ignore_for_file: camel_case_types, prefer_const_constructors, file_names
import 'package:easy_weight/administrador.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class editarProduto extends StatefulWidget {
  const editarProduto({super.key});
  @override
  State<editarProduto> createState() => editarProdutoState();
}

class editarProdutoState extends State<editarProduto> {
  String data = 'No data yet';
  double massa = 0.0; // Variável para armazenar o massa como double
  TextEditingController controllerPrecoProduto = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 20 * fem,
                                height: 23.14 * fem,
                                child: TextButton(
                                  onPressed: () {
                                    if (context.mounted) {
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              '/administrador');
                                    }
                                  },
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: Icon(
                                    Icons.arrow_back,
                                    size: 30 * fem,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20 * fem,
                                height: 23.14 * fem,
                                child: TextButton(
                                  onPressed: () {
                                    if (context.mounted) {
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
                            ],
                          ),
                        ),
                        // Texto "Edite um produto"
                        Text(
                          'Edite um produto',
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
                          padding:
                              EdgeInsets.fromLTRB(0, 250 * fem, 50 * fem, 0),
                          child: Container(
                            width: 600 * fem,
                            height: 150 * fem,
                            margin: EdgeInsets.zero,
                            child: Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 550 * fem,
                                    height: 70 * fem,
                                    child: TextFormField(
                                      controller: controllerPrecoProduto,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      obscureText: false,
                                      style: TextStyle(
                                        fontSize: 14 * ffem,
                                        fontWeight: FontWeight.w600,
                                        height: 1.5 * ffem / fem,
                                        color: const Color(0xff6b6a66),
                                        decoration: TextDecoration.none,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Preço do quilograma',
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
                                        icon: const Icon(Icons.attach_money),
                                      ),
                                      validator: (String? value) {
                                        if (value == null || value.isEmpty) {
                                          return "Informe o preço do produto";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Botão Atualizar
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 200 * fem),
                          child: SizedBox(
                            width: 352.02 * fem,
                            height: 54.97 * fem,
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: TextButton(
                                onPressed: () {
                                  // Verifique se o formulário é válido
                                  if (formKey.currentState?.validate() ??
                                      false) {
                                    // Remove o produto selecionado, captura o valor do campo de preço, adiciona novo produto
                                    setState(
                                      () {
                                        listaDeProdutos.removeWhere((produto) =>
                                            produto['descricao'] ==
                                                nomeDoProduto &&
                                            produto['preco'] == precoDoProduto);
                                        precoDoProduto = double.tryParse(
                                                controllerPrecoProduto.text) ??
                                            0.0;
                                        listaDeProdutos.add(
                                          {
                                            'descricao': nomeDoProduto,
                                            'preco': precoDoProduto,
                                          },
                                        );
                                        listaDeProdutos.sort((a, b) {
                                          return a['descricao']
                                              .compareTo(b['descricao']);
                                        });
                                        if (context.mounted) {
                                          Navigator.of(context)
                                              .pushReplacementNamed(
                                                  '/administrador');
                                        }
                                      },
                                    );
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
                                            offset: Offset(3 * fem, 4 * fem),
                                            blurRadius: 2.5 * fem,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      'Atualizar preço',
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
            ),
          ),
        ),
      ),
    );
  }
}
