import 'package:flutter/material.dart';
import 'package:pet_register/theme/normal_theme.dart';

class CustomRadio extends StatelessWidget {
  final Function onTap;
  final IconData icon;
  final String label;
  final bool selected;
  final bool isRow;

  const CustomRadio(
      {Key key,
      @required this.onTap,
      @required this.icon,
      @required this.label,
      @required this.selected,
      this.isRow = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(minWidth: this.isRow ? 95 : 85),
        decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.9),
            borderRadius: BorderRadius.circular(20)),
        child: Container(
          margin: EdgeInsets.all(12.5),
          child: this.isRow
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: drawContentOfSet(),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: drawContentOfSet(),
                ),
        ),
      ),
    );
  }

  List<Widget> drawContentOfSet() {
    return [
      Icon(
        icon,
        color: selected ? NormalTheme.getColor('green_1') : Colors.black,
      ),
      Text(
        label,
        style: TextStyle(
            fontSize: 16,
            color: selected ? NormalTheme.getColor('green_1') : Colors.black),
      ),
    ];
  }
}
