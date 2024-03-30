import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import '../screen/ForgotPasswordPage.dart';
import '../screen/HomePage.dart';
import '../screen/SignUpPage.dart';

class AssetTrackerLogin extends StatefulWidget {
  @override
  _AssetTrackerLoginState createState() => _AssetTrackerLoginState();
}

final _controllerEmail = TextEditingController();
final _controllerPassword = TextEditingController();

class _AssetTrackerLoginState extends State<AssetTrackerLogin> {
  bool validateEmail = false;
  bool validatePassword = false;

  controllerClear() {
    _controllerEmail.clear();
    _controllerPassword.clear();
  }

  validateEmailFormat(String email) {
    if (!(email.contains('@')) && email.isNotEmpty) {
      return "Invalid Email Format";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final emailTextField = TextField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      maxLength: 30,
      textInputAction: TextInputAction.next,
      onSubmitted: (_) => FocusScope.of(context).nextFocus(),
      controller: _controllerEmail,
      decoration: InputDecoration(
          fillColor: Colors.white.withOpacity(0.08),
          filled: true,
          labelText: 'Enter Email',
          prefixIcon: Icon(
            Icons.email,
            color: Colors.lightBlue[800],
          ),
          border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(const Radius.circular(20)))),
    );

    final passwordTextField = TextField(
      keyboardType: TextInputType.text,
      obscureText: true,
      autofocus: false,
      maxLength: 20,
      controller: _controllerPassword,
      onSubmitted: (_) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
          filled: true,
          errorText: validateEmailFormat(_controllerEmail.text),
          fillColor: Colors.white.withOpacity(0.08),
          labelText: 'Password',
          prefixIcon: Icon(Icons.lock, color: Colors.lightBlue[800]),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
    );

    double baseWidth = 360.5;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
            width: width,
            height: height,
            child: Stack(
              children: <Widget>[
                SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: CustomPaint(
                    painter: _HeaderWavesPainter(),
                  ),
                ),
                Container(
                  width: width,
                  height: height,
                  margin: EdgeInsets.fromLTRB(width * 0.03, 0, width * 0.03, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Center(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 10 * fem + 70),
                          width: double.infinity,
                          child: Text(
                            'Sign-In',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 64 * ffem,
                              fontWeight: FontWeight.w400,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Align(
                          child: SizedBox(
                            width: 200 * fem,
                            height: 71 * fem,
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 48 * ffem,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xffffffff),
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Wel',
                                    style: TextStyle(
                                      fontSize: 48 * ffem,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.lightBlue[800],
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'come',
                                    style: TextStyle(
                                      fontSize: 48 * ffem,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff302121),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: emailTextField,
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0 * fem, 10, 0 * fem, 50),
                        child: passwordTextField,
                      ),
                      SizedBox(
                        width: width,
                        height: height * 0.25,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(1.5 * fem, 0 * fem, 18 * fem, 0 * fem),
                          width: double.infinity,
                          height: 55 * fem,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15 * fem),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                left: 175 * fem,
                                top: 0 * fem + 10,
                                child: Container(
                                  width: 145 * fem,
                                  height: 55 * fem,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15 * fem),
                                  ),
                                  child: Center(
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 55 * fem,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15 * fem),
                                          color: Color(0xff0b65b8),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0 * fem + 4,
                                top: 0 * fem + 10,
                                child: Container(
                                  width: 303 * fem,
                                  height: 55 * fem,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15 * fem),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0 * fem + 5, 0 * fem, 54 * fem, 0 * fem),
                                        width: 148 * fem,
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Color(0xff302121),
                                          borderRadius: BorderRadius.circular(15 * fem),
                                        ),
                                        child: Center(
                                          child: TextButton(
                                            child: Text(
                                              'Sign-Up',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 20 * ffem,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xffffffff),
                                              ),
                                            ),
                                            onPressed: () {
                                              // Handle sign-in logic
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(builder: (context) => SignUpPage()),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Container(
                                          margin: EdgeInsets.fromLTRB(0 * fem, 1 * fem, 0 * fem, 0 * fem),
                                          child: TextButton(
                                            child: Text(
                                              'Sign-In',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 20 * ffem,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xffffffff),
                                              ),
                                            ),
                                            onPressed: () {
                                              // Handle sign-up navigation
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => HomePage()),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Center(
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                                  width: double.infinity,
                                  child: TextButton(
                                    onPressed: () {
                                      // Handle forgot password navigation
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
                                      );
                                    },
                                    child: Text(
                                      'Forgot your password?',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 15 * ffem,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.lightBlue[800],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      SizedBox(
                        height: height * 0.2 - 160,
                      )
                    ],
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

class _HeaderWavesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    paint.color = Colors.lightBlue[800]!;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 2.0;

    final path = Path();

    path.lineTo(0, size.height * 0.35);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.40, size.width * 0.5, size.height * 0.30);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.20, size.width, size.height * 0.30);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
