import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class LoginPage extends StatefulWidget {
  final String address;
  final WebSocketChannel channel;

  const LoginPage({Key? key, required this.address, required this.channel})
      : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _urlController;

  @override
  void initState() {
    super.initState();

    _urlController = TextEditingController(text: widget.address);
  }

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
                    const SizedBox(height: 20),
                    TextField(
                        controller: _urlController,
                        readOnly: true,
                        keyboardType: TextInputType.url,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "URL",
                            hintText: "wss://example.com",
                            prefixIcon: Icon(PhosphorIcons.linkLight))),
                    const SizedBox(height: 50),
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
                            filled: true,
                            labelText: "Password",
                            prefixIcon: Icon(PhosphorIcons.lockLight)))
                  ]))),
        ))))),
        floatingActionButton: FloatingActionButton(
            child: const Icon(PhosphorIcons.checkLight), onPressed: () {}));
  }
}
