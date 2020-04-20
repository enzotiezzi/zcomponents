import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:z_components/styles/main-style.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_feature_detector/image_feature_detector.dart';

class MainTesting extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainTestingState();
}

class _MainTestingState extends State<MainTesting> {
  Uint8List _imagem;

  @override
  void initState() {
    super.initState();

    _buscarDocumentoImagem();
  }

  @override
  Widget build(BuildContext context) {
    return MainStyle.get(context)
        .getDefaultScaffold("Componente de teste", _buildBody());
  }

  Widget _buildBody() {
    if (_imagem != null)
      return new Container(
        padding: const EdgeInsets.all(16.0),
        child: new Image(image: new MemoryImage(_imagem)),
      );
    else
      return new Container();
  }

  Future<void> _buscarDocumentoImagem() async {
    var imagem = await ImagePicker.pickImage(source: ImageSource.camera);

    if (imagem != null) {
      var documento =
          await ImageFeatureDetector.detectAndTransformRectangle(imagem.path);

      if (documento != null) {
        var arquivoDocumento = new File(documento.filePath);

        setState(() {
          _imagem = arquivoDocumento.readAsBytesSync();
        });
      }
    }
  }
}
