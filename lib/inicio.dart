// ignore_for_file: camel_case_types, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class inicio extends StatefulWidget {
  const inicio({super.key});
  @override
  State<inicio> createState() => inicioState();
}

class inicioState extends State<inicio> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 2200;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        color: const Color.fromARGB(255, 193, 194, 199),
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 600 * fem,
                    height: 600 * fem,
                    child: Image.asset('assets/imagens/logo.png'),
                  ),
                  SizedBox(
                    width: 50 * fem,
                  ),
                  Text(
                    "EasyWeight",
                    style: TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                        fontSize: 100 * fem),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(50 * fem, 0, 0, 50 * fem),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: SizedBox(
                  width: 500 * fem,
                  height: 100 * fem,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          if (context.mounted) {
                            Navigator.of(context)
                                .pushReplacementNamed('/selecionar');
                          }
                        },
                        iconSize: 50 * fem,
                        icon: Icon(Icons.arrow_back),
                      ),
                      Text(
                        "Selecionar Produto",
                        style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                            fontSize: 30 * fem),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 50 * fem, 50 * fem),
              child: Align(
                alignment: Alignment.bottomRight,
                child: SizedBox(
                  width: 500 * fem,
                  height: 100 * fem,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                            fontSize: 30 * fem),
                      ),
                      IconButton(
                        onPressed: () {
                          if (context.mounted) {
                            Navigator.of(context)
                                .pushReplacementNamed('/login');
                          }
                        },
                        iconSize: 50 * fem,
                        icon: Icon(Icons.arrow_forward),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
