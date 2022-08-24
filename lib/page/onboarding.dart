import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final onboardingPageKey = GlobalKey<IntroductionScreenState>();

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/images/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: onboardingPageKey,
      globalBackgroundColor: Colors.white,
      globalFooter: const Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.only(top: 40, bottom: 30),
          child: Text(
            '© 2022 - Balanz Shape Transformation',
            style: TextStyle(fontSize: 10.0, color: Color(0xFF818181)),
          ),
        ),
      ),
      rawPages: [
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 75),
              _buildImage('logo.png', 100),
              const SizedBox(height: 40),
              _buildImage('onboarding_1.png', 300),
              const SizedBox(height: 40),
              Text("Tentukan Rencana Terbaik Untukmu",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      color: Color(0xFF4CAF50),
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
            ],
          ),
        ),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 75),
              _buildImage('logo.png', 100),
              const SizedBox(height: 40),
              _buildImage('onboarding_2.png', 300),
              const SizedBox(height: 40),
              Text("Sesuaikan dan Pantau Kebutuhanmu",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      color: Color(0xFF4CAF50),
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
            ],
          ),
        ),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 75),
              _buildImage('logo.png', 100),
              const SizedBox(height: 40),
              _buildImage('onboarding_3.png', 300),
              const SizedBox(height: 40),
              Text("Raih Impianmu #KawalSampaiIdeal",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      color: Color(0xFF4CAF50),
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
              const SizedBox(height: 10),
              SizedBox(
                height: (MediaQuery.of(context).size.height * 0.25 / 6),
                width: (MediaQuery.of(context).size.width / 2),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('DAFTAR SEKARANG',
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
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
            ],
          ),
        ),
      ],
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      showNextButton: false,
      showDoneButton: false,
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        spacing: EdgeInsets.symmetric(horizontal: 20.0),
        activeColor: Color(0xFF99CB57),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
