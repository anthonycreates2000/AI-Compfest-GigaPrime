import 'package:flutter/material.dart';
import 'package:travelling_app/globals/gradient.dart';

class CardTemplate extends StatelessWidget {
  final String title;
  final Widget contentWidget;
  final double height;

  const CardTemplate(
      {Key? key,
        required this.title,
        required this.contentWidget,
        required this.height
      }
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration:
              BoxDecoration(gradient: CustomGradient.getLightBlueToDarkGreen()),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: SizedBox(
                  height: height,
                  width: IntrinsicWidth(
                    child: contentWidget,
                  ).stepWidth,
                  child: contentWidget,
                ),
              ),
            ),
          ],
        )
    );
  }
}
