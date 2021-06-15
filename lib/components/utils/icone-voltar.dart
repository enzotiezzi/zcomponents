import 'package:flutter/material.dart';


class IconeVoltar extends StatefulWidget {

  final BuildContext context;
  final Function onTap;

  IconeVoltar({this.context,this.onTap});
  @override
  _IconeVoltarState createState() => _IconeVoltarState();
}

class _IconeVoltarState extends State<IconeVoltar> {

  Function onTapVoltar(){
    if(widget.onTap == null){
      return (){
        Navigator.of(context).pop();
      };
    }else{
      return widget.onTap;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(8)
      ),
      margin: EdgeInsets.only(left: 20,top: 15,bottom: 15,right: 13),
      //padding: EdgeInsets.only(bottom: 20),
      child: GestureDetector(
        onTap: onTapVoltar(),
        child: new Icon(
          Icons.arrow_back_ios_outlined, color: Theme.of(context).primaryColor,size: 16,
        ),
      ),
    );
  }
}
