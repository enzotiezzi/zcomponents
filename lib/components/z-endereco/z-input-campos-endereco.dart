import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:z_components/components/utils/dialog-utils.dart';
import 'package:z_components/components/utils/icone-voltar.dart';
import 'package:z_components/components/z-inputs/z-input-cep.dart';
import 'package:http/http.dart' as http;
import 'package:z_components/components/z-inputs/z-input-generic.dart';

class ZInputCamposEndereco extends StatefulWidget {
  final ThemeData themeData;
  final TextEditingController cepController;
  final TextEditingController logradouroController;
  final TextEditingController numeroController;
  final TextEditingController complementoController;
  final TextEditingController bairroController;
  final TextEditingController cidadeController;
  final TextEditingController estadoController;

  ZInputCamposEndereco({
    @required this.themeData,
    this.cepController,
    this.logradouroController,
    this.numeroController,
    this.complementoController,
    this.bairroController,
    this.cidadeController,
    this.estadoController,
  });
  @override
  _ZInputCamposEnderecoState createState() => _ZInputCamposEnderecoState();
}

class _ZInputCamposEnderecoState extends State<ZInputCamposEndereco> {
  FocusNode cepFocusNode = new FocusNode();
  FocusNode logradouroFocusNode = new FocusNode();
  FocusNode estadoFocusNode = new FocusNode();
  FocusNode cidadeFocusNode = new FocusNode();
  FocusNode bairroFocusNode = new FocusNode();
  FocusNode numeroFocusNode = new FocusNode();
  FocusNode complementoFocusNode = new FocusNode();

  String endereco = "";
  bool cepPreenchido = false;
  bool camposValidados = false;
  bool cepValido = false;

  Completer<GoogleMapController> _controller = Completer();

  CameraPosition _posicaoCamera =
      CameraPosition(target: LatLng(-23.563999, -46.653256));

  Set<Marker> _marcadores = {};

  @override
  void initState() {
    super.initState();
    if (widget.cepController.text.isNotEmpty &&
        widget.cepController.text.length == 9 &&
        widget.cepController.text != null) {
      cepValido = true;
      cepPreenchido = true;
    }
    if (widget.cepController.text.isNotEmpty &&
        widget.cepController.text != null &&
        widget.logradouroController.text.isNotEmpty &&
        widget.logradouroController.text != null &&
        widget.numeroController.text.isNotEmpty &&
        widget.numeroController.text != null &&
        widget.bairroController.text.isNotEmpty &&
        widget.bairroController.text != null &&
        widget.cidadeController.text.isNotEmpty &&
        widget.cidadeController.text != null) {
      _preencherCampos();
      _atualizarMapa(endereco);
      _validarCamposObrigatorios();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("CAMPOS DE ENDEREÇO"),
        centerTitle: true,
        leading: new IconeVoltar(
          onTap: () async {
            if (camposValidados) {
              Navigator.of(context).pop(endereco);
            } else {
              Navigator.of(context).pop("");
            }
          },
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [new Expanded(child: _buildCampos()), _exibirBotao()],
    );
  }

  Widget _exibirBotao() {
    if (camposValidados == true) {
      return new Container(
        margin: const EdgeInsets.only(top: 16),
        child: new Material(
          elevation: 4.0,
          child: new Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height / 8,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                new RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop(endereco);
                  },
                  child: new Container(
                    child: new Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        new Container(
                          padding: const EdgeInsets.only(right: 40, left: 40),
                          child: new Text(
                            "CONFIRMAR",
                            style: Theme.of(context)
                                .textTheme
                                .button
                                .copyWith(color: Color(0xFFFFFFFF)),
                          ),
                        )
                      ],
                    ),
                  ),
                  color: Theme.of(context).primaryColor,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.only(left: 10, right: 10),
                )
              ],
            ),
          ),
        ),
      );
    } else {
      return new Container(
        margin: const EdgeInsets.only(top: 16),
        child: new Material(
          elevation: 4.0,
          child: new Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height / 8,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                new RaisedButton(
                  onPressed: null,
                  child: new Container(
                    child: new Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        new Container(
                          padding: const EdgeInsets.only(right: 40, left: 40),
                          child: new Text(
                            "CONFIRMAR",
                            style: Theme.of(context)
                                .textTheme
                                .button
                                .copyWith(color: Color(0xFFFFFFFF)),
                          ),
                        )
                      ],
                    ),
                  ),
                  color: Theme.of(context).primaryColor,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.only(left: 10, right: 10),
                )
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget _buildMapa() {
    if (cepPreenchido) {
      return new Container(
        width: double.infinity,
        height: 250,
        margin: const EdgeInsets.only(top: 16),
        child: new GoogleMap(
          mapType: MapType.normal,
          onMapCreated: _onMapCreated,
          markers: _marcadores,
          initialCameraPosition: _posicaoCamera,
        ),
      );
    } else {
      return new Container();
    }
  }

  Widget _buildCampos() {
    return new ListView(
      shrinkWrap: true,
      children: [
        new ZInputCEP(
          themeData: widget.themeData,
          cepFocus: cepFocusNode,
          controllerCep: widget.cepController,
          campoObrigatorio: true,
          validacao: (cepValidado) {
            if (cepValidado) {
              _consultaCep(widget.cepController.text, context);
              cepValido = true;
              _validarCamposObrigatorios();
              numeroFocusNode.requestFocus();
            } else {
              cepValido = false;
              cepFocusNode.unfocus();
              _validarCamposObrigatorios();
            }
          },
          onChange: (cep) {
            if (cep.isEmpty) {
              cepValido = false;
              _validarCamposObrigatorios();
            }
          },
        ),
        new Divider(
          height: 1.0,
        ),
        new Container(
          margin: const EdgeInsets.only(top: 16),
          child: new ZInputGeneric(
            themeData: widget.themeData,
            titulo: "Logradouro",
            campoObrigatorio: true,
            enabled: true,
            inputPadraoFocus: logradouroFocusNode,
            controllerInputPadrao: widget.logradouroController,
            onChange: (rua) {
              _validarCamposObrigatorios();
              _preencherCampos();
              String montarEndereco = widget.numeroController.text +
                  " " +
                  widget.logradouroController.text +
                  " " +
                  widget.bairroController.text;
              _atualizarMapa(montarEndereco);
            },
          ),
        ),
        new Divider(
          height: 1.0,
        ),
        new ZInputGeneric(
          themeData: widget.themeData,
          titulo: "Número",
          enabled: true,
          inputPadraoFocus: numeroFocusNode,
          controllerInputPadrao: widget.numeroController,
          proximoFocus: complementoFocusNode,
          campoObrigatorio: true,
          onChange: (numero) {
            _validarCamposObrigatorios();
            _preencherCampos();
            String montarEndereco = widget.numeroController.text +
                " " +
                widget.logradouroController.text +
                " " +
                widget.bairroController.text;
            _atualizarMapa(montarEndereco);
          },
        ),
        new Divider(
          height: 1.0,
        ),
        new ZInputGeneric(
          themeData: widget.themeData,
          titulo: "Complemento",
          enabled: true,
          inputPadraoFocus: complementoFocusNode,
          controllerInputPadrao: widget.complementoController,
          onChange: (complemento) {
            _preencherCampos();
          },
        ),
        new Divider(
          height: 1.0,
        ),
        new ZInputGeneric(
          themeData: widget.themeData,
          titulo: "Bairro",
          enabled: true,
          inputPadraoFocus: bairroFocusNode,
          controllerInputPadrao: widget.bairroController,
          campoObrigatorio: true,
          onChange: (bairro) {
            _validarCamposObrigatorios();
            _preencherCampos();
          },
        ),
        new Divider(
          height: 1.0,
        ),
        new ZInputGeneric(
          themeData: widget.themeData,
          titulo: "Cidade",
          enabled: true,
          inputPadraoFocus: cidadeFocusNode,
          controllerInputPadrao: widget.cidadeController,
          barrarEntradaDeNumeros: true,
          comMascara: true,
          campoObrigatorio: true,
          onChange: (cidade) {
            _validarCamposObrigatorios();
            _preencherCampos();
          },
        ),
        new Divider(
          height: 1.0,
        ),
        new ZInputGeneric(
          themeData: widget.themeData,
          titulo: "Estado",
          enabled: true,
          inputPadraoFocus: estadoFocusNode,
          controllerInputPadrao: widget.estadoController,
          comMascara: true,
          barrarEntradaDeNumeros: true,
          onChange: (estado) {
            _validarCamposObrigatorios();
            _preencherCampos();
          },
        ),
        new Divider(
          height: 1.0,
        ),
        _buildMapa()
      ],
    );
  }

  void _validarCamposObrigatorios() {
    if (widget.cepController.text.isNotEmpty &&
        widget.cepController.text != null &&
        widget.logradouroController.text.isNotEmpty &&
        widget.logradouroController.text != null &&
        widget.numeroController.text.isNotEmpty &&
        widget.numeroController.text != null &&
        widget.bairroController.text.isNotEmpty &&
        widget.bairroController.text != null &&
        widget.cidadeController.text.isNotEmpty &&
        widget.cidadeController.text != null &&
        cepValido) {
      setState(() {
        camposValidados = true;
      });
    } else {
      setState(() {
        camposValidados = false;
      });
    }
  }

  Future<void> _consultaCep(String cep, BuildContext context) async {
    DialogUtils dialogUtils = new DialogUtils(context);
    dialogUtils.showProgressDialog();

    String url = "https://viacep.com.br/ws/${cep}/json/";
    http.Response response;
    response = await http.get(Uri.parse(url));
    Map<String, dynamic> retorno = json.decode(response.body);

    if (response.statusCode == 200) {
      widget.logradouroController.text = retorno["logradouro"];
      widget.bairroController.text = retorno["bairro"];
      widget.cidadeController.text = retorno["localidade"];
      widget.estadoController.text = retorno["uf"];

      _preencherCampos();

      dialogUtils.dismiss();

      if (retorno["logradouro"] != null &&
          retorno["bairro"] != null &&
          retorno["localidade"] != null &&
          retorno["uf"] != null) {
        String montarLocalizacao = widget.logradouroController.text +
            " " +
            widget.bairroController.text;
        setState(() {
          _atualizarMapa(montarLocalizacao);
          cepPreenchido = true;
        });
      } else {
        dialogUtils.showAlertDialogNewAviso(
            "CEP Incorreto!", "Por favor, revise seu CEP.");
        dialogUtils.dismiss();
      }
    } else {
      print('Código de Retorno: ' + response.statusCode.toString());
      print('Erro: ' + response.body);
      dialogUtils.dismiss();
    }
  }

  void _preencherCampos() {
    setState(() {
      endereco = widget.logradouroController.text +
          ", " +
          widget.numeroController.text +
          ", " +
          widget.complementoController.text +
          ", " +
          widget.bairroController.text;
    });
  }

  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  _atualizarMapa(String localizacao) async {
    GeoCode geoCode = GeoCode(apiKey: '375033675458612995582x108984');
    var endereco = await geoCode.forwardGeocoding(address: localizacao);
    // var endereco = await Geocoder.local.findAddressesFromQuery(localizacao);
    var coordenadas = endereco;

    setState(() {
      _posicaoCamera = CameraPosition(
          zoom: 19,
          target: LatLng(coordenadas.latitude, coordenadas.longitude));
      _marcadores = {};
      Marker marcador = Marker(
          markerId: MarkerId(DateTime.now().toString()),
          position: LatLng(coordenadas.latitude, coordenadas.longitude),
          infoWindow: InfoWindow(title: "Meu Local"),
          icon: BitmapDescriptor.defaultMarker);
      _marcadores.add(marcador);
      _movimentarCamera(_posicaoCamera);
    });
  }

  _movimentarCamera(CameraPosition posicaoCamera) async {
    GoogleMapController googleMapController = await _controller.future;
    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(posicaoCamera));
  }
}
