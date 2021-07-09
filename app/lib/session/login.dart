import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class LoginPage extends StatefulWidget {
  final String address;

  const LoginPage({Key? key, required this.address}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scrollbar(
            child: SingleChildScrollView(
                child: Form(
                    child: Center(
                        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Container(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Column(children: [
                    TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            filled: true,
                            labelText: "Email",
                            hintText: "email@example.com",
                            prefixIcon: Icon(PhosphorIcons.envelopeLight))),
                    const SizedBox(height: 20),
                    TextFormField(
                        decoration: const InputDecoration(
                            filled: true, labelText: "Password", prefixIcon: Icon(PhosphorIcons.lockLight)))
                  ]))),
        ))))),
        floatingActionButton: FloatingActionButton(child: const Icon(PhosphorIcons.checkLight), onPressed: () {}));
  }
}
