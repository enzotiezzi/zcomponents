# Z_Components

Z_Components is a package composed by a series of components whose goal is to facilitate, optimize and accelerate the development of
iOS and Android applications by Zellar.

These components are based on the company's internal StyleGuide, which was created from Cupertino and Material Design principles, in
the intent to match them with Zellar's visual identity.

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
