import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
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
  TextEditingController cepController = new TextEditingController();
  FocusNode logradouroFocusNode = new FocusNode();
  TextEditingController logradouroController = new TextEditingController();
  FocusNode estadoFocusNode = new FocusNode();
  TextEditingController estadoController = new TextEditingController();
  FocusNode cidadeFocusNode = new FocusNode();
  TextEditingController cidadeController = new TextEditingController();
  FocusNode bairroFocusNode = new FocusNode();
  TextEditingController bairroController = new TextEditingController();
  FocusNode numeroFocusNode = new FocusNode();
  TextEditingController numeroController = new TextEditingController();
  FocusNode complementoFocusNode = new FocusNode();
  TextEditingController complementoController = new TextEditingController();

  String endereco="";
  bool cepPreenchido=false;
  bool camposValidados = false;

  Completer<GoogleMapController> _controller = Completer();

  CameraPosition _posicaoCamera =
  CameraPosition(target: LatLng(-23.563999, -46.653256));

  Set<Marker> _marcadores = {};

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("CAMPOS DE ENDEREÇO"),
        centerTitle: true,
        leading: new IconeVoltar(
          onTap: ()async{
           Navigator.of(context).pop(endereco);
          },
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody(){
    return new Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        new Expanded(child: _buildCampos()),
        _exibirBotao()
      ],
    );
  }

  Widget _exibirBotao(){
    if(camposValidados == true){
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
    }else{
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


  Widget _buildMapa(){
    if(cepPreenchido){
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
    }else{
      return new Container();
    }

  }

  Widget _buildCampos(){
    return new ListView(
      shrinkWrap: true,
      children: [
        new ZInputCEP(
          themeData: widget.themeData,
          cepFocus: cepFocusNode,
          controllerCep: cepController,
          campoObrigatorio: true,
          validacao: (cepValidado){
            if(cepValidado){
              _consultaCep(cepController.text, context);
              validarCamposObrigatorios();
            }
          },
          onChange: (cep){},
        ),
        new Divider(height: 1.0,),
        new Container(
          margin: const EdgeInsets.only(top: 16),
          child: new ZInputGeneric(
            themeData: widget.themeData,
            titulo: "Logradouro",
            campoObrigatorio: true,
            enabled: true,
            inputPadraoFocus: logradouroFocusNode,
            controllerInputPadrao: logradouroController,
            onChange: (rua){
              validarCamposObrigatorios();
              _preencherCampos();
              String montarEndereco = numeroController.text + " " + logradouroController.text + " " + bairroController.text;
              _atualizarMapa(montarEndereco);
            },
          ),
        ),
        new Divider(height: 1.0,),
        new ZInputGeneric(
          themeData: widget.themeData,
          titulo: "Número",
          enabled: true,
          inputPadraoFocus: numeroFocusNode,
          controllerInputPadrao: numeroController,
          campoObrigatorio: true,
          onChange: (numero){
            validarCamposObrigatorios();
            _preencherCampos();
            String montarEndereco = numeroController.text + " " + logradouroController.text + " " + bairroController.text;
            _atualizarMapa(montarEndereco);
          },
        ),
        new Divider(height: 1.0,),
        new ZInputGeneric(
          themeData: widget.themeData,
          titulo: "Complemento",
          enabled: true,
          inputPadraoFocus: complementoFocusNode,
          controllerInputPadrao: complementoController,
          onChange: (complemento){
            _preencherCampos();
          },
        ),
        new Divider(height: 1.0,),
        new ZInputGeneric(
          themeData: widget.themeData,
          titulo: "Bairro",
          enabled: true,
          inputPadraoFocus: bairroFocusNode,
          controllerInputPadrao: bairroController,
          campoObrigatorio: true,
          onChange: (bairro){
            validarCamposObrigatorios();
            _preencherCampos();
          },
        ),
        new Divider(height: 1.0,),
        new ZInputGeneric(
          themeData: widget.themeData,
          titulo: "Cidade",
          enabled: true,
          inputPadraoFocus: cidadeFocusNode,
          controllerInputPadrao: cidadeController,
          campoObrigatorio: true,
          onChange: (cidade){
            validarCamposObrigatorios();
            _preencherCampos();
          },
        ),
        new Divider(height: 1.0,),
        new ZInputGeneric(
          themeData: widget.themeData,
          titulo: "Estado",
          enabled: true,
          inputPadraoFocus: estadoFocusNode,
          controllerInputPadrao: estadoController,
          onChange: (estado){
            validarCamposObrigatorios();
            _preencherCampos();
          },
        ),
        new Divider(height: 1.0,),
        _buildMapa()

      ],
    );
  }

  void validarCamposObrigatorios(){
    if(cepController.text.isNotEmpty && cepController.text != null
    && logradouroController.text.isNotEmpty && logradouroController.text != null
    && numeroController.text.isNotEmpty && numeroController.text != null
    && bairroController.text.isNotEmpty && bairroController.text != null
    && cidadeController.text.isNotEmpty && cidadeController.text != null){
      setState(() {
        camposValidados = true;
      });
    }else{
      setState(() {
        camposValidados = false;
      });
    }
  }

  Future<void> _consultaCep (String cep, BuildContext context)async{
    DialogUtils dialogUtils = new DialogUtils(context);
    dialogUtils.showProgressDialog();

    String url = "https://viacep.com.br/ws/${cep}/json/";
    http.Response response;
    response = await http.get(url);
    Map<String, dynamic> retorno = json.decode(response.body);

    if(response.statusCode == 200){
      logradouroController.text = retorno["logradouro"];
      bairroController.text = retorno["bairro"];
      cidadeController.text = retorno["localidade"];
      estadoController.text = retorno["uf"];

      _preencherCampos();

      dialogUtils.dismiss();

      if (retorno["logradouro"] != null &&
          retorno["bairro"] != null &&
          retorno["localidade"] != null &&
          retorno["uf"] != null){

        String montarLocalizacao = logradouroController.text + " " + bairroController.text;
        setState(() {
           _atualizarMapa(montarLocalizacao);
          cepPreenchido = true;
        });
      }else{
        dialogUtils.showAlertDialogNewAviso(
            "CEP Incorreto!", "Por favor, revise seu CEP.");
        dialogUtils.dismiss();
      }
    }else{
      print('Código de Retorno: ' + response.statusCode.toString());
      print('Erro: ' + response.body);
      dialogUtils.dismiss();
    }
  }

  void _preencherCampos(){
    setState(() {
      widget.cepController.text = cepController.text;
      widget.logradouroController.text = logradouroController.text;
      widget.numeroController.text = numeroController.text;
      widget.complementoController.text = complementoController.text;
      widget.bairroController.text = bairroController.text;
      widget.cidadeController.text = cidadeController.text;
      widget.estadoController.text = estadoController.text;
      endereco = logradouroController.text + ", "
          + numeroController.text + ", "
          + complementoController.text + ", "
          + bairroController.text;
    });
  }

  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  _atualizarMapa(String localizacao)async{
    var endereco = await Geocoder.local.findAddressesFromQuery(localizacao);
    var coordenadas = endereco.first;

    setState(() {
      _posicaoCamera = CameraPosition(zoom:19,target: LatLng(coordenadas.coordinates.latitude, coordenadas.coordinates.longitude));
      _marcadores = {};
      Marker marcador = Marker(
          markerId: MarkerId(DateTime.now().toString()),
          position: LatLng(coordenadas.coordinates.latitude, coordenadas.coordinates.longitude),
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
