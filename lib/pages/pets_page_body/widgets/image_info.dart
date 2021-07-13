import 'package:flutter/material.dart';

class ImageAndInfo extends StatelessWidget {
  final String label;
  final String asset;

  const ImageAndInfo({Key key, this.label, this.asset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: (MediaQuery.of(context).size.height / 2) - 250),
        Container(
          decoration: BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 0.5),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(this.asset),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(25),
                child: Text(
                  this.label,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
