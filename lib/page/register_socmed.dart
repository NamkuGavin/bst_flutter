import 'package:bst/main.dart';
import 'package:bst/server.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mailto/mailto.dart';

enum Gender { male, female }

class RegisterSocmed extends StatefulWidget {
  const RegisterSocmed({Key? key}) : super(key: key);

  @override
  State<RegisterSocmed> createState() => _RegisterSocmedState();
}

class _RegisterSocmedState extends State<RegisterSocmed> {
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  int _activeCurrentStep = 0;
  String? _goal;
  Gender? _gender = Gender.female;
  bool _passwordVisible1 = false;
  bool _passwordVisible2 = false;
  bool _calendarVisible = false;
  bool confirmTNC = false;
  String? tnc_txt;
  String? type;
  String? id;

  DateTime _selectedDate = DateTime.now();
  String? formattedDate;
  final DateTime _firstDate = DateTime(1900, 1, 1);
  final DateTime _lastDate = DateTime.now();

  // Variable and FocusNode for verification code boxes
  var _code1;
  var _code2;
  var _code3;
  var _code4;
  var _code5;
  FocusNode textFirstFocusNode = FocusNode();
  FocusNode textSecondFocusNode = FocusNode();
  FocusNode textThirdFocusNode = FocusNode();
  FocusNode textFourthFocusNode = FocusNode();
  FocusNode textFifthFocusNode = FocusNode();

  TextEditingController fullName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController confirmPass = TextEditingController();
  TextEditingController birthDate = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController clothSize = TextEditingController();
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  TextEditingController _controller4 = TextEditingController();
  TextEditingController _controller5 = TextEditingController();

  // To validate the stepper, using formKey for the form in each step
  final List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  // To load goal radio buttons
  Future<List> goals() async {
    Map<String, dynamic> body = {
      "apikey": "bstapp2022",
      "action": "list_purpose",
    };
    final data = base64.encode(utf8.encode(jsonEncode(body)));
    final response =
        await http.post(Uri.parse(ServerConfig.newUrl + 'home.php'),
            body: (<String, String>{
              'data': data.toString(),
            }));
    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      List res = map["Data"];
      return res;
    } else {
      throw Exception(
          "Unable to reload data. Please check your internet connection.");
    }
  }

  // To load Terms and Conditions
  Future<String> tnc() async {
    Map<String, dynamic> body = {
      "apikey": "bstapp2022",
      "action": "tnc",
    };
    final data = base64.encode(utf8.encode(jsonEncode(body)));
    final response =
        await http.post(Uri.parse(ServerConfig.oldUrl + 'home.php'),
            body: (<String, String>{
              'data': data.toString(),
            }));
    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      final res = map["data"];
      setState(() {
        tnc_txt = res;
      });
      return "Success";
    } else {
      throw Exception(
          "Unable to reload data. Please check your internet connection.");
    }
  }

  // To register the user data
  Future<String> register() async {
    Map<String, dynamic> body = {
      "apikey": "bstapp2022",
      "action": "register",
      "Fullname": fullName.text,
      "Email": email.text,
      "Password": pass.text,
      "Gender": _gender == Gender.female ? 'F' : 'M',
      "Dob": formattedDate,
      "Height": height.text,
      "Weight": weight.text,
      "RegisterPurpose": _goal,
      "ClothesTarget": clothSize.text,
      "DietType": 1,
      "type": type,
      "id_login": id,
      "parameter": email.text,
    };
    // Map<String, dynamic> body = {
    //   "apikey": "bstapp2022",
    //   "action": "register",
    //   "Fullname": "Hibatullah Fawwaz Hana",
    //   "Email": "hiba.kudus@gmail.com",
    //   "Password": "123456",
    //   "Gender": 'M',
    //   "Dob": "bebas",
    //   "Height": "80",
    //   "Weight": "80",
    //   "RegisterPurpose": "goal",
    //   "ClothesTarget": "80",
    //   "DietType": 1,
    //   "type": "1",
    //   "id_login": "113330553434021010618",
    //   "parameter": "hiba.kudus@gmail.com",
    // };
    print("body : " + body.toString());
    final data = base64.encode(utf8.encode(jsonEncode(body)));
    final response =
        await http.post(Uri.parse(ServerConfig.newUrl + 'home.php'),
            body: (<String, String>{
              'data': data.toString(),
            }));
    print("response register : " + response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      if (map['response'] == "true") {
        idUser = map['id_user'];
        name = map['Fullname'];
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('type', type.toString());
        prefs.setString('id_login', id.toString());
        prefs.setString('parameter', email.text);
        Navigator.pushNamed(context, '/registersuccess');
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
  void initState() {
    _passwordVisible1 = false;
    _passwordVisible2 = false;
    tnc();
  }

  // To do back action for the "Pendaftaran" button
  void setStepOnBack() {
    if (_activeCurrentStep == 0) {
      Navigator.pushNamed(context, '/intro');
    } else {
      setState(() {
        _activeCurrentStep -= 1;
      });
    }
  }

  // To launch mailto in the verification code section
  launchMailto() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: 'support@bstapps.com',
    );

    var url = params.toString();
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch.';
    }
  }

  // The contents of each step
  List<Step> stepList() => [
        Step(
          state: StepState.disabled,
          isActive: _activeCurrentStep >= 0,
          title: Text(''),
          content: Container(
            child: Form(
              key: _formKeys[0],
              child: Column(
                children: [
                  Text("Isilah form berikut dengan benar dan lengkap",
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                          color: Color(0xff4caf50),
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                  SizedBox(height: 20),
                  Text(
                    "Yeay! Kamu berada di langkah tepat! Kami akan menemani perjuanganmu dalam mencapai tubuh ideal! Bantu kami mengenali kamu dengan menjawab beberapa pertanyaan ini:",
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        color: Color(0xff818181),
                        fontSize: 14,
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  TextFormField(
                    controller: fullName,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Nama lengkap wajib diisi.";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      labelText: 'Nama Lengkap',
                      labelStyle: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      prefixIcon: SvgPicture.asset('assets/icons/profile.svg',
                          color: Colors.grey, fit: BoxFit.scaleDown),
                    ),
                  ),
                  SizedBox(height: 15),
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
                      labelText: 'Alamat Email',
                      labelStyle: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      prefixIcon: SvgPicture.asset('assets/icons/email.svg',
                          color: Colors.grey, fit: BoxFit.scaleDown),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: phone,
                    validator: (value) {
                      bool phoneValid = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
                          .hasMatch(phone.text);
                      if (value!.isEmpty) {
                        return "Nomor Hp wajib diisi.";
                      } else if (phoneValid == false) {
                        return "Format penulisan nomor hp tidak sesuai.\nContoh: 081345678543";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      labelText: 'Nomor Hp',
                      labelStyle: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      prefixIcon: SvgPicture.asset('assets/icons/phone.svg',
                          color: Colors.grey, fit: BoxFit.scaleDown),
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
                    obscureText: !_passwordVisible1,
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
                        prefixIcon: SvgPicture.asset('assets/icons/lock.svg',
                            color: Colors.grey, fit: BoxFit.scaleDown),
                        suffixIcon: IconButton(
                          icon: Icon(
                              _passwordVisible1
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey),
                          onPressed: () {
                            setState(() {
                              _passwordVisible1 = !_passwordVisible1;
                            });
                          },
                        )),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: confirmPass,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Pengulangan password wajib diisi.";
                      } else if (value != pass.text) {
                        return "Password tidak sesuai.";
                      }
                      return null;
                    },
                    obscureText: !_passwordVisible2,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        labelText: 'Ulangi Password',
                        labelStyle: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        prefixIcon: SvgPicture.asset('assets/icons/lock.svg',
                            color: Colors.grey, fit: BoxFit.scaleDown),
                        suffixIcon: IconButton(
                          icon: Icon(
                              _passwordVisible2
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey),
                          onPressed: () {
                            setState(() {
                              _passwordVisible2 = !_passwordVisible2;
                            });
                          },
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
        Step(
            state: StepState.disabled,
            isActive: _activeCurrentStep >= 1,
            title: const Text(''),
            content: Container(
              child: Form(
                key: _formKeys[1],
                child: Column(
                  children: [
                    Text("Goal yang ingin kamu capai melalui program BST",
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            color: Color(0xff4caf50),
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                    SizedBox(height: 20),
                    Text(
                      "Pilih salah satu apa yang ingin kamu capai",
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                          color: Color(0xff818181),
                          fontSize: 14,
                        ),
                      ),
                    ),
                    FutureBuilder<List>(
                      future: goals(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                              child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Divider(),
                                  ListTile(
                                    contentPadding: EdgeInsets.all(0.0),
                                    title: Text(
                                      snapshot.data![index]['name'],
                                      style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    leading: Radio<String>(
                                      activeColor: const Color(0xff4caf50),
                                      value: snapshot.data![index]['id'],
                                      groupValue: _goal,
                                      onChanged: (value) {
                                        setState(() {
                                          _goal = value;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          ));
                        } else if (snapshot.hasError) {
                          return Text(
                              "Unable to reload data. Please check your internet connection.");
                        }
                        return CircularProgressIndicator();
                      },
                    ),
                    Divider(),
                  ],
                ),
              ),
            )),
        Step(
            state: StepState.disabled,
            isActive: _activeCurrentStep >= 2,
            title: const Text(''),
            content: Container(
              child: Form(
                key: _formKeys[2],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Untuk hasil diet yang tepat lengkapi biodata berikut",
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            color: Color(0xff4caf50),
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                    SizedBox(height: 20),
                    Text(
                      "Untuk memperoleh perhitungan yang akurat",
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                          color: Color(0xff818181),
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    IntrinsicHeight(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            fit: FlexFit.tight,
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                'Perempuan',
                                style: GoogleFonts.openSans(
                                  textStyle: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              leading: Radio<Gender>(
                                activeColor: const Color(0xff4caf50),
                                value: Gender.female,
                                groupValue: _gender,
                                onChanged: (Gender? value) {
                                  setState(() {
                                    _gender = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          VerticalDivider(),
                          Flexible(
                            fit: FlexFit.tight,
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                'Laki - laki',
                                style: GoogleFonts.openSans(
                                  textStyle: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              leading: Radio<Gender>(
                                activeColor: const Color(0xff4caf50),
                                value: Gender.male,
                                groupValue: _gender,
                                onChanged: (Gender? value) {
                                  setState(() {
                                    _gender = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Card(
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1, color: Color(0xc8818181)),
                          borderRadius: BorderRadius.circular(20.0)),
                      elevation: 0,
                      child: Column(
                        children: [
                          TextFormField(
                            autocorrect: false,
                            autofocus: false,
                            readOnly: true,
                            controller: birthDate,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Tanggal lahir wajib diisi.";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              labelText: 'Tanggal lahir',
                              labelStyle: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 36.0),
                              suffixIcon: IconButton(
                                icon: SvgPicture.asset(
                                    'assets/icons/calendar.svg',
                                    color: Colors.grey,
                                    fit: BoxFit.scaleDown),
                                onPressed: () {
                                  setState(() {
                                    _calendarVisible = !_calendarVisible;
                                  });
                                },
                              ),
                            ),
                          ),
                          if (_calendarVisible)
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: CalendarDatePicker(
                                firstDate: _firstDate,
                                lastDate: _lastDate,
                                initialDate: _selectedDate,
                                onDateChanged: (date) {
                                  setState(() {
                                    _selectedDate = date;
                                    formattedDate = DateFormat('yyyy-MM-dd')
                                        .format(_selectedDate);
                                    birthDate.text = DateFormat('yMMMMd')
                                        .format(_selectedDate);
                                  });
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      toolbarOptions: ToolbarOptions(),
                      controller: height,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Tinggi badan wajib diisi.";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        labelText: 'Tinggi badan (cm)',
                        labelStyle: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 36.0),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      toolbarOptions: ToolbarOptions(),
                      controller: weight,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Berat badan wajib diisi.";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        labelText: 'Berat badan (kg)',
                        labelStyle: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 36.0),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      toolbarOptions: ToolbarOptions(),
                      controller: clothSize,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Target ukuran baju wajib diisi.";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        labelText: 'Target ukuran baju',
                        labelStyle: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 36.0),
                      ),
                    ),
                  ],
                ),
              ),
            )),
        Step(
            state: StepState.disabled,
            isActive: _activeCurrentStep >= 3,
            title: const Text(''),
            content: Container(
              child: Form(
                key: _formKeys[3],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Masukkan kode verifikasi",
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            color: Color(0xff4caf50),
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                    SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                            color: Color(0xff818181),
                            fontSize: 14,
                          ),
                        ),
                        children: const <TextSpan>[
                          TextSpan(
                              text:
                                  "Kami telah mengirimkan email berisi 5 karakter kode verifikasi via "),
                          TextSpan(
                              text: "WA 08*** *** *07",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: ", salin dan masukkan ke kolom berikut."),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 70,
                            child: AspectRatio(
                              aspectRatio:
                                  MediaQuery.of(context).size.width / 450,
                              child: TextFormField(
                                focusNode: textFirstFocusNode,
                                controller: _controller1,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                autofocus: true,
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    FocusScope.of(context)
                                        .requestFocus(textSecondFocusNode);
                                  }
                                  if (value.isEmpty) {
                                    FocusScope.of(context).unfocus();
                                  }
                                  _code1 = value;
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "";
                                  }
                                  return null;
                                },
                                showCursor: false,
                                readOnly: false,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff818181),
                                  fontSize: 24,
                                ),
                                keyboardType: TextInputType.number,
                                maxLength: 1,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 16.0, horizontal: 0.0),
                                  counter: Offstage(),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Color(0xff99CB57)),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.yellow),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  errorStyle: TextStyle(height: 0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 70,
                            child: AspectRatio(
                              aspectRatio:
                                  MediaQuery.of(context).size.width / 450,
                              child: TextFormField(
                                focusNode: textSecondFocusNode,
                                controller: _controller2,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                autofocus: false,
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    FocusScope.of(context)
                                        .requestFocus(textThirdFocusNode);
                                  }
                                  if (value.isEmpty) {
                                    FocusScope.of(context)
                                        .requestFocus(textFirstFocusNode);
                                  }
                                  _code2 = value;
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "";
                                  }
                                  return null;
                                },
                                showCursor: false,
                                readOnly: false,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff818181),
                                  fontSize: 24,
                                ),
                                keyboardType: TextInputType.number,
                                maxLength: 1,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 16.0, horizontal: 0.0),
                                  counter: Offstage(),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Color(0xff99CB57)),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.yellow),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  errorStyle: TextStyle(height: 0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 70,
                            child: AspectRatio(
                              aspectRatio:
                                  MediaQuery.of(context).size.width / 450,
                              child: TextFormField(
                                focusNode: textThirdFocusNode,
                                controller: _controller3,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                autofocus: false,
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    FocusScope.of(context)
                                        .requestFocus(textFourthFocusNode);
                                  }
                                  if (value.isEmpty) {
                                    FocusScope.of(context)
                                        .requestFocus(textSecondFocusNode);
                                  }
                                  _code3 = value;
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "";
                                  }
                                  return null;
                                },
                                showCursor: false,
                                readOnly: false,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff818181),
                                  fontSize: 24,
                                ),
                                keyboardType: TextInputType.number,
                                maxLength: 1,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 16.0, horizontal: 0.0),
                                  counter: Offstage(),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Color(0xff99CB57)),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.yellow),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  errorStyle: TextStyle(height: 0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 70,
                            child: AspectRatio(
                              aspectRatio:
                                  MediaQuery.of(context).size.width / 450,
                              child: TextFormField(
                                focusNode: textFourthFocusNode,
                                controller: _controller4,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                autofocus: false,
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    FocusScope.of(context)
                                        .requestFocus(textFifthFocusNode);
                                  }
                                  if (value.isEmpty) {
                                    FocusScope.of(context)
                                        .requestFocus(textThirdFocusNode);
                                  }
                                  _code4 = value;
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "";
                                  }
                                  return null;
                                },
                                showCursor: false,
                                readOnly: false,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff818181),
                                  fontSize: 24,
                                ),
                                keyboardType: TextInputType.number,
                                maxLength: 1,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 16.0, horizontal: 0.0),
                                  counter: Offstage(),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Color(0xff99CB57)),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.yellow),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  errorStyle: TextStyle(height: 0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 70,
                            child: AspectRatio(
                              aspectRatio:
                                  MediaQuery.of(context).size.width / 450,
                              child: TextFormField(
                                focusNode: textFifthFocusNode,
                                controller: _controller5,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                autofocus: false,
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    FocusScope.of(context).unfocus();
                                  }
                                  if (value.isEmpty) {
                                    FocusScope.of(context)
                                        .requestFocus(textFourthFocusNode);
                                  }
                                  _code5 = value;
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "";
                                  }
                                  return null;
                                },
                                showCursor: false,
                                readOnly: false,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff818181),
                                  fontSize: 24,
                                ),
                                keyboardType: TextInputType.number,
                                maxLength: 1,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 16.0, horizontal: 0.0),
                                  counter: Offstage(),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Color(0xff99CB57)),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.yellow),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  errorStyle: TextStyle(height: 0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Tidak menerima kode verifikasi?",
                      style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                          color: Color(0xff818181),
                          fontSize: 14,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Klik link dibawah ini setelah 60 detik",
                      style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                          color: Color(0xff818181),
                          fontSize: 14,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "00 : 60",
                      style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                          color: Color(0xff4caf50),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4 / 6,
                      child: OutlinedButton(
                        onPressed: () {
                          // API not exist.
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Padding(padding: EdgeInsets.only(left: 10)),
                              Text('Kirim ulang kode verifikasi',
                                  style: TextStyle(
                                      color: Color(0xff99CB57),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16)),
                            ]),
                        style: ButtonStyle(
                          side: MaterialStateProperty.all(
                            BorderSide(
                              color: Color(0xff4caf50),
                            ),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                    Divider(),
                    SizedBox(height: 10),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                            color: Color(0xff818181),
                            fontSize: 14,
                          ),
                        ),
                        children: <TextSpan>[
                          TextSpan(text: "Hubungi CS kami melalui email "),
                          TextSpan(
                              text: "support@bstapps.com",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launchMailto();
                                },
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff4caf50),
                                  decoration: TextDecoration.underline)),
                          TextSpan(text: " atau "),
                          TextSpan(
                              text: "klik disini",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Still don't know where to link
                                },
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff4caf50),
                                  decoration: TextDecoration.underline)),
                          TextSpan(
                              text:
                                  " untuk chat lewat WA jika kamu kesulitan memperoleh kode verifikasi."),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
        Step(
            state: StepState.disabled,
            isActive: _activeCurrentStep >= 4,
            title: const Text(''),
            content: Container(
              child: Form(
                key: _formKeys[4],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Syarat dan ketentuan menjadi peserta program BST",
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            color: Color(0xff4caf50),
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                    SizedBox(height: 20),
                    Container(
                      height: MediaQuery.of(context).size.height * 1.8 / 5,
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: CupertinoScrollbar(
                          child: ListView(
                            padding: EdgeInsets.only(right: 5),
                            scrollDirection: Axis.vertical,
                            children: [
                              Text(tnc_txt.toString(),
                                  textAlign: TextAlign.justify,
                                  style: GoogleFonts.openSans()),
                            ],
                          ),
                        ),
                      ),
                    ),
                    FormField(
                      builder: (field) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(top: 30.0),
                          child: Row(
                            children: [
                              Transform.scale(
                                scale: 1.4,
                                child: Checkbox(
                                  side: BorderSide(
                                      width: 1,
                                      color: field.hasError
                                          ? Colors.red
                                          : Color(0xc8818181)),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2.5)),
                                  checkColor: Colors.white,
                                  activeColor: const Color(0xff99CB57),
                                  value: confirmTNC,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      confirmTNC = value ?? false;
                                      field.didChange(value);
                                    });
                                  },
                                ),
                              ),
                              Flexible(
                                child: Text(
                                    "Saya menyetujui ketentuan dan persyaratan program BST",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Color(0xff818181))),
                              ),
                            ],
                          ),
                        );
                      },
                      validator: (value) {
                        if (!confirmTNC) {
                          return 'Anda wajib menyetujui ketentuan dan persyaratan.';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ],
                ),
              ),
            ))
      ];

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as Map;

    if (data != null) {
      id = data['id'];
      fullName.text = data["name"];
      email.text = data["email"];
      type = data["type"];
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldkey,
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: TextButton.icon(
                  onPressed: () {
                    setStepOnBack();
                  },
                  icon: Icon(Icons.keyboard_arrow_left,
                      color: Color(0xff99CB57), size: 36),
                  label: Text('Pendaftaran'),
                  style: TextButton.styleFrom(
                    primary: Color(0xff818181),
                    textStyle: GoogleFonts.openSans(
                      textStyle: const TextStyle(
                        color: Color(0xff818181),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(
                  height: MediaQuery.of(context).size.height * 0.9),
              child: Stepper(
                controlsBuilder: (context, details) {
                  return Container(
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.only(top: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height:
                              (MediaQuery.of(context).size.height * 0.4 / 6),
                          width: double.infinity,
                          child: TextButton(
                            onPressed: details.onStepContinue,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('SELANJUTNYA',
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
                        const Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: Text(
                            '© 2022 - Balanz Shape Transformation',
                            style: TextStyle(
                                fontSize: 10.0, color: Color(0xFF818181)),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                elevation: 0.0,
                type: StepperType.horizontal,
                currentStep: _activeCurrentStep,
                steps: stepList(),
                onStepContinue: () {
                  if (_activeCurrentStep < (stepList().length)) {
                    if (_formKeys[_activeCurrentStep]
                        .currentState!
                        .validate()) {
                      if (_activeCurrentStep == 4) {
                        register();
                      } else {
                        setState(() {
                          _activeCurrentStep += 1;
                        });
                      }
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
