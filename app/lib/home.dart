import 'package:flow/widgets/navigation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return FlowNavigation(
        title: "Hi",
        selected: "dashboard",
        body: Align(
          alignment: Alignment.topCenter,
          child: Container(
              constraints: const BoxConstraints(maxWidth: 800),
              child: ListView(children: [
                Card(
                    child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text("Hello",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline4),
                )),
                const SizedBox(height: 20),
                Card(
                    child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Currently happening",
                            style: Theme.of(context).textTheme.headline5),
                        const SizedBox(height: 20),
                        Column(
                          children: [
                            ListTile(
                                title: const Text("entry.name"),
                                subtitle: const Text("entry.description"),
                                onTap: () {})
                          ],
                        )
                      ]),
                ))
              ])),
        ));
  }
}
