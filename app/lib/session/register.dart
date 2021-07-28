import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class RegisterPage extends StatefulWidget {
  final String address;

  const RegisterPage({Key? key, required this.address}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scrollbar(
            child: SingleChildScrollView(
                child: Form(
                    child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                            constraints: const BoxConstraints(maxWidth: 800),
                            child: Column(children: [
                              TextFormField(
                                  keyboardType: TextInputType.name,
                                  decoration: const InputDecoration(
                                      filled: true,
                                      labelText: "Name",
                                      prefixIcon:
                                          Icon(PhosphorIcons.userLight))),
                              const SizedBox(height: 20),
                              TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
                                      filled: true,
                                      labelText: "Email",
                                      hintText: "email@example.com",
                                      prefixIcon:
                                          Icon(PhosphorIcons.envelopeLight))),
                              const SizedBox(height: 50),
                              TextFormField(
                                  decoration: const InputDecoration(
                                      filled: true,
                                      labelText: "Password",
                                      prefixIcon:
                                          Icon(PhosphorIcons.lockLight))),
                              const SizedBox(height: 20),
                              TextFormField(
                                  decoration: const InputDecoration(
                                      filled: true,
                                      labelText: "Repeat password",
                                      prefixIcon:
                                          Icon(PhosphorIcons.lockLight)))
                            ])))))),
        floatingActionButton: FloatingActionButton(
            child: const Icon(PhosphorIcons.checkLight), onPressed: () {}));
  }
}
