import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';

class AlertBoxWidget extends StatelessWidget {
  const AlertBoxWidget({
    Key key,
    @required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kAlertBoxDecoration,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
        child: Text(
          text,
          style: kAlertBoxTextStyle,
        ),
      ),
    );
  }
}
