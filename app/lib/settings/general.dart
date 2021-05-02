import 'package:flow_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GeneralSettingsPage extends StatefulWidget {
  @override
  _GeneralSettingsPageState createState() => _GeneralSettingsPageState();
}

class _GeneralSettingsPageState extends State<GeneralSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: FlowDrawer(page: RoutePages.general),
        appBar: AppBar(title: Text("General settings")),
        body: SingleChildScrollView(
            child: Column(children: [
          ListTile(
              leading: Icon(Icons.text_snippet_outlined),
              title: Text("License"),
              onTap: () => launch("https://github.com/LinwoodCloud/Flow/blob/main/LICENSE")),
          ListTile(
              leading: Icon(Icons.code_outlined),
              title: Text("Code"),
              onTap: () => launch("https://github.com/LinwoodCloud/Flow")),
          ListTile(
              leading: Icon(Icons.supervisor_account_outlined),
              title: Text("Discord"),
              onTap: () => launch("https://discord.linwood.tk")),
          ListTile(
              leading: Icon(Icons.description_outlined),
              title: Text("Docs"),
              onTap: () => launch("https://docs.flow.linwood.tk")),
          ListTile(
              leading: Icon(Icons.history_outlined),
              title: Text("Changelog"),
              onTap: () => launch("https://docs.flow.linwood.tk/changelog")),
          ListTile(
              leading: Icon(Icons.construction_outlined),
              title: Text("Imprint"),
              onTap: () => launch("https://codedoctor.tk/impress")),
          ListTile(
              leading: Icon(Icons.privacy_tip_outlined),
              title: Text("Privacy policy"),
              onTap: () => launch("https://docs.flow.linwood.tk/privacypolicy")),
          ListTile(
              leading: Icon(Icons.info_outline),
              title: Text("About"),
              onTap: () => showAboutDialog(
                  context: context, applicationIcon: Image.asset("images/icon.png", height: 50))),
        ])));
  }
}
