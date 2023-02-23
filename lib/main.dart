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
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(16),
                  child:Button(
                        backgroundOpacity: context.knobs
                            .options(label: 'backgroundOpacity', options: const [
                          Option(label: 'opaque', value: 'opaque'),
                          Option(label: 'transparent', value: 'transparent'),
                        ]),
                        selected: context.knobs
                            .boolean(label: 'selected', initialValue: false),
                        children: context.knobs
                            .text(label: 'children', initialValue: 'click me'),
                        color: context.knobs.text(label: 'color', initialValue: ''),
                        disabled: context.knobs.boolean(label: 'disabled',initialValue: false),
                        icon: context.knobs
                          .options(label: 'icon', options: const [
                            Option(label: 'undefined', value: null),
                            Option(label: 'add', value: Icons.add),
                            Option(label: 'search', value: Icons.search),
                            Option(label: 'home', value: Icons.home),
                            Option(label: 'Done', value: Icons.done),
                            Option(label: 'radio unchecked', value: Icons.radio_button_unchecked),
                            Option(label: 'radio checked', value: Icons.check_circle_outline_rounded),
                          ]),
                        minWidth: context.knobs.boolean(label: 'minWidth',initialValue: true),
                        size:  context.knobs
                            .options(label: 'size', options: const [
                          Option(label: 'large', value: 'large'),
                          Option(label: 'small', value: 'small'),
                        ]),
                        tooltipText: context.knobs.text(label: 'tooltipText', initialValue: ''),
                        tooltipType: context.knobs
                            .options(label: 'tooltipType', options: const [
                          Option(label: 'transparent', value: 'transparent'),
                          Option(label: 'ballon', value: 'ballon'),
                        ]),
                      ),
                  ),
              ),
              WidgetbookUseCase(
                name: 'Icon Button',
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(16),
                  child:Button(
                        backgroundOpacity: context.knobs
                            .options(label: 'backgroundOpacity', options: const [
                          Option(label: 'transparent', value: 'transparent'),
                          Option(label: 'opaque', value: 'opaque'),
                        ]),
                        selected: context.knobs
                            .boolean(label: 'selected', initialValue: false),
                        children: context.knobs
                            .text(label: 'children', initialValue: ''),
                        color: context.knobs.text(label: 'color', initialValue: ''),
                        disabled: context.knobs.boolean(label: 'disabled',initialValue: false),
                        icon: context.knobs
                          .options(label: 'icon', options: const [
                            Option(label: 'home', value: Icons.home),
                            Option(label: 'undefined', value: null),
                            Option(label: 'add', value: Icons.add),
                            Option(label: 'search', value: Icons.search),
                            Option(label: 'Done', value: Icons.done),
                            Option(label: 'radio unchecked', value: Icons.radio_button_unchecked),
                            Option(label: 'radio checked', value: Icons.check_circle_outline_rounded),
                          ]),
                        minWidth: context.knobs.boolean(label: 'minWidth',initialValue: false),
                        size:  context.knobs
                            .options(label: 'size', options: const [
                          Option(label: 'large', value: 'large'),
                          Option(label: 'small', value: 'small'),
                        ]),
                        tooltipText: context.knobs.text(label: 'tooltipText', initialValue: ''),
                        tooltipType: context.knobs
                            .options(label: 'tooltipType', options: const [
                          Option(label: 'transparent', value: 'transparent'),
                          Option(label: 'ballon', value: 'ballon'),
                        ]),
                      ),
                  ),
              ),
              WidgetbookUseCase(
                name: 'Many Button',
                builder: (context) => Row(
                  children: [
                    Column(
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(16),
                          child:Button(
                            children: 'click me',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child:Button(
                            children: 'click me',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child:Button(
                            children: 'click me',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child:Button(
                            children: 'click me',
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(16),
                          child:Button(
                            children: 'click me',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child:Button(
                            children: 'click me',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child:Button(
                            children: 'click me',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child:Button(
                            children: 'click me',
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(16),
                          child:Button(
                            children: 'click me',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child:Button(
                            children: 'click me',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child:Button(
                            children: 'click me',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child:Button(
                            children: 'click me',
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(16),
                          child:Button(
                            children: 'click me',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child:Button(
                            children: 'click me',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child:Button(
                            children: 'click me',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child:Button(
                            children: 'click me',
                          ),
                        ),
                      ],
                    ),
                  ],
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
            ]),
            WidgetbookComponent(name: 'Icon', useCases: [
              WidgetbookUseCase(
                name: 'default',
                builder: (context) => const Icon(
                    Icons.add,
                  )
                ),
            ]),
          ],
        )
      ],
      themes: [
        WidgetbookTheme(
          name: 'Dark',
          data: ThemeData(canvasColor: Colors.black),
        ),
      ],
      appInfo: AppInfo(name: 'Flutter Framework'),
    );
  }
}
