import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AssignField extends StatefulWidget {
  const AssignField({Key? key}) : super(key: key);

  @override
  _AssignFieldState createState() => _AssignFieldState();
}

class _AssignFieldState extends State<AssignField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          labelText: "Groups",
          icon: Icon(PhosphorIcons.usersLight),
          prefixIcon: Wrap(
              children: ["A", "B", "C"]
                  .map((e) => InputChip(
                      avatar: CircleAvatar(child: Text(e)),
                      label: Text(e),
                      backgroundColor: Colors.green,
                      onDeleted: () {},
                      onPressed: () {}))
                  .toList())),
    );
  }
}
