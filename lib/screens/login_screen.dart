import 'package:coding_challenge/services/auth_services.dart';
import 'package:coding_challenge/utils/constants.dart';
import 'package:coding_challenge/utils/validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  String errorMessage = '';
  void togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    super.initState();
    if (Provider.of<AuthService>(context, listen: false).currentUser() !=
        null) {
      Navigator.pushReplacementNamed(context, '/');
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    border: OutlineInputBorder(),
                  ),
                  validator: Validators.emailValidator,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: togglePasswordVisibility,
                    ),
                  ),
                  obscureText: true,
                  validator: Validators.passwordValidator,
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kColorBlue,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final localContext = context;
                        Provider.of<AuthService>(localContext, listen: false)
                            .signIn(
                                _emailController.text, _passwordController.text)
                            .then((_) {
                          Navigator.pushReplacementNamed(localContext, '/');
                        }).catchError((e) {
                          if (e is FirebaseAuthException) {
                            setState(() {
                              errorMessage = e.message ?? '';
                            });
                            ScaffoldMessenger.of(localContext).showSnackBar(
                              SnackBar(
                                content: Text(errorMessage),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        });
                      }
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: kColorWhite),
                    ),
                  ),
                ),
                Text(errorMessage, style: const TextStyle(color: Colors.red)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account? Register',
                      style: TextStyle(
                        color: kColorGreyShade400,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          color: kColorBlue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
