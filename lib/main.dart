import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'widgets/FocusableWidget/focusable_widget.dart';
import 'widgets/Marquee/flutter_marquee.dart';
import 'widgets/Button/button.dart';

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
                nativeWidth: 1920, nativeHeight: 1080, scaleFactor: 1.35),
            type: DeviceType.desktop),
      ],
      categories: [
        WidgetbookCategory(
          name: 'widgets',
          widgets: [
            WidgetbookComponent(name: 'Button', useCases: [
              WidgetbookUseCase(
                name: 'default',
                builder: (context) => Button(
                  backgroundOpacity: context.knobs
                      .options(label: 'backgroundOpacity', options: const [
                    Option(label: 'opaque', value: 'opaque'),
                    Option(label: 'transparent', value: 'transparent'),
                  ]),
                  selected: context.knobs
                      .boolean(label: 'selected', initialValue: false),
                  children: context.knobs
                      .text(label: 'children', initialValue: 'Click me!'),
                  color: context.knobs.text(label: 'color', initialValue: ''),
                  disabled: context.knobs.boolean(label: 'disabled',initialValue: false),
                  icon: context.knobs.text(label: 'icon', initialValue: ''),
                  minWidth: context.knobs.boolean(label: 'minWidth',initialValue: true),
                  size:  context.knobs
                      .options(label: 'size', options: const [
                    Option(label: 'large', value: 'large'),
                    Option(label: 'small', value: 'small'),
                  ]),
                  tooltipText: context.knobs.text(label: 'tooltipText', initialValue: ''),
                  tooltipType: context.knobs.text(label: 'tooltipType', initialValue: ''),
                ),
              ),
            ]),
            WidgetbookComponent(name: 'Focusable Widget', useCases: [
              WidgetbookUseCase(
                name: 'default',
                builder: (context) => FocusableWidget(
                  animaterable: context.knobs
                      .boolean(label: 'animaterable', initialValue: true),
                  backgroundOpacity: context.knobs
                      .options(label: 'backgroundOpacity', options: const [
                    Option(label: 'opaque', value: 'opaque'),
                    Option(label: 'transparent', value: 'transparent'),
                  ]),
                  child: Text(context.knobs.text(
                    label: 'child',
                    initialValue: '',
                  )),
                ),
              ),
            ]),
            WidgetbookComponent(name: 'Flutter Marquee', useCases: [
              WidgetbookUseCase(
                name: 'render marquee',
                builder: (context) => FlutterMarquee(
                  alignment:
                      context.knobs.options(label: 'alignment', options: const [
                    Option(label: 'left', value: 'left'),
                    Option(label: 'center', value: 'center'),
                    Option(label: 'right', value: 'right'),
                  ]),
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  forceDirection: context.knobs
                      .options(label: 'forceDirection', options: const [
                    Option(label: 'ltr', value: 'ltr'),
                    Option(label: 'rlt', value: 'rlt'),
                  ]),
                  marqueeDelay: context.knobs
                      .number(
                        label: 'marqueeDelay',
                        initialValue: 1,
                      )
                      .toInt(),
                  marqueeOn:
                      context.knobs.options(label: 'marqueeOn', options: const [
                    Option(label: 'render', value: 'render'),
                    Option(label: 'hover', value: 'hover'),
                  ]),
                  marqueeSpeed: context.knobs
                      .number(
                        label: 'marqueeSpeed',
                        initialValue: 60,
                      )
                      .toDouble(),
                  children: context.knobs.text(
                    label: 'Children',
                    initialValue:
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                  ),
                  width: 300,
                ),
              ),
              WidgetbookUseCase(
                name: 'hover marquee',
                builder: (context) => FlutterMarquee(
                  alignment:
                      context.knobs.options(label: 'alignment', options: const [
                    Option(label: 'left', value: 'left'),
                    Option(label: 'center', value: 'center'),
                    Option(label: 'right', value: 'right'),
                  ]),
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  forceDirection: context.knobs
                      .options(label: 'forceDirection', options: const [
                    Option(label: 'ltr', value: 'ltr'),
                    Option(label: 'rlt', value: 'rlt'),
                  ]),
                  marqueeDelay: context.knobs
                      .number(
                        label: 'marqueeDelay',
                        initialValue: 1,
                      )
                      .toInt(),
                  marqueeOn:
                      context.knobs.options(label: 'marqueeOn', options: const [
                    Option(label: 'hover', value: 'hover'),
                    Option(label: 'render', value: 'render'),
                  ]),
                  marqueeSpeed: context.knobs
                      .number(
                        label: 'marqueeSpeed',
                        initialValue: 60,
                      )
                      .toDouble(),
                  children: context.knobs.text(
                    label: 'Children',
                    initialValue:
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                  ),
                  width: 300,
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
