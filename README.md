# Z_Components

Z_Components is a package that contains a set of standardized components to facilitate,
optimize, and accelerate the development of Zellar company's Android / IOS applications.

## A small example of how to use:

```dart
import 'package:z_components/components/z_button.dart';
import 'package:z_components/components/z_picker.dart';

          new ZButton(
                zButtonType: ZButtonType.isOutlined,
                onPressed: () {
                  new ZPicker(
                    context: context,
                    initialDate: DateTime.now(),
                    lastDate: DateTime(2090),
                    firstDate: DateTime(1090),
                    onTimerDurationChanged: (date) {
                      date;
                    },
                  );
                },
                text: "Outlined"),
```
