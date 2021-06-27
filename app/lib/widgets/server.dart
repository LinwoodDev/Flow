import 'package:flutter/material.dart';

typedef Widget ServerBuilder(String server);

class ServerView extends StatefulWidget {
  final ServerBuilder builder;

  const ServerView({Key? key, required this.builder}) : super(key: key);

  @override
  _ServerViewState createState() => _ServerViewState();
}

class _ServerViewState extends State<ServerView> {
  final List<String> servers = ["https://example.com", "https://example.de"];
  String? server;

  @override
  void initState() {
    super.initState();

    server = servers.first;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Card(
          child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                  constraints: BoxConstraints(maxWidth: 1000),
                  padding: const EdgeInsets.all(16.0),
                  child: DropdownButtonFormField<String>(
                      value: server,
                      decoration: InputDecoration(labelText: "Server"),
                      onChanged: (value) => setState(() => server = value),
                      items: List.generate(servers.length,
                          (index) => DropdownMenuItem<String>(value: servers[index], child: Text(servers[index]))))))),
      if (server != null)
        Card(
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0), child: widget.builder(server!)))
    ]);
  }
}
