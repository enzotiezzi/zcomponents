import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_genius_scan/flutter_genius_scan.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:z_components/api/arquivo/arquivo-service.dart';
import 'package:z_components/api/arquivo/i-arquivo-service.dart';
import 'package:z_components/api/colaborador-documento/colaborador-documento.dart';
import 'package:z_components/api/colaborador-documento/i-colaborador-documento-service.dart';
import 'package:z_components/api/input/colaborador-documento-input.dart';
import 'package:z_components/components/utils/dialog-utils.dart';
import 'package:z_components/components/z-documentos/presenter/foto.dart';
import 'package:z_components/components/z-documentos/presenter/scan-documento.dart';
import 'package:z_components/components/z-injector/z-injector.dart';
import 'package:z_components/i-view.dart';
import 'package:z_components/view-model/arquivo-viewmodel.dart';

class ZScanDocumentoView extends IView<ScanDocumentos> {
  IArquivoService _arquivoService;
  IColaboradorDocumentoService _colaboradorDocumentoService;

  String foto;
  List<Uint8List> fotos = new List();
  List<Uint8List> fotosAmpliada = new List();
  List<String> listaRespostasUsuario = new List();
  List<String> listaIdArquivo = new List();
  int posicaoLista = 0;
  Map<String, String> camposMapeados = {};
  Map<String, int> imagensMapeados = {};
  DialogUtils dialogUtils;

  ScrollController scrollControllerTudo = new ScrollController();

  bool permissaoGaleria = false;

  final Uint8List kTransparentImage = new Uint8List.fromList(<int>[
    0x89,
    0x50,
    0x4E,
    0x47,
    0x0D,
    0x0A,
    0x1A,
    0x0A,
    0x00,
    0x00,
    0x00,
    0x0D,
    0x49,
    0x48,
    0x44,
    0x52,
    0x00,
    0x00,
    0x00,
    0x01,
    0x00,
    0x00,
    0x00,
    0x01,
    0x08,
    0x06,
    0x00,
    0x00,
    0x00,
    0x1F,
    0x15,
    0xC4,
    0x89,
    0x00,
    0x00,
    0x00,
    0x0A,
    0x49,
    0x44,
    0x41,
    0x54,
    0x78,
    0x9C,
    0x63,
    0x00,
    0x01,
    0x00,
    0x00,
    0x05,
    0x00,
    0x01,
    0x0D,
    0x0A,
    0x2D,
    0xB4,
    0x00,
    0x00,
    0x00,
    0x00,
    0x49,
    0x45,
    0x4E,
    0x44,
    0xAE,
  ]);

  ZScanDocumentoView(State state) : super(state);

  @override
  Future<void> afterBuild() {
    // TODO: implement afterBuild
    throw UnimplementedError();
  }

  @override
  Future<void> initView() async {
    dialogUtils = DialogUtils(state.context);
    _arquivoService = new ArquivoService(state.widget.token);
    _colaboradorDocumentoService =
        new ColaboradorDocumentoService(state.widget.token);
    await _inicializarListaRespostas();
    await FlutterGeniusScan.setLicenceKey(state.widget.keyGeniusScan);
    await _buscarIdFotos();
  }

  void displayError(BuildContext context, PlatformException error) {
    try {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(error.message)));
    } catch (e) {}
  }

  Future scanDocumento() {
    FlutterGeniusScan.scanWithConfiguration({
      'source': 'camera',
      'defaultFilter': 'none',
      'postProcessingActions': ['rotate'],
      'multiPage': false,
    }).then((result) async {
      var scans = result['scans'];

      var fotoCortada = scans[0]['enhancedUrl'].toString();

      foto = fotoCortada.replaceAll("file://", '');

      var file = File(foto);

      var resultUint8List = await FlutterImageCompress.compressWithFile(
        file.absolute.path,
        minWidth: 1024,
        quality: 70,
      );

      state.setState(() {
        fotos.add(resultUint8List);
      });
    }, onError: (error) => displayError(state.context, error));
  }

  Future expandirImagem(int hero, int hero2, Uint8List caminho) async {
    fotosAmpliada.length = fotos.length;
    fotosAmpliada = await showDialog(
        context: state.context,
        builder: (context) {
          return new Foto(
            hero: hero,
            hero2: hero2,
            finalizacaoChamado: true,
            imagem: caminho,
            fotos: fotos,
          );
        });
    if (fotos != fotosAmpliada) {
      fotos = fotosAmpliada;
    }
    state.setState(() {});
  }

  Future<void> _inicializarListaRespostas() async {
    var lista = await _colaboradorDocumentoService.listarDocumentoCampo(
        state.widget.colaboradorDocumentoViewModel.idColaborador,
        state.widget.colaboradorDocumentoViewModel.idDocumento);
    for (int i = 0;
        i < state.widget.colaboradorDocumentoViewModel.campos.length;
        i++) {
      listaRespostasUsuario.add("");
    }

    if (lista != null) {
      for (int i = 0;
          i < state.widget.colaboradorDocumentoViewModel.campos.length;
          i++) {
        for (int j = 0;
            j < state.widget.colaboradorDocumentoViewModel.campos.length;
            j++) {
          if (state.widget.colaboradorDocumentoViewModel.campos[i]
                  .idCampo ==
              lista[j].idDocumentoCampo) {
            if (state.widget.colaboradorDocumentoViewModel.campos[i]
                    .tipoValorCampo !=
                "date") {
              listaRespostasUsuario[i] = lista[j].valor;
            } else {
              try {
                listaRespostasUsuario[i] =
                    UtilData.obterDataDDMMAAAA(DateTime.parse(lista[j].valor));
              } catch (e) {
                listaRespostasUsuario[i] = lista[j].valor;
              }
            }
          }
        }
      }
    }
    if (state.mounted) {
      state.setState(() {});
    }
  }

  bool mapearCamposComRespostas() {
    try {
      for (int i = 0;
          i < state.widget.colaboradorDocumentoViewModel.campos.length;
          i++) {
        if (state.widget.colaboradorDocumentoViewModel.campos[i].obrigatorio ==
                true &&
            listaRespostasUsuario[i] == "") {
          return false;
        }
        if (state.widget.colaboradorDocumentoViewModel.campos[i]
                .tipoValorCampo ==
            "date") {
          try {
            var validarData = isValidDate(listaRespostasUsuario[i]);

            if (validarData) {
              camposMapeados.addAll({
                state.widget.colaboradorDocumentoViewModel.campos[i]
                    .idCampo: listaRespostasUsuario[i]
              });
            } else {
              return false;
            }
          } catch (e) {
            return false;
          }
        } else {
          camposMapeados.addAll({
            state.widget.colaboradorDocumentoViewModel.campos[i]
                .idCampo: listaRespostasUsuario[i]
          });
        }
      }
      return true;
    } catch (e) {
      print(e);
    }
  }

  void mapearimagens() {
    for (int i = 0; i < listaIdArquivo.length; i++) {
      imagensMapeados.addAll({listaIdArquivo[i]: (i + 1)});
    }
  }

  Future<void> enviarFotos() async {
    if (fotos != null && fotos.length > 0) {
      for (var i = 0; i <= fotos.length - 1; i++) {
        var arqModel = await montarViewModelDeArquivo(fotos[i]);

        var idFotoArquivo = await _arquivoService.enviarImagem(arqModel);

        if (idFotoArquivo != null) {
          listaIdArquivo.add(idFotoArquivo);
        }
      }
    }
  }

  Future<void> _buscarIdFotos() async {
    var lista = await _colaboradorDocumentoService.listarDocumentoImagem(
        state.widget.colaboradorDocumentoViewModel.idColaborador,
        state.widget.colaboradorDocumentoViewModel.idDocumento);

    if (lista != null) {
      for (int i = 0; i < lista.length; i++) {
        await buscarFotos(lista[i].idImagem);
      }
      if (state.mounted) {
        state.setState(() {});
      }
    }
  }

  Future<void> buscarFotos(String idArquivo) async {
    var idFotoArquivo = await _arquivoService.buscarAnexo(idArquivo);
    if (idFotoArquivo != null) {
      Uint8List image = base64Decode(idFotoArquivo.conteudo);

      fotos.add(image);
    }
  }

  String timestamp() => new DateTime.now().millisecondsSinceEpoch.toString();

  Future<ArquivoViewModel> montarViewModelDeArquivo(Uint8List file) async {
    String base64Image = base64Encode(file);

    String timestamp() => new DateTime.now().millisecondsSinceEpoch.toString();

    var tamanhoFoto = base64Image.length;
    var tamanhoFotoString = tamanhoFoto.toString();
    var tamanhoFotoDouble = double.parse(tamanhoFotoString);

    ArquivoViewModel arquivoViewModel = new ArquivoViewModel(
      nome: "${timestamp()}.jpg",
      tamanho: tamanhoFotoDouble,
      descricao: "Arquivo do app cadastro documentos",
      contentType: "image/jpg",
      container: "teste",
      conteudo: base64Image,
    );

    return arquivoViewModel;
  }

  bool isValidDate(String input) {
    final date = DateTime.parse(input);
    final originalFormatString = toOriginalFormatString(date);
    return input == originalFormatString;
  }

  String toOriginalFormatString(DateTime dateTime) {
    final y = dateTime.year.toString().padLeft(4, '0');
    final m = dateTime.month.toString().padLeft(2, '0');
    final d = dateTime.day.toString().padLeft(2, '0');
    return "$y-$m-$d";
  }

  Future<void> salvarDocumentos() async {
    mapearimagens();
    ColaboradorDocumentoInput input = new ColaboradorDocumentoInput(
        idColaborador: state.widget.colaboradorDocumentoViewModel.idColaborador,
        campos: camposMapeados,
        imagens: imagensMapeados);

    var res = await _colaboradorDocumentoService.enviarDocumento(
        input,
        state.widget.colaboradorDocumentoViewModel.idColaborador,
        state.widget.colaboradorDocumentoViewModel.idDocumento);
    dialogUtils.dismiss();

    if (res != null) {
      Navigator.of(state.context).pop(true);
    }
  }
}
