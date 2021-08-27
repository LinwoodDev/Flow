import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/models/user.dart';
import 'package:shared/socket_package.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class RegisterPage extends StatefulWidget {
  final String address;
  final WebSocketChannel channel;

  const RegisterPage({Key? key, required this.address, required this.channel})
      : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController _urlController;
  bool _hidePassword = true, _hideRepeatPassword = true;
  final TextEditingController _nameController = TextEditingController(),
      _passwordController = TextEditingController(),
      _repeatPasswordController = TextEditingController(),
      _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

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
                    key: _formKey,
                    child: Align(
                        alignment: Alignment.topCenter,
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
                                      prefixIcon:
                                          Icon(PhosphorIcons.linkLight))),
                              const SizedBox(height: 50),
                              TextFormField(
                                  controller: _nameController,
                                  keyboardType: TextInputType.name,
                                  decoration: const InputDecoration(
                                      filled: true,
                                      labelText: "Name",
                                      prefixIcon:
                                          Icon(PhosphorIcons.userLight))),
                              const SizedBox(height: 20),
                              TextFormField(
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
                                      filled: true,
                                      labelText: "Email",
                                      hintText: "email@example.com",
                                      prefixIcon:
                                          Icon(PhosphorIcons.envelopeLight))),
                              const SizedBox(height: 50),
                              TextFormField(
                                  controller: _passwordController,
                                  obscureText: _hidePassword,
                                  decoration: InputDecoration(
                                      filled: true,
                                      suffixIcon: IconButton(
                                        icon: Icon(_hidePassword
                                            ? PhosphorIcons.eyeLight
                                            : PhosphorIcons.eyeSlashLight),
                                        onPressed: () => setState(() =>
                                            _hidePassword = !_hidePassword),
                                      ),
                                      labelText: "Password",
                                      prefixIcon:
                                          const Icon(PhosphorIcons.lockLight))),
                              const SizedBox(height: 20),
                              TextFormField(
                                  controller: _repeatPasswordController,
                                  obscureText: _hideRepeatPassword,
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return "Password can't be empty";
                                    }
                                    if (_passwordController.text == value) {
                                      return "Password are not the same";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      filled: true,
                                      labelText: "Repeat password",
                                      suffixIcon: IconButton(
                                        icon: Icon(_hideRepeatPassword
                                            ? PhosphorIcons.eyeLight
                                            : PhosphorIcons.eyeSlashLight),
                                        onPressed: () => setState(() =>
                                            _hideRepeatPassword =
                                                !_hideRepeatPassword),
                                      ),
                                      prefixIcon:
                                          const Icon(PhosphorIcons.lockLight)))
                            ])))))),
        floatingActionButton: FloatingActionButton(
            child: const Icon(PhosphorIcons.checkLight),
            onPressed: () {
              if (!(_formKey.currentState?.validate() ?? false)) return;
              SocketPackage(
                      value: User(_nameController.text,
                          email: _emailController.text,
                          password: _passwordController.text),
                      route: 'auth:register')
                  .send(widget.channel);
            }));
  }
}
