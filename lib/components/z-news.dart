import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:z_components/view-model/noticia-viewmodel.dart';

class ZNews extends StatefulWidget {


  final List<NoticiaViewModel> noticiaViewMode;
  final ScrollController scrollC;
  void Function(String idNoticia) onTap;

  ZNews({
    this.noticiaViewMode,
    this.scrollC,
    this.onTap
  });

  @override
  State<StatefulWidget> createState() => _ZNews();
}

class _ZNews extends State<ZNews> with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return listView();
  }

  Widget listView() {
    return new ListView.builder(
        itemCount: widget.noticiaViewMode.length,
        shrinkWrap: true,
        controller: widget.scrollC,
        itemBuilder: (context, index) {
          return new Card(
              elevation: 3,
              margin: const EdgeInsets.only(left: 16, right: 16, top: 8),
              child:
              new InkWell(
                onTap: (){
                  onClickCardNoticia(widget.noticiaViewMode[index].url,widget.noticiaViewMode[index].idNoticia);
                },
                child: new Padding(padding: const EdgeInsets.all(6),
                  child: new Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Expanded(
                        flex: 3,
                        child: new Column(
                          children: <Widget>[
                            new Container(
                              height: 60,
                              width: 100,
                              decoration: new BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(widget.noticiaViewMode[index].urlImagem),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          ],
                        ), ),
                      new Expanded(
                        flex: 7,
                        child:
                        new Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Container(
                                child: new Text(widget.noticiaViewMode[index].titulo,style: new TextStyle(fontWeight: FontWeight.bold),maxLines: 1,overflow: TextOverflow.ellipsis,) ,
                              ),
                              new Container(
                                child: new Text(widget.noticiaViewMode[index].descricao,style: new TextStyle(fontWeight: FontWeight.w500),maxLines: 1,overflow: TextOverflow.ellipsis,) ,
                              ),
                              new Row(
                                children: <Widget>[
                                  new Container(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: new Icon(Icons.import_contacts,size: 16,),
                                  ),
                                  new Container(
                                    width: MediaQuery.of(context).size.width*0.5,
                                    margin: const EdgeInsets.only(top: 6,left: 6),
                                    child: new Text("${widget.noticiaViewMode[index].autor} - ${widget.noticiaViewMode[index].publicadaEm}",overflow: TextOverflow.ellipsis,maxLines: 1,) ,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),)

                    ],
                  ),)
                ,
              )

          );
        });
  }

  void onClickCardNoticia(String noticiaUrl,String idNoticia)async{
    widget.onTap(idNoticia);
    var url = '$noticiaUrl';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}
