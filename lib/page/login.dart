import 'package:bst/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool _passwordVisible = false;

  // To login, but the response is still false, probably there are errors in the API.
  Future<String> login() async {
    Map<String, dynamic> body = {
      "apikey": "bstapp2022",
      "action": "login",
      "Email": email.text,
      "Password": pass.text,
    };
    final data = base64.encode(utf8.encode(jsonEncode(body)));
    final response =
        await http.post(Uri.parse('https://www.zeroone.co.id/bst/home.php'),
            body: (<String, String>{
              'data': data.toString(),
            }));
    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      if (map['response'] == "true") {
        idUser = map['id_user'];
        name = map['Fullname'];
        Navigator.pushNamed(context, '/pagerouteview');
        return "Success";
      } else {
        return "Failed";
      }
    } else {
      throw Exception(
          "Unable to reload data. Please check your internet connection.");
    }
  }

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
                  padding: const EdgeInsets.fromLTRB(50.0, 24.0, 50.0, 16.0),
                  height: MediaQuery.of(context).size.height * 3.7 / 7,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Balanzing Your Life with",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 25),
                        Container(
                          child:
                              Image.asset('assets/images/logo.png', width: 250),
                        ),
                        SizedBox(height: 25),
                        const Text(
                          "Punya sahabat yang nemenin kamu sampai dapat berat badan ideal, untuk mencapai hasil diet optimal!",
                          style: TextStyle(
                              color: Colors.white, fontSize: 12, height: 1.5),
                        ),
                        SizedBox(height: 25),
                        const Text(
                          "#KawalSampaiIdeal",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  height: (MediaQuery.of(context).size.height * 3.3 / 7),
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(50),
                      topLeft: Radius.circular(50),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        spreadRadius: 5,
                        blurRadius: 12,
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: email,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            bool emailValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(email.text);
                            if (value!.isEmpty) {
                              return "Alamat email wajib diisi.";
                            } else if (emailValid == false) {
                              return "Format penulisan alamat email tidak sesuai.\nContoh: abc@gmail.com";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            labelText: 'Username',
                            labelStyle: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            prefixIcon: SvgPicture.asset(
                                'assets/icons/profile.svg',
                                color: Colors.grey,
                                fit: BoxFit.scaleDown),
                          ),
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          controller: pass,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password wajib diisi.";
                            }
                            return null;
                          },
                          obscureText: !_passwordVisible,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              labelText: 'Password',
                              labelStyle: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              prefixIcon: SvgPicture.asset(
                                  'assets/icons/lock.svg',
                                  color: Colors.grey,
                                  fit: BoxFit.scaleDown),
                              suffixIcon: IconButton(
                                icon: Icon(
                                    _passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey),
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                              )),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        SizedBox(
                          height:
                              (MediaQuery.of(context).size.height * 0.4 / 6),
                          width: double.infinity,
                          child: TextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                login();
                              }
                            },
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('MASUK',
                                      style: GoogleFonts.montserrat(
                                        textStyle: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1.2,
                                        ),
                                      )),
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
                        Padding(
                          padding: EdgeInsets.fromLTRB(14, 15, 14, 5),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/forgotpass');
                              },
                              child: Text(
                                'Lupa password ?',
                                style: TextStyle(
                                    fontSize: 10.0, color: Color(0xFF818181)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(14, 15, 14, 5),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/intro');
                              },
                              child: Text(
                                'Belum mendaftar ?',
                                style: TextStyle(
                                    fontSize: 10.0, color: Color(0xFF818181)),
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            '© 2022 - Balanz Shape Transformation',
                            style: TextStyle(
                                fontSize: 10.0, color: Color(0xFF818181)),
                          ),
                        ),
                      ],
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
