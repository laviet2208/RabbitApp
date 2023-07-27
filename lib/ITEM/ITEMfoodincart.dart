import 'package:flutter/material.dart';
import 'package:rabbitshipping/FINAL/finalClass.dart';
import 'package:rabbitshipping/GENERAL/Product/Product.dart';
import 'package:rabbitshipping/GENERAL/Tool/Tool.dart';
import 'package:rabbitshipping/GENERAL/utils/utils.dart';

class ITEMfoodincart extends StatefulWidget {
  final Product food;
  final double width;
  final VoidCallback onTap;
  const ITEMfoodincart({Key? key, required this.food, required this.width, required this.onTap}) : super(key: key);

  @override
  State<ITEMfoodincart> createState() => _ITEMfoodincartState();
}

class _ITEMfoodincartState extends State<ITEMfoodincart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2), // màu của shadow
            spreadRadius: 5, // bán kính của shadow
            blurRadius: 7, // độ mờ của shadow
            offset: Offset(0, 3), // vị trí của shadow
          ),
        ],
      ),

      child: Stack(
        children: <Widget>[
          Positioned(
            top: 10,
            left: 10,
            child: Text(
              compactString(20, widget.food.name),
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'arial',
                  color: Colors.black,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),

          Positioned(
            bottom: 30,
            left: 10,
            child: Text(
              compactString(20, widget.food.owner.name),
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'arial',
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),

          Positioned(
            top: 5,
            right: 45,
            child: Container(
              width: widget.width/4 - 20,
              height: widget.width/4 - 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.food.imageList[0])
                )
              ),
            ),
          ),

          Positioned(
            top: (widget.width/4 - 40)/2,
            right: 5,
            child: GestureDetector(
              onTap: widget.onTap,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/image/garbageicon.png')
                    )
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
