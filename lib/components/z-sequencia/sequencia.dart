import 'package:meta/meta.dart';

class Sequencia {
  final String primeiroDiaEscala;
  final String escala;

  Sequencia({@required this.escala, @required this.primeiroDiaEscala});

  String calcularSeDiaTouF(DateTime date) {
    var escalaNormalizada = _normalizarEscala(escala);

    var quantidadeDeDiasNaEmpresa =
        _calcularDiasNaEmpresa(primeiroDiaEscala, date);

    var quantidadeDeDiasNaEscala = _calcularDiasNaEscala(escalaNormalizada);

    var diaAtualNaEscala =
        _mod(quantidadeDeDiasNaEmpresa, quantidadeDeDiasNaEscala);

    var vetorTouF = _montarVetorTouF(escalaNormalizada);

    return vetorTouF[diaAtualNaEscala];
  }

  String _normalizarEscala(String escala) {
    var escalaNormalizada = escala;

    if (escalaNormalizada.toLowerCase() == "12x36") escalaNormalizada = "1x1";

    return escalaNormalizada;
  }

  int _calcularDiasNaEmpresa(String primeiroDiaEscala, DateTime date) {
    var dataPrimeiroDiaEscala = DateTime.parse(primeiroDiaEscala);

    return date.difference(dataPrimeiroDiaEscala).inDays;
  }

  int _calcularDiasNaEscala(String escala) {
    if (escala.contains('x')) {
      var diasNaEscala = 0;

      escala.split('x').forEach((x) => diasNaEscala += int.parse(x));

      return diasNaEscala;
    }

    return -1;
  }

  int _mod(int a, int b) {
    return (a - (a / b).floor() * b);
  }

  List<String> _montarVetorTouF(String escala) {
    var vetorTouF = new List<String>();

    var escalaFracionada = escala.split('x');

    for (var i = 0; i < escalaFracionada.length; i++) {
      var quantidadeDias = int.parse(escalaFracionada[i]);

      for (var y = 0; y < quantidadeDias; y++) {
        if (i % 2 == 0) {
          vetorTouF.add("T");
        } else {
          vetorTouF.add("F");
        }
      }
    }

    return vetorTouF;
  }
}
