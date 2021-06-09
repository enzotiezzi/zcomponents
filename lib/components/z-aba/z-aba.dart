import 'package:flutter/material.dart';
import 'package:z_components/components/z-aba/z-aba-viewmodel.dart';

class ZAba extends StatefulWidget {
  List<ZAbaViewModel> zAbaViewModel;

  ZAba({this.zAbaViewModel});

  @override
  _ZAbaState createState() => _ZAbaState();
}

class _ZAbaState extends State<ZAba> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: new ListView.builder(    padding: EdgeInsets.only(top: 20.0, bottom: 20.0, right: 10.0),
        scrollDirection: Axis.horizontal,
        itemCount: widget.zAbaViewModel.length,
        itemBuilder: (context, index) =>
            _montarCardAba(widget.zAbaViewModel[index]),
      ),
    );
  }

  Widget _montarCardAba(ZAbaViewModel item) {
    return SizedBox(
      width: 160,
      child: new GestureDetector(
        onTap: () {
          item.onTap();
        },
        child: new Container(
          margin: EdgeInsets.only(left: 10.0),
          child: new Material(
            borderRadius: BorderRadius.circular(6.0),
            elevation: 2,
            child: new Container(
              padding: EdgeInsets.only(top: 10,left: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new Container(
                    margin: EdgeInsets.all(6.0),
                    child: item.icon,
                  ),
                  new Container(
                    margin: EdgeInsets.all(6.0),
                    child: new Text(
                      item.titulo,
                      style: TextStyle(
                          color: Color(0xff000000), fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
