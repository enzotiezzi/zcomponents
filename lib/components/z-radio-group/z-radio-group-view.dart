import 'package:flutter/src/widgets/framework.dart';
import 'package:z_components/components/z-radio-group/z-radio-group.dart';
import 'package:z_components/components/z-radio-group/z-radio-item.dart';
import 'package:z_components/i-view.dart';

class ZRadioGroupView extends IView<ZRadioGroup>{
  ZRadioGroupView(State<ZRadioGroup> state) : super(state);


  void onChange(int isChecked, ZRadioItem item) {
    if(state.mounted){
      state.widget.itens?.forEach((x) => x.checked = false);

      state.setState((){
        item.checked = isChecked == 1 ? false : true;
      });
    }

    if(state.widget.onChange != null) state.widget.onChange!(item.value!);
  }

  @override
  Future<void> afterBuild() async{
  }

  @override
  Future<void> initView() async{
  }
}