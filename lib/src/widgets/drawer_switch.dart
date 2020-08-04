import 'package:flutter/material.dart';

class DrawerSwitch extends StatefulWidget {
  DrawerSwitch({
    Key key,
    this.onChahged,
    this.initialValue,
    this.title,
  }) : super(key: key);
  final Function onChahged;
  final String title;
  final initialValue;

  @override
  _DrawerSwitchState createState() => _DrawerSwitchState();
}

class _DrawerSwitchState extends State<DrawerSwitch> {
  bool _value;
  @override
  void initState() {
    _value = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Text(widget.title),
          Switch(
            value: _value,
            onChanged: (value) {
              setState(() {
                widget.onChahged();
                _value = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
