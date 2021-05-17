import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RegisterPage extends StatefulWidget {
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
                            constraints: BoxConstraints(maxWidth: 1000),
                            child: Column(children: [
                              TextField(
                                  controller: _urlController,
                                  readOnly: true,
                                  keyboardType: TextInputType.url,
                                  decoration: InputDecoration(
                                      labelText: "URL",
                                      hintText: "https://example.com",
                                      prefixIcon: Icon(Icons.link_outlined))),
                              SizedBox(height: 50),
                              TextFormField(
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                      labelText: "Name",
                                      prefixIcon: Icon(Icons.account_circle_outlined))),
                              TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      labelText: "Email",
                                      hintText: "email@example.com",
                                      prefixIcon: Icon(Icons.email_outlined))),
                              TextFormField(
                                  decoration: InputDecoration(
                                      labelText: "Password",
                                      prefixIcon: Icon(Icons.lock_outlined))),
                              TextFormField(
                                  decoration: InputDecoration(
                                      labelText: "Repeat password",
                                      prefixIcon: Icon(Icons.lock_outlined)))
                            ])))))),
        floatingActionButton:
            FloatingActionButton(child: Icon(Icons.check_outlined), onPressed: () {}));
  }
}
