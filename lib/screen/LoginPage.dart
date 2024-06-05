import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/AppBottomNavigation.dart';
import 'ForgotPasswordPage.dart';
import 'SignUpPage.dart';
import 'HomePage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

final _controllerEmail = TextEditingController();
final _controllerPassword = TextEditingController();

class _LoginPage extends State<LoginPage> with SingleTickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isObscured = true;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  void signInWithEmailAndPassword(BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _controllerEmail.text.trim(),
        password: _controllerPassword.text.trim(),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainPage(user: _auth.currentUser)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Incorrect email or password. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final emailTextField = TextField(
      keyboardType: TextInputType.emailAddress,
      controller: _controllerEmail,
      maxLength: 30,
      decoration: InputDecoration(
        fillColor: Colors.white.withOpacity(0.08),
        errorText: _controllerEmail.text.isNotEmpty && !_controllerEmail.text.contains('@') ? "Invalid Email Format" : null,
        filled: true,
        labelText: 'Enter Email',
        prefixIcon: Icon(Icons.email, color: Colors.lightBlue[800]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
    );

    final passwordTextField = TextField(
      keyboardType: TextInputType.text,
      obscureText: _isObscured,
      controller: _controllerPassword,
      maxLength: 20,
      decoration: InputDecoration(
        errorText: _controllerPassword.text.isNotEmpty && _controllerPassword.text.length < 6 ? "Password must be at least 6 characters long" : null,
        filled: true,
        fillColor: Colors.white.withOpacity(0.08),
        labelText: 'Password',
        prefixIcon: Icon(Icons.lock, color: Colors.lightBlue[800]),
        suffixIcon: IconButton(
          icon: Icon(
            _isObscured ? Icons.visibility_off : Icons.visibility,
            color: Colors.lightBlue[800],
          ),
          onPressed: () {
            setState(() {
              _isObscured = !_isObscured;
            });
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
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
                  margin: EdgeInsets.symmetric(horizontal: width * 0.03),
                  child: FadeTransition(
                    opacity: _animation,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 50),

                        Center(
                          child: Text(
                            'Sign-In',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 64,
                              fontWeight: FontWeight.w400,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                        SizedBox(height: 80),
                        Center(
                          child: SizedBox(
                            width: 200,
                            height: 45,
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xffffffff),
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Wel',
                                    style: TextStyle(
                                      color: Colors.lightBlue[800],
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'come',
                                    style: TextStyle(
                                      color: Color(0xff302121),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        emailTextField,
                        SizedBox(height: 10),
                        passwordTextField,
                        SizedBox(height: 40),
                        Container(
                          height: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => SignUpPage()),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff302121),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 13),
                                ),
                                child: Text(
                                  'Sign-Up',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  signInWithEmailAndPassword(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff0b65b8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 13),
                                ),
                                child: Text(
                                  'Sign-In',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
                            );
                          },
                          child: Text(
                            'Forgot your password?',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.lightBlue[800],
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.2 - 130),
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

class _HeaderWavesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.lightBlue[800]!..style = PaintingStyle.fill;

    final path = Path()
      ..lineTo(0, size.height * 0.35)
      ..quadraticBezierTo(size.width * 0.25, size.height * 0.40, size.width * 0.5, size.height * 0.30)
      ..quadraticBezierTo(size.width * 0.75, size.height * 0.20, size.width, size.height * 0.30)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
