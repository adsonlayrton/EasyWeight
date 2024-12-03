// ignore_for_file: camel_case_types, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class login extends StatefulWidget {
  const login({super.key});
  @override
  State<login> createState() => loginState();
}

class loginState extends State<login> {
  final _formkey = GlobalKey<FormState>();
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
          color: const Color.fromARGB(126, 255, 255, 255),
          alignment: Alignment.center,
          width: 1484 * fem,
          height: 957 * fem,
          child: Scrollbar(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                width: 1300 * fem,
                height: 809 * fem,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(16 * fem),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x3f000000),
                      offset: Offset(5 * fem, 4 * fem),
                      blurRadius: 5 * fem,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 686 * fem,
                      height: 809 * fem,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Botão voltar
                          Padding(
                            padding:
                                EdgeInsets.fromLTRB(50 * fem, 50 * fem, 0, 0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: SizedBox(
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
                                    Icons.arrow_back,
                                    size: 30 * fem,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Texto "Acesse sua conta"
                          Container(
                            child: Text(
                              'Acesse a conta de administrador',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24 * ffem,
                                fontWeight: FontWeight.bold,
                                height: 1.5 * ffem / fem,
                                color: Colors.black,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                          // Texto "Preencha seus dados"
                          Padding(
                            padding: EdgeInsets.only(bottom: 10 * fem),
                            child: Text(
                              'Preencha seus dados',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14 * ffem,
                                fontWeight: FontWeight.w600,
                                height: 1.5 * ffem / fem,
                                color: const Color(0xff6b6a66),
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                          // Formulário
                          Padding(
                            padding: EdgeInsets.only(bottom: 10 * fem),
                            child: Container(
                              width: 550 * fem,
                              height: 150 * fem,
                              margin: EdgeInsets.zero,
                              child: Form(
                                key: _formkey,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 550 * fem,
                                      height: 70 * fem,
                                      child: TextFormField(
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
                                          hintText: 'Usuário',
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
                                          icon: const Icon(Icons.person),
                                        ),
                                        validator: (String? value) {
                                          if (value == null || value.isEmpty) {
                                            return "Informe o usuário";
                                          }
                                          if (value != "admin") {
                                            return "Usuário incorreto";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10 * fem,
                                    ),
                                    SizedBox(
                                      width: 550 * fem,
                                      height: 70 * fem,
                                      child: TextFormField(
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        obscureText: true,
                                        style: TextStyle(
                                          fontSize: 14 * ffem,
                                          fontWeight: FontWeight.w600,
                                          height: 1.5 * ffem / fem,
                                          color: const Color(0xff6b6a66),
                                          decoration: TextDecoration.none,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: 'Senha',
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
                                          icon: const Icon(Icons.password),
                                        ),
                                        validator: (String? value) {
                                          if (value == null || value.isEmpty) {
                                            return "Informe a senha";
                                          }
                                          if (value != "admin") {
                                            return "Senha incorreta";
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
                          // Botão "Entrar"
                          Padding(
                            padding: EdgeInsets.only(bottom: 180 * fem),
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
                                                '/administrador');
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
                                              offset: Offset(3 * fem, 4 * fem),
                                              blurRadius: 2.5 * fem,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 46 * fem,
                                        height: 21 * fem,
                                        child: Text(
                                          'Entrar',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14 * ffem,
                                            fontWeight: FontWeight.bold,
                                            height: 1.5 * ffem / fem,
                                            color: Colors.black,
                                            decoration: TextDecoration.none,
                                          ),
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
                      width: 614 * fem,
                      height: 809 * fem,
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
                          padding: EdgeInsets.only(top: 100 * fem),
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
                                  height: 200 * fem,
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
      ),
    );
  }
}
