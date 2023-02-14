import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'widgets/FocusableWidget/focusable_widget.dart';

void main() {
  runApp(const HotreloadWidgetbook());
}

class HotreloadWidgetbook extends StatelessWidget {
  const HotreloadWidgetbook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      devices: [
        Device(
            name: 'webOS TV',
            resolution: Resolution.dimensions(
                nativeWidth: 1920, nativeHeight: 1080, scaleFactor: 1.75),
            type: DeviceType.desktop),
      ],
      categories: [
        WidgetbookCategory(
          name: 'widgets',
          widgets: [
            WidgetbookComponent(name: 'Button', useCases: [
              WidgetbookUseCase(
                name: 'example',
                builder: (context) => ElevatedButton(
                  onPressed: () {},
                  child: Text(context.knobs.text(
                    label: 'Children',
                    initialValue: 'Example Button',
                  )),
                ),
              ),
            ]),
            WidgetbookComponent(name: 'Focusable Widget', useCases: [
              WidgetbookUseCase(
                name: 'default',
                builder: (context) => FocusableWidget(
                  animaterable: context.knobs.boolean(
                    label: 'animaterable',
                    initialValue: true
                    ),
                  backgroundOpacity: context.knobs.options(
                    label: 'backgroundOpacity',
                    options: const [
                      Option(label: 'opaque', value: 'opaque'),
                      Option(label: 'transparent', value: 'transparent'),
                    ]),
                  child: Text(context.knobs.text(
                    label: 'child',
                    initialValue: '',
                  )),
                ),
              ),
            ])
          ],
        )
      ],
      themes: [
        WidgetbookTheme(
          name: 'Dark',
          data: ThemeData.dark(),
        ),
      ],
      appInfo: AppInfo(name: 'Flutter Framework'),
    );
  }
}
