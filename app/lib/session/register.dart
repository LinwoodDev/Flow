import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late String url;
  late TextEditingController _urlController;

  @override
  void initState() {
    super.initState();

    url = Modular.args?.queryParams['url'] ?? "";
    _urlController = TextEditingController(text: url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scrollbar(
            child: SingleChildScrollView(
                child: Form(
                    child: Center(
                        child: Container(
                            constraints: const BoxConstraints(maxWidth: 1000),
                            child: Column(children: [
                              TextField(
                                  controller: _urlController,
                                  readOnly: true,
                                  keyboardType: TextInputType.url,
                                  decoration: const InputDecoration(
                                      labelText: "URL",
                                      hintText: "https://example.com",
                                      prefixIcon: Icon(PhosphorIcons.linkLight))),
                              const SizedBox(height: 50),
                              TextFormField(
                                  keyboardType: TextInputType.name,
                                  decoration: const InputDecoration(
                                      labelText: "Name",
                                      prefixIcon: Icon(PhosphorIcons.userLight))),
                              TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
                                      labelText: "Email",
                                      hintText: "email@example.com",
                                      prefixIcon: Icon(PhosphorIcons.envelopeLight))),
                              TextFormField(
                                  decoration: const InputDecoration(
                                      labelText: "Password",
                                      prefixIcon: Icon(PhosphorIcons.lockLight))),
                              TextFormField(
                                  decoration: const InputDecoration(
                                      labelText: "Repeat password",
                                      prefixIcon: Icon(PhosphorIcons.lockLight)))
                            ])))))),
        floatingActionButton:
            FloatingActionButton(child: const Icon(PhosphorIcons.checkLight), onPressed: () {}));
  }
}
