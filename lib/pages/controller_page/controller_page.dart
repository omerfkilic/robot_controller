import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class ControllerPage extends StatefulWidget {
  const ControllerPage({super.key});

  @override
  State<ControllerPage> createState() => _ControllerPageState();
}

class _ControllerPageState extends State<ControllerPage> {
  String text = 'Waiting Command';
  int rotationAngleFactor = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.blue,
            Colors.red,
          ],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
          leading: IconButton(
            onPressed: () {
              //TODO: implement logout function
            },
            icon: const Icon(
              Icons.logout,
            ),
          ),
          actions: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Robot Info'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const <Widget>[
                                Text('Tarantula Robot'),
                                Text('Version 1.0'),
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Done'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.info_outline,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            Transform.rotate(
              angle: pi * (rotationAngleFactor / 2),
              child: Image.asset(
                'assets/icons/SpiderIcon.png',
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Container(
                height: 250,
                width: 250,
                padding: const EdgeInsets.all(2),
                child: Stack(
                  children: [
                    _ControllerButton(
                      alignment: Alignment.centerLeft,
                      iconData: Icons.keyboard_arrow_left_outlined,
                      onTapDownEvent: () async {
                        setState(() {
                          rotationAngleFactor = 3;
                          text = 'Moving Left';
                        });
                      },
                      onTapUpEvent: () {
                        setState(() {
                          rotationAngleFactor = 0;
                          text = 'Waiting Command';
                        });
                      },
                    ),
                    _ControllerButton(
                      alignment: Alignment.centerRight,
                      iconData: Icons.keyboard_arrow_right_outlined,
                      onTapDownEvent: () {
                        setState(() {
                          rotationAngleFactor = 1;
                          text = 'Moving Right';
                        });
                      },
                      onTapUpEvent: () {
                        setState(() {
                          rotationAngleFactor = 0;
                          text = 'Waiting Command';
                        });
                      },
                    ),
                    _ControllerButton(
                      alignment: Alignment.topCenter,
                      iconData: Icons.keyboard_arrow_up_outlined,
                      onTapDownEvent: () {
                        setState(() {
                          rotationAngleFactor = 4;
                          text = 'Moving Forward';
                        });
                      },
                      onTapUpEvent: () {
                        setState(() {
                          rotationAngleFactor = 0;
                          text = 'Waiting Command';
                        });
                      },
                    ),
                    _ControllerButton(
                      alignment: Alignment.bottomCenter,
                      iconData: Icons.keyboard_arrow_down_outlined,
                      onTapDownEvent: () {
                        setState(() {
                          rotationAngleFactor = 2;
                          text = 'Moving Backward';
                        });
                      },
                      onTapUpEvent: () {
                        setState(() {
                          rotationAngleFactor = 0;
                          text = 'Waiting Command';
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ControllerButton extends StatelessWidget {
  final AlignmentGeometry alignment;
  final IconData iconData;
  final void Function() onTapDownEvent;
  final void Function() onTapUpEvent;

  const _ControllerButton({
    required this.alignment,
    required this.onTapDownEvent,
    required this.onTapUpEvent,
    required this.iconData,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Ink(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(120),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(120),
          splashColor: Colors.red,
          onTapUp: (details) {
            onTapUpEvent();
          },
          onTapDown: (details) {
            Vibrate.feedback(FeedbackType.heavy);
            onTapDownEvent();
          },
          onTapCancel: () {
            onTapUpEvent();
          },
          child: Icon(
            iconData,
            size: 75,
          ),
        ),
      ),
    );
  }
}
