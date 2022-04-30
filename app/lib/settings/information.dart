import 'package:flow_app/widgets/advanced_switch_list_tile.dart';
import 'package:flow_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class InformationPage extends StatefulWidget {
  const InformationPage({Key? key}) : super(key: key);

  @override
  _InformationPageState createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  @override
  Widget build(BuildContext context) {
    return FlowScaffold(
        page: RoutePages.information,
        pageTitle: "Information",
        body: SingleChildScrollView(
            child: Column(children: [
          ListTile(
              leading: const Icon(PhosphorIcons.stackLight),
              title: const Text("License"),
              onTap: () => launchUrl(Uri.https(
                  "github.com", "/LinwoodCloud/Flow/blob/main/LICENSE"))),
          ListTile(
              leading: const Icon(PhosphorIcons.codeLight),
              title: const Text("Code"),
              onTap: () =>
                  launchUrl(Uri.https("github.com", "/LinwoodCloud/Flow"))),
          ListTile(
              leading: const Icon(PhosphorIcons.usersLight),
              title: const Text("Discord"),
              onTap: () => launchUrl(Uri.https("discord.linwood.dev", ""))),
          ListTile(
              leading: const Icon(PhosphorIcons.articleLight),
              title: const Text("Docs"),
              onTap: () => launchUrl(Uri.https("docs.flow.linwood.dev", ""))),
          ListTile(
              leading: const Icon(PhosphorIcons.arrowCounterClockwiseLight),
              title: const Text("Changelog"),
              onTap: () =>
                  launchUrl(Uri.https("docs.flow.linwood.dev", "/changelog"))),
          ListTile(
              leading: const Icon(PhosphorIcons.identificationCardLight),
              title: const Text("Imprint"),
              onTap: () =>
                  launchUrl(Uri.https("https://go.linwood.dev", "/impress"))),
          ListTile(
              leading: const Icon(PhosphorIcons.shieldLight),
              title: const Text("Privacy policy"),
              onTap: () => launchUrl(
                  Uri.https("docs.flow.linwood.dev", "/privacypolicy"))),
          ListTile(
              leading: const Icon(PhosphorIcons.infoLight),
              title: const Text("About"),
              onTap: () => showAboutDialog(
                  context: context,
                  applicationIcon: Image.asset("images/logo.png", height: 50))),
          AdvancedSwitchListTile(
              value: false,
              onTap: () {},
              onChanged: (value) {},
              title: const Text("Wifi"))
        ])));
  }
}
