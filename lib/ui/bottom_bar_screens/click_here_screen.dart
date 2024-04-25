import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solyanka/resources/app_fonts.dart';
import 'package:solyanka/resources/app_images.dart';
import 'package:solyanka/resources/app_styles.dart';
import 'package:solyanka/ui/bottom_bar_screens/main_screen_view_model.dart';

class ClickHereScreen extends StatefulWidget {
  const ClickHereScreen({super.key, required this.ytPlayer});
  final Widget ytPlayer;

  @override
  State<ClickHereScreen> createState() => _ClickHereScreenState();
}

class _ClickHereScreenState extends State<ClickHereScreen> {
  @override
  Widget build(BuildContext context) {
    final model = context.read<MainScreenViewModel>();
    const textStyle = TextStyle(fontSize: 17);
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 60),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SelectableText.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: 'I know that you want ',
                              style: TextStyle(color: Colors.grey)),
                          TextSpan(
                            text: 'BUT YOU SHOULD NOT',
                            style: TextStyle(
                              color: Colors.red,
                              fontFamily: AppFonts.basisGrotesquePro,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        const Image(image: AppImages.redButton, width: 350),
                        Positioned(
                          bottom: 40,
                          left: 40,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                "DON'T",
                                style:
                                    TextStyle(fontSize: 24, color: Colors.red),
                              ),
                              TextButton(
                                  onPressed: () {
                                    try {
                                      model.crashMyApp();
                                    } catch (e) {
                                      showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) => StatefulBuilder(
                                          builder: (context, setState) =>
                                              AlertDialog(
                                            title: Column(
                                              children: [
                                                const Text(
                                                  'You just crashed my app, thank you :(',
                                                  style: textStyle,
                                                ),
                                                const SizedBox(height: 10),
                                                const Text(
                                                  'Solve this to bring it back to life',
                                                  style: textStyle,
                                                ),
                                                const Stack(
                                                  children: [
                                                    Image(
                                                        image: AppImages.task),
                                                    Positioned(
                                                      bottom: 0,
                                                      right: 2,
                                                      child: Text(
                                                        "I'm joking, skip this task",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    227,
                                                                    227,
                                                                    227)),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                const Text(
                                                  'or this',
                                                  style: textStyle,
                                                ),
                                                const Text(
                                                  'x^2 + 12x + 24 = -12  x =',
                                                  style: textStyle,
                                                ),
                                                const Text(
                                                  'or this at least',
                                                  style: textStyle,
                                                ),
                                                const Text(
                                                  '2 - 2 * 2 - 2 * 2 = ',
                                                  style:
                                                      TextStyle(fontSize: 17),
                                                ),
                                                TextField(
                                                  controller:
                                                      model.mathController,
                                                  onEditingComplete: () =>
                                                      setState(() =>
                                                          model.checkAnswer(
                                                              context)),
                                                  decoration: InputDecoration(
                                                      errorText:
                                                          model.errorText),
                                                ),
                                                TextButton(
                                                  onPressed: () => setState(
                                                      () => model.checkAnswer(
                                                          context)),
                                                  child: const Text(
                                                    'try',
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        color: AppStyles
                                                            .mainColor),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  style: const ButtonStyle(
                                      splashFactory: NoSplash.splashFactory),
                                  child:
                                      const SizedBox(height: 90, width: 100)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                  top: 220,
                  right: 40,
                  child: FittedBox(
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: CustomPaint(
                        painter: MyPainter(),
                      ),
                    ),
                  )),
            ],
          ),
          const SizedBox(height: 200),
          const Text(
            'Yo look at this duuude\n bruh... ',
            style: TextStyle(fontSize: 24),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: widget.ytPlayer,
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Start count from lower point and counterclock-wise
    final firstP1Point = Offset(size.width * 0.7, size.height * 0.9);
    final firstP2Point = Offset(size.width * 0.9, size.height * 0.7);

    final secondP2Point = Offset(size.width * 0.5, size.height * 0.26);

    final thirdP2Point = Offset(size.width * 0.7, size.height * 0.08);

    final fourthP2Point = Offset(size.width * 0.14, size.height * 0.07);

    final sixthP1Point = Offset(size.width * 0.3, size.height * 0.45);
    final sixthP2Point = Offset(size.width * 0.1, size.height * 0.63);

    const gradient = RadialGradient(
      center: Alignment(-0.8, -0.9),
      stops: [0, 1],
      colors: <Color>[
        Color.fromARGB(255, 232, 122, 116),
        Color.fromARGB(255, 125, 13, 5)
      ],
    );

    final paint = Paint();
    paint.strokeWidth = 20;
    paint.strokeCap = StrokeCap.round;
    paint.shader = gradient.createShader(Offset.zero & size);

    canvas.drawLine(firstP1Point, firstP2Point, paint);
    canvas.drawLine(firstP2Point, secondP2Point, paint);
    canvas.drawLine(secondP2Point, thirdP2Point, paint);
    canvas.drawLine(thirdP2Point, fourthP2Point, paint);
    canvas.drawLine(firstP1Point, sixthP1Point, paint);
    canvas.drawLine(fourthP2Point, sixthP2Point, paint);
    canvas.drawLine(sixthP2Point, sixthP1Point, paint);

    canvas.drawLine(
      Offset(size.width * 0.75, size.height * 0.75),
      Offset(size.width * 0.26, size.height * 0.19),
      Paint()
        ..strokeWidth = 40
        ..shader = gradient.createShader(Offset.zero & size)
        ..strokeCap = StrokeCap.round,
    );

    canvas.drawLine(
      Offset(size.width * 0.5, size.height * 0.16),
      Offset(size.width * 0.19, size.height * 0.4),
      Paint()
        ..strokeWidth = 50
        ..shader = gradient.createShader(Offset.zero & size)
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
