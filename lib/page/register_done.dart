import 'package:flutter/material.dart';

class RegisterSuccessPage extends StatefulWidget {
  const RegisterSuccessPage({Key? key}) : super(key: key);

  @override
  State<RegisterSuccessPage> createState() => _RegisterSuccessPageState();
}

class _RegisterSuccessPageState extends State<RegisterSuccessPage> {
  final _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/main_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 36.0),
                  height: MediaQuery.of(context).size.height * 7 / 8,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child:
                              Image.asset('assets/images/logo.png', width: 120),
                        ),
                        SizedBox(height: 30),
                        const Text(
                          "Selamat!",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 50,
                              fontWeight: FontWeight.w900),
                        ),
                        SizedBox(height: 30),
                        const Text(
                          "Kamu telah menjadi bagian dari member Balanz Shape Transformation! ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              height: 1.5,
                              fontWeight: FontWeight.w900),
                        ),
                        SizedBox(height: 30),
                        const Text(
                          "Saatnya memperoleh badan ideal melalui program yang telah kami rancang khusus buatmu.",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 30)),
                        SizedBox(
                          height:
                              (MediaQuery.of(context).size.height * 0.4 / 6),
                          width: double.infinity,
                          child: TextButton(
                            onPressed: () async {
                              final value = await Navigator.pushNamed(
                                  context, '/pagerouteview');
                              setState(() {
                                FocusScope.of(context).unfocus();
                              });
                            },
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
                                  Text('MULAI SEKARANG',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          letterSpacing: 1.2)),
                                ]),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0xff99CB57)),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 1 / 8,
                  alignment: Alignment.center,
                  child: const Text(
                    '© 2022 - Balanz Shape Transformation',
                    style: TextStyle(fontSize: 10.0, color: Colors.white),
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
