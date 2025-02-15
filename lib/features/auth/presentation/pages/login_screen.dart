import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starzinfinite/core/styles/TextStyle.dart';
import 'package:starzinfinite/core/styles/colors.dart';
import '../controller/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = Provider.of<AuthState>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Image.asset('assets/starz_logo.png'),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 0,
                    blurRadius: 7,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _phoneController,
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Teléfono",
                      hintStyle: medium(kGrey300, 16),
                      focusColor: starzAzul,
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: kGrey300,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: starzAzul,
                          width: 1.5,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: kGrey300,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  TextField(
                    controller: _passwordController,
                    obscuringCharacter: '•',
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      hintText: "Contraseña",
                      hintStyle: medium(kGrey300, 16),
                      focusColor: starzAzul,
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: kGrey300,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: starzAzul,
                          width: 1.5,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: kGrey300,
                          width: 1.5,
                        ),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                        child: GestureDetector(
                          onTap: _toggle,
                          child: Icon(
                            _obscureText
                                ? Icons.visibility_rounded
                                : Icons.visibility_off_rounded,
                            size: 24,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  SizedBox(height: 30),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            child: Text(
                              "Ingresar",
                              style: medium(blanco, 18),
                            ),
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                fixedSize:
                                    Size(MediaQuery.of(context).size.width, 50),
                                backgroundColor: starzAzul,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            onPressed: () async {
                              setState(() {
                                _isLoading = true;
                                _errorMessage = null;
                              });

                              bool success = await authState.login(
                                _phoneController.text.trim(),
                                _passwordController.text.trim(),
                              );

                              if (!mounted) return;

                              setState(() {
                                _isLoading = false;
                                _errorMessage = success
                                    ? null
                                    : "Error en las credenciales";
                              });

                              if (success) {
                                Navigator.pushReplacementNamed(
                                    context, '/home');
                              }
                            },
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
