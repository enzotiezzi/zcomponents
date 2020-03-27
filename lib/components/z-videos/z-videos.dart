import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/z-videos/video.dart';
import 'package:z_components/view-model/noticia-viewmodel.dart';

import 'genthumbnail.dart';

class ZVideos extends StatefulWidget {


  final List<NoticiaViewModel> noticiaViewMode;
  final ScrollController scrollC;

  ZVideos({
        this.noticiaViewMode,
        this.scrollC
      });

  @override
  State<StatefulWidget> createState() => _ZNews();
}

class _ZNews extends State<ZVideos> with TickerProviderStateMixin {

  String _tempDir;
  GenThumbnailImage _futreImage;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return listView();
  }

  Widget listView() {
    if(MediaQuery.of(context).orientation == Orientation.landscape){
      return new Container(
        height: MediaQuery.of(context).size.height*0.6,
        child:
        new ListView.builder(
            itemCount: widget.noticiaViewMode.length,
            shrinkWrap: true,
            padding: const EdgeInsets.all(0),
            controller: widget.scrollC,
            itemBuilder: (context, index) {
              carregarThumb(widget.noticiaViewMode[index].urlImagem);
              return new Card(
                  elevation: 3,
                  margin: const EdgeInsets.only(left: 16, right: 16, top: 8),
                  child:
                  new GestureDetector(
                    onTap: (){
                      _onClickCardVideo(widget.noticiaViewMode[index].url,widget.noticiaViewMode[index].titulo,widget.noticiaViewMode[index].descricao,index);
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
                                new Hero(tag: 'video$index', child: _futreImage)
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
            }),
      );
    }
    else{
     return new ListView.builder(
          itemCount: widget.noticiaViewMode.length,
          shrinkWrap: true,
          padding: const EdgeInsets.all(0),
          controller: widget.scrollC,
          itemBuilder: (context, index) {
            carregarThumb(widget.noticiaViewMode[index].urlImagem);
            return new Card(
                elevation: 3,
                margin: const EdgeInsets.only(left: 16, right: 16, top: 8),
                child:
                new GestureDetector(
                  onTap: (){
                    _onClickCardVideo(widget.noticiaViewMode[index].url,widget.noticiaViewMode[index].titulo,widget.noticiaViewMode[index].descricao,index);
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
                              new Hero(tag: 'video$index', child: _futreImage)
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
  }

  void carregarThumb(String url) async {
    _futreImage = GenThumbnailImage(
        thumbnailRequest: ThumbnailRequest(
            video: TextEditingController(text:url).text,
            thumbnailPath:_tempDir,
            imageFormat: ImageFormat.JPEG,
            maxHeight: 0,
            maxWidth: 0,
            timeMs: 0,
            quality: 100));
  }

  void _onClickCardVideo(String ulr,String titulo,String descricao,int index) async {
    Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (c, a1, a2) => Video(videoPlayerController1: ulr,titulo: titulo,descricao: descricao,index: index,),
          transitionDuration: Duration(milliseconds: 500),
        ),
      );
  }
}
