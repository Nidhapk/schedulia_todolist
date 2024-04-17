import 'package:flutter/material.dart';


class CustomDropdownButton extends StatelessWidget {
  final String? selectedValue;
  final ValueChanged onChanged;
  final List<String> items;
  final TextEditingController? controller;

  const CustomDropdownButton({
    Key? key,
    this.selectedValue,
    required this.onChanged,
    required this.items,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 213, 204, 219),
          border: Border.all(
            color: Colors.black, //width: 3.0
          ),
          borderRadius: BorderRadius.circular(30.0)),
      width: 370,
      child: DropdownButtonHideUnderline(
        child: Padding(
          padding: const EdgeInsets.only(right: 18.0),
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton<String>(
              value: selectedValue,
              onChanged: (String? newValue) {
                onChanged(newValue);
              },
              items: items.map<DropdownMenuItem<String>>((dynamic value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
