import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool serverExists = false;
  TextEditingController _urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scrollbar(
            child: SingleChildScrollView(
          child: Form(
              child: Center(
                  child: Container(
            constraints: BoxConstraints(maxWidth: 1000),
            child: Column(
              children: [
                TextField(
                    controller: _urlController,
                    readOnly: serverExists,
                    keyboardType: TextInputType.url,
                    decoration: InputDecoration(
                        labelText: "URL",
                        hintText: "https://example.com",
                        suffixIcon: serverExists
                            ? IconButton(
                                icon: Icon(Icons.close_outlined),
                                onPressed: () {
                                  setState(() {
                                    serverExists = false;
                                    _urlController.text = "";
                                  });
                                })
                            : null,
                        prefixIcon: Icon(Icons.link_outlined))),
                if (serverExists) ...[
                  SizedBox(height: 50),
                  TextFormField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: "Name",
                        prefixIcon: Icon(Icons.account_circle_outlined),
                      )),
                  TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        hintText: "email@example.com",
                        prefixIcon: Icon(Icons.email_outlined),
                      )),
                  TextFormField(
                      decoration: InputDecoration(
                          labelText: "Password", prefixIcon: Icon(Icons.lock_outlined))),
                  TextFormField(
                      decoration: InputDecoration(
                          labelText: "Repeat password", prefixIcon: Icon(Icons.lock_outlined)))
                ]
              ],
            ),
          ))),
        )),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.check_outlined),
            onPressed: () {
              setState(() => serverExists = !serverExists);
            }));
  }
}
