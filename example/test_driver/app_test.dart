// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';


void main() {
  group('Zbaseline Nome', () {
    final baselineNome = find.byValueKey('nomecompleto');
     final baselineEmail = find.byValueKey('email');
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
    // menssagem dia inválido ok
    test('CT01', () async {
      await driver.tap(baselineNome);
    driver.enterText('evaristo soares santos');
    await driver.tap(baselineEmail);
       });
  });

  group('Zbaseline e-mail.', (){
    final baselineEmail = find.byValueKey('email');
    final baselineData = find.byValueKey('data');
     FlutterDriver driver;


      // Start
    setUpAll(
      () async {
        driver = await FlutterDriver.connect();
      },
    );
    // End
tearDownAll(
       () async {
        if (driver != null) {
          driver.close();
        }
      },
    );

    test('CT01', () async {
      await driver.tap(baselineEmail);
    driver.enterText('victorsouzz@gmail.com');
    await driver.tap(baselineData);
       });
  });

  group('Zbaseline Data.', (){
     final baselineData = find.byValueKey('data');
     final baselineCelular = find.byValueKey('celular');
     FlutterDriver driver;

      // Start
    setUpAll(
      () async {
        driver = await FlutterDriver.connect();
      },
    );
    // End
tearDownAll(
       () async {
        if (driver != null) {
          driver.close();
        }
      },
    );

    test('CT01', () async {
      await driver.tap(baselineData);
    driver.enterText('14/02/1996');
    await driver.tap(baselineCelular);
       });
  });

 group('Zbaseline Celular.', (){
     final baselineCelular = find.byValueKey('celular');
     final baselineCep = find.byValueKey('cep');
     FlutterDriver driver;

      // Start
    setUpAll(
      () async {
        driver = await FlutterDriver.connect();
      },
    );
    // End
tearDownAll(
       () async {
        if (driver != null) {
          driver.close();
        }
      },
    );

    test('CT01', () async {
  
    
      await driver.tap(baselineCelular);
     driver.enterText('(11)98470-3336');
     await driver.tap(baselineCep);
  
       });
  });

 group('Zbaseline Cep.', (){
     final baselineCep = find.byValueKey('cep');
     final baselineCnpj = find.byValueKey('cnpj');
     FlutterDriver driver;

      // Start
    setUpAll(
      () async {
        driver = await FlutterDriver.connect();
      },
    );
    // End
tearDownAll(
       () async {
        if (driver != null) {
          driver.close();
        }
      },
    );

    test('CT01', () async {
      await driver.tap(baselineCep);
    driver.enterText('06835-190');
    await driver.tap(baselineCnpj);
       });
  });
group('Zbaseline CNPJ', (){
     final baselineCnpj = find.byValueKey('cnpj');
     final baselineCpf = find.byValueKey('cpf');
     FlutterDriver driver;

      // Start
    setUpAll(  
      () async {
        driver = await FlutterDriver.connect();
      },
    );
    // End
tearDownAll(
       () async {
        if (driver != null) {
          driver.close();
        }
      },
    );

    test('CT01', () async {
      await driver.tap(baselineCnpj);
    driver.enterText('68.418.653/0001-29');
    await driver.tap(baselineCpf);
       });
  });


}