import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
            child: Column(
              children: [
                TextField(
                    controller: _urlController,
                    readOnly: true,
                    keyboardType: TextInputType.url,
                    decoration: InputDecoration(
                        labelText: "URL", hintText: "https://example.com", prefixIcon: Icon(PhosphorIcons.linkLight))),
                SizedBox(height: 50),
                TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: "Email",
                        hintText: "email@example.com",
                        prefixIcon: Icon(PhosphorIcons.envelopeLight))),
                TextFormField(
                    decoration: InputDecoration(labelText: "Password", prefixIcon: Icon(PhosphorIcons.lockLight)))
              ],
            ),
          ))),
        )),
        floatingActionButton: FloatingActionButton(child: Icon(PhosphorIcons.checkLight), onPressed: () {}));
  }
}
