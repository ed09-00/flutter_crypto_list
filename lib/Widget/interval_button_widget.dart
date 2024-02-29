import 'package:flutter/material.dart';

class IntervalButtonWidget extends StatelessWidget {
  const IntervalButtonWidget({Key? key, this.text, this.onTap,  this.ishighLightText})
      : super(key: key);
  //文字顏色
  final bool? ishighLightText;
  final String? text;
  final Function()? onTap;
  Widget _mainView() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: TextButton(
        style: TextButton.styleFrom(          
          minimumSize: Size(35, 20),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: EdgeInsets.zero,
        ),
        onPressed: onTap ?? () {},
        child: Text(
          '$text',
          style: ishighLightText==true? TextStyle(color: Colors.amber) :TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _mainView();
  }
}
