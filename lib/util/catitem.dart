import 'package:firebase_authentication/util/catdata.dart';
import 'package:flutter/material.dart';

class CatItem extends StatefulWidget {
  CatData catData;
  CatItem(this.catData);

  @override
  State<CatItem> createState() => _CatItemState();
}

class _CatItemState extends State<CatItem> {
  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width*0.8;
    return Container(
      child: Row(
        children: [
          Container(
            width: c_width,
            padding: EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.catData.statement,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  softWrap: true,
                  overflow: TextOverflow.clip,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
