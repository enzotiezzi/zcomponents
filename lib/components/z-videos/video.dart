import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class Video extends StatefulWidget {
  static final String? ROUTER = "/video";
  final String? videoPlayerController1;
  final String? titulo;
  final String? descricao;
  final index;
  Video(
      {
        this.videoPlayerController1,
        this.titulo,
        this.descricao,
        this.index
      });
  @override
  State<StatefulWidget> createState() => _Video();
}

class _Video extends State<Video> with TickerProviderStateMixin {
  VideoPlayerController? _videoPlayerController1;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController1 = VideoPlayerController.network(widget.videoPlayerController1!);

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1!,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: true,
    );
  }

  @override
  void dispose() {
    _videoPlayerController1?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:_buildTelaOrientacao()
    );
  }
  Widget _buildTelaOrientacao(){
    if(MediaQuery.of(context).orientation == Orientation.landscape){
      return Scaffold(
        body: ListView(
          children: <Widget>[
            new Container(
              child: Align(
                  alignment: Alignment.topCenter,
                  child: new Hero(tag: 'video${widget.index}', child: Chewie(
                    controller: _chewieController!,
                  ),)
              ),
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  margin: const EdgeInsets.only(top: 6,bottom: 6),
                  width: MediaQuery.of(context).size.width*0.9,
                  child: new Text(widget.descricao!,style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                )
              ],
            )
          ],
        ),
      );
    }
    else{
     return Scaffold(
        appBar: AppBar(
          title: Text(widget.titulo!),
          centerTitle: true,
        ),
        body: ListView(
          children: <Widget>[
            new Container(
              child: Align(
                  alignment: Alignment.topCenter,
                  child: new Hero(tag: 'video${widget.index}', child: Chewie(
                    controller: _chewieController!,
                  ),)
              ),
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  margin: const EdgeInsets.only(top: 6),
                  width: MediaQuery.of(context).size.width*0.9,
                  child: new Text(widget.descricao!,style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                )
              ],
            )
          ],
        ),
      );
    }
  }
}
