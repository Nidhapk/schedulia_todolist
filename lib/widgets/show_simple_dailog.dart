import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSimpleDialog extends StatelessWidget {
  final Function(String) onOptionSelected;
  const CustomSimpleDialog({super.key, required this.onOptionSelected});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: customTitle('Choose any category'),
      children: <Widget>[
        const SizedBox(
          height: 10,
        ),
        SizedBox(
            height: 90,
            width: 90,
            child: SvgPicture.asset(
                'lib/assets/addCategory/undraw_palette_-110-c.svg')),
        const SizedBox(
          height: 10,
        ),
        SimpleDialogOption(
          onPressed: () {
            onOptionSelected('Option 1');

            Navigator.pop(context);
          },
          child: myCustomText('Personal'),
        ),
        SimpleDialogOption(
          onPressed: () {
            onOptionSelected('Option 2');

            Navigator.pop(context); // Close the dialog
          },
          child: myCustomText('Work'),
        ),
        SimpleDialogOption(
            onPressed: () {
              onOptionSelected('option 3');

              Navigator.pop(context); // Close the dialog
            },
            child: myCustomText('Health')),
        SimpleDialogOption(
            onPressed: () {
              onOptionSelected('option 4');

              Navigator.pop(context); // Close the dialog
            },
            child: myCustomText('Travel')),
        SimpleDialogOption(
          onPressed: () {
            // Handle 'Work' option

            Navigator.pop(context); // Close the dialog
          },
          child: myCustomText('Grocery'),
        ),
      ],
    );
  }

  Widget myCustomText(String text) {
    return Center(
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget customTitle(String text) {
    return Center(
      child: Text(
        text,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }
}
