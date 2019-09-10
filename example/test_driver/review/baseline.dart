// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Zbaseline testes - CT01', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.
    /*   final counterTextFinder = find.byValueKey('counter');
    final buttonFinder = find.byValueKey('increment');*/
    final baselineNome = find.byValueKey('nomekey');
    final baselineCnpj = find.byValueKey('cnpjkey');
    final baselineCpf = find.byValueKey('cpfkey');
    final baselineEmail = find.byValueKey('emailkey');
    final baselineCel = find.byValueKey('celularkey');
    final baselineNascimento = find.byValueKey('datanascimentokey');
    final baselineCep = find.byValueKey('cepkey');
    final tapdialog = find.byValueKey('tapdialog');
    final titledialog = find.byValueKey('titledialog');
    final messagedialog = find.byValueKey('messagedialog');
    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(
          () async {
        driver = await FlutterDriver.connect();
      },
    );

    // Close the connection to the driver after the tests have completed.
    tearDownAll(
          () async {
        if (driver != null) {
          driver.close();
        }
      },
    );

    //first we put an incomplete name
    /* test(
      'zbaseline nome incompleto',
      () async {
        await driver.tap(baselineNome);

        driver.enterText('vi');
        driver.tap(baselineCnpj);
        driver.tap(titledialog);
        String texto = await driver.getText(titledialog);
        if (texto == "Nome Inválido!") {
          Skip:
          true;
        }
        //expect(await driver.getText(titledialog), "Nome Inválido!");

        print(texto);
      },
    );*/

//valida cnpj - campo apresentando excessão
    /* test('zbaseline cnpj incompleto', () async {
      driver.tap(baselineCnpj);
     // await driver.enterText('47.556.805/0001-80');

      //driver.tap(titledialog);
    });*/

// valida cpf
    /*   test('zbaseline cpf incompleto', () async {
      await driver.tap(baselineCpf);

      driver.enterText('3991088487');
      await driver.tap(baselineCel);
      driver.tap(titledialog);
      String texto = await driver.getText(titledialog);
      print(texto);
    });*/

// valida email
    /*test('zbaseline email sem "@"', () async {
      await driver.tap(baselineEmail);
      driver.enterText('victorsouzzgmail.com');
      await driver.tap(baselineCel);
      expect(await driver.getText(titledialog), "E-mail Inválido!");
    });
*/
    //valida celular
    /* test('zbaseline celular', () async {
      await driver.tap(baselineCel);

      driver.enterText('(11)9847036');
      await driver.tap(baselineCep);
      expect(await driver.getText(titledialog), "Celular Inválido!");


    });*/

    // valida cep sem validação
    /* test('zbaseline cep', () async {
      await driver.tap(baselineCep);
      driver.enterText('000');
      await driver.tap(baselineNascimento);
      expect(await driver.getText(titledialog), "Celular Inválido!");
    });
*/
    // valida data de nascimento

    /* test('zbaseline data de nascimento Incorreta Padrão', () async {
      await driver.tap(baselineNascimento);

      driver.enterText('14/02/199');
      await driver.tap(baselineCep);
      expect(await driver.getText(titledialog), "Data Inválida!");
      expect(await driver.getText(messagedialog), "Por Favor, termine de digitar sua data de nascimento");
    });*/

    //data invalida ano 1901
    /* test('zbaseline data de nascimento Incorreta ano não permitido', () async {
      await driver.tap(baselineNascimento);

      driver.enterText('14/02/1900');

      expect(await driver.getText(titledialog), "Ano Inválido!");
      expect(await driver.getText(messagedialog),
          "Insira um valor de ano entre 1901 e 2004.");


    });*/

    //data invalida ano 2004 -  Menssagem Resposta não condiz com menssagem esperada
    /*  test('zbaseline data de nascimento Incorreta ano não permitido', () async {
      await driver.tap(baselineNascimento);

      driver.enterText('14/02/2004');

      expect(await driver.getText(titledialog), "Ano Inválido!");
      expect(await driver.getText(messagedialog),
          "Insira um valor de ano entre 1901 e 2004.");
    });*/

    //data invalida mês inválido - 13
    /*test('zbaseline data de nascimento Incorreta mês  não existe', () async {
      await driver.tap(baselineNascimento);

      driver.enterText('14/13/1996');

      expect(await driver.getText(titledialog), "Mês Inválido!");
      expect(await driver.getText(messagedialog),"Insira um valor de mês entre 01 e 12.");
    });*/


    //data invalida mês inválido - 00 (retorno de menssagem inválida, menssagem exibida é referente a data em geral)
    /*test('zbaseline data de nascimento Incorreta mês  não existe', () async {
      await driver.tap(baselineNascimento);

      driver.enterText('14/00/1996');

      expect(await driver.getText(titledialog), "Mês Inválido!");
      expect(await driver.getText(messagedialog),"Insira um valor de mês entre 01 e 12.");
    });*/

    //data invalida dia inválido - 00 (embora o dia esteja inválido a resposta é generalizada para a data)
    /* test('zbaseline data de nascimento Incorreta dia não existe', () async {
      await driver.tap(baselineNascimento);

      driver.enterText('00/01/1996');

      expect(await driver.getText(titledialog), "Dia Inválido!");
      //expect(await driver.getText(messagedialog),"Insira um valor de mês entre 01 e 12.");
    });*/

    //data invalida dia inválido - 32 (embora o dia esteja inválido a resposta é generalizada para a data)
    /*test('zbaseline data de nascimento Incorreta dia não existe', () async {
      await driver.tap(baselineNascimento);

      driver.enterText('32/01/1996');

      expect(await driver.getText(titledialog), "Dia Inválido!");
      //expect(await driver.getText(messagedialog),"Insira um valor de mês entre 01 e 12.");
    });*/

    // menssagem dia inválido ok
    /*test('zbaseline data de nascimento Incorreta dia não existe - ano não bissexto', () async {
      await driver.tap(baselineNascimento);

      driver.enterText('29/02/1997');

      expect(await driver.getText(titledialog), "Dia Inválido!");
      expect(await driver.getText(messagedialog),"Insira um valor de dia entre 01 e 28.");
    });*/

    test('zbaseline data de nascimento Incorreta dia não existe - ano bissexto', () async {
      await driver.tap(baselineNascimento);

      driver.enterText('30/02/1996');

      expect(await driver.getText(titledialog), "Dia Inválido!");
      expect(await driver.getText(messagedialog),"Insira um valor de dia entre 01 e 29.");

      await driver.tap(tapdialog);
    });

  });


  group('Zbaseline testes', () {
    final baselineNome = find.byValueKey('nomekey');
    final baselineCnpj = find.byValueKey('cnpjkey');
    final baselineCpf = find.byValueKey('cpfkey');
    final baselineEmail = find.byValueKey('emailkey');
    final baselineCel = find.byValueKey('celularkey');
    final baselineNascimento = find.byValueKey('datanascimentokey');
    final baselineCep = find.byValueKey('cepkey');
    final tapdialog = find.byValueKey('tapdialog');
    final titledialog = find.byValueKey('dialog_title');
    final messagedialog = find.byValueKey('dialog_message');

    FlutterDriver driver;

    // menssagem dia inválido ok
    /*test('zbaseline data de nascimento Incorreta dia não existe - ano não bissexto', () async {
      await driver.tap(baselineNascimento);

      driver.enterText('29/02/1997');

      expect(await driver.getText(titledialog), "Dia Inválido!");
      expect(await driver.getText(messagedialog),"Insira um valor de dia entre 01 e 28.");
    });*/



  });
}
