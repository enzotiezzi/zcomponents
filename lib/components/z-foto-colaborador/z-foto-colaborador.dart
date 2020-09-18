import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:z_components/components/z_loading.dart';
import 'package:z_components/settings/api-settings.dart';

class ZFotoColaborador extends StatefulWidget {
  final String token;
  final String idColaborador;

  ZFotoColaborador({@required this.idColaborador, @required this.token});

  @override
  State<StatefulWidget> createState() => new _ZFotoColaboradorState();
}

class _ZFotoColaboradorState extends State<ZFotoColaborador> {
  String _url =
      "${ApiSettings.ENDPOINT_API}/colaboradores/v2/m-buscar-foto-perfil-colaborador";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.token == null || widget.token.length == 0)
      return new ZLoading(
        color: Color(0XFF801F92),
      );
    else {
      var url = "$_url/${widget.idColaborador}";

      var header = {HttpHeaders.authorizationHeader: "Bearer ${widget.token}"};

      return CachedNetworkImage(
        cacheManager: DefaultCacheManager(),
        httpHeaders: header,
        imageUrl: url,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5.0),
                bottomLeft: Radius.circular(5.0)),
          ),
        ),
        placeholder: (context, url) => ZLoading(
          color: Color(0XFF801F92),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),

      );
    }
  }
}
