import 'package:e_commerse_app/views/pages/home.dart';
import 'package:e_commerse_app/views/pages/log_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Regstration(),
    );
  }
}

class Regstration extends StatefulWidget {
  const Regstration({super.key});

  @override
  State<Regstration> createState() => _RegstrationState();
}

class _RegstrationState extends State<Regstration> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController usernameController;

  bool _obsecured = true;

  var _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    usernameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/background.png'), fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: usernameController,
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.person),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.lightBlue),
                          borderRadius: BorderRadius.circular(25)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.lightBlue),
                          borderRadius: BorderRadius.circular(25)),
                      labelText: 'user name',
                      hintText: 'write your username....'),
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.newline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'you must enter username';
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: emailController,
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.email_rounded),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.lightBlue),
                          borderRadius: BorderRadius.circular(25)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.lightBlue),
                          borderRadius: BorderRadius.circular(25)),
                      labelText: 'email',
                      hintText: 'write your name....'),
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.newline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'you must write email';
                    } else if (value.split('@').last != 'gmail.com') {
                      return 'email must end with @gmail.com';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: _obsecured,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: passwordController,
                  decoration: InputDecoration(
                      suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              _obsecured = !_obsecured;
                            });
                          },
                          child: Icon(_obsecured
                              ? Icons.visibility_off
                              : Icons.visibility)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.lightBlue),
                          borderRadius: BorderRadius.circular(25)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.lightBlue),
                          borderRadius: BorderRadius.circular(25)),
                      labelText: 'password',
                      hintText: 'write your password....'),
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.newline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'you must write Password';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 218, 168, 121))),
                    onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (_) => LogIn()));
                      //  }
                    },
                    child: Text(
                      'sign up',
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
