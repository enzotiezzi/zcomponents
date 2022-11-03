import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:z_components/components/z-news-webview.dart';
import 'package:z_components/components/z_loading.dart';
import 'package:z_components/view-model/noticia-viewmodel.dart';

class ZNews extends StatefulWidget {
  final List<NoticiaViewModel> noticiaViewMode;
  final ScrollController scrollC;
  void Function(String idNoticia) onTap;

  ZNews({this.noticiaViewMode, this.scrollC, this.onTap});

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
              child: new InkWell(
                onTap: () {
                  onClickCardNoticia(
                      widget.noticiaViewMode[index].url,
                      widget.noticiaViewMode[index].idNoticia,
                      widget.noticiaViewMode[index].titulo);
                },
                child: new Padding(
                  padding: const EdgeInsets.all(6),
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
                              child: CachedNetworkImage(
                                imageUrl:
                                    widget.noticiaViewMode[index].urlImagem,
                                placeholder: (context, url) => SizedBox(
                                  child: Shimmer.fromColors(
                                    baseColor: Color(0xffe6e6e6),
                                    highlightColor: Colors.white,
                                    child: new Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xffe6e6e6),
                                      ),
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                fadeOutDuration: const Duration(seconds: 1),
                                fadeInDuration:
                                    const Duration(milliseconds: 1300),
                              ),
                            )
                          ],
                        ),
                      ),
                      new Expanded(
                        flex: 7,
                        child: new Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Container(
                                child: new Text(
                                  widget.noticiaViewMode[index].titulo,
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              new Container(
                                child: new Text(
                                  widget.noticiaViewMode[index].descricao,
                                  style: new TextStyle(
                                      fontWeight: FontWeight.w500),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              new Row(
                                children: <Widget>[
                                  new Container(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: new Icon(
                                      Icons.import_contacts,
                                      size: 16,
                                    ),
                                  ),
                                  new Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    margin:
                                        const EdgeInsets.only(top: 6, left: 6),
                                    child: new Text(
                                      "${widget.noticiaViewMode[index].autor} - ${widget.noticiaViewMode[index].publicadaEm}",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ));
        });
  }

  void onClickCardNoticia(
      String noticiaUrl, String idNoticia, String titulo) async {
    widget.onTap(idNoticia);
    var url = '$noticiaUrl';
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ZNewsWebView(
                  url: url,
                  titulo: titulo,
                )));
  }
}
