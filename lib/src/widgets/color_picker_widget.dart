import 'package:dart_notes_mobile/src/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerWidget extends StatefulWidget {
  ColorPickerWidget({Key key}) : super(key: key);

  @override
  _ColorPickerWidgetState createState() => _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends State<ColorPickerWidget> {
  Color currentColor = Colors.black;

  void changeColor(Color color) => setState(() {
        currentColor = color;
      });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: mainTheme.primaryColor,
      child: IconButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Select a color'),
                content: SingleChildScrollView(
                  child: BlockPicker(
                    pickerColor: currentColor,
                    onColorChanged: (color) {
                      changeColor(color);
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              );
            },
          );
        },
        icon: Icon(
          Icons.color_lens,
          color: currentColor,
        ),
      ),
    );
  }
}
