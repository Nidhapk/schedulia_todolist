import 'package:flutter/material.dart';

class NewClass extends StatefulWidget {
  const NewClass({
    super.key,
  });

  @override
  State<NewClass> createState() => _NewClassState();
}

class _NewClassState extends State<NewClass> {
  _NewClassState() {
    selectedvalue = list[0];
  }

  final list = ['Personal', 'Work', 'health', 'Shopping', 'Travel'];

  String? selectedvalue = 'Personal';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DropdownButtonFormField(
          items: list
              .map((e) => DropdownMenuItem(
                    child: Text(e),
                    value: e,
                  ))
              .toList(),
          onChanged: (value) {}),
    );
  }
}
