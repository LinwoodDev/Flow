import 'package:flow_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class GeneralSettingsPage extends StatefulWidget {
  @override
  _GeneralSettingsPageState createState() => _GeneralSettingsPageState();
}

class _GeneralSettingsPageState extends State<GeneralSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return FlowScaffold(
        page: RoutePages.general,
        pageTitle: "General settings",
        body: SingleChildScrollView(
            child: Column(children: [
          ListTile(
              leading: Icon(PhosphorIcons.stackLight),
              title: Text("License"),
              onTap: () => launch("https://github.com/LinwoodCloud/Flow/blob/main/LICENSE")),
          ListTile(
              leading: Icon(PhosphorIcons.codeLight),
              title: Text("Code"),
              onTap: () => launch("https://github.com/LinwoodCloud/Flow")),
          ListTile(
              leading: Icon(PhosphorIcons.usersLight),
              title: Text("Discord"),
              onTap: () => launch("https://discord.linwood.tk")),
          ListTile(
              leading: Icon(PhosphorIcons.articleLight),
              title: Text("Docs"),
              onTap: () => launch("https://docs.flow.linwood.tk")),
          ListTile(
              leading: Icon(PhosphorIcons.arrowCounterClockwiseLight),
              title: Text("Changelog"),
              onTap: () => launch("https://docs.flow.linwood.tk/changelog")),
          ListTile(
              leading: Icon(PhosphorIcons.identificationCardLight),
              title: Text("Imprint"),
              onTap: () => launch("https://codedoctor.tk/impress")),
          ListTile(
              leading: Icon(PhosphorIcons.shieldLight),
              title: Text("Privacy policy"),
              onTap: () => launch("https://docs.flow.linwood.tk/privacypolicy")),
          ListTile(
              leading: Icon(PhosphorIcons.infoLight),
              title: Text("About"),
              onTap: () =>
                  showAboutDialog(context: context, applicationIcon: Image.asset("images/logo.png", height: 50))),
        ])));
  }
}
