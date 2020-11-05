import 'package:flutter/cupertino.dart';
import 'package:z_components/styles/main-style.dart';
import 'package:z_components/components/event/event-manager.dart';
import 'package:z_components_example/event/atualizar-previsto-event.dart';

class MainEvent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainEventState();
}

class _MainEventState extends State<MainEvent> {
  EventManager _eventManager;


  @override
  void initState() {
    _eventManager = new EventManager(
      events: [
        new AtualizarPrevistoEvent("ATUALIZAR_PREVISTO")
      ]
    );

    // informacao vem do servidor
    var type = "ATUALIZAR_PREVISTO";

    _eventManager.runEvent(type);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainStyle.get(context)
        .getDefaultScaffold("Exemplo de eventos", _buildBody());
  }

  Widget _buildBody() {
    return new Container();
  }
}
