import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solyanka/resources/app_fonts.dart';
import 'package:solyanka/resources/app_images.dart';
import 'package:solyanka/resources/app_styles.dart';
import 'package:solyanka/ui/profile_settings_screens/select_category_view_model.dart';

class SelectCategoryScreen extends StatelessWidget {
  const SelectCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SelectCategoryViewModel>();
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 110),
            child: Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Image(image: AppImages.logoIcon, width: 220),
                    Text(
                      "Select a Job Category",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        fontFamily: AppFonts.basisGrotesquePro,
                        color: Theme.of(context).brightness == Brightness.light
                            ? const Color.fromARGB(255, 64, 64, 64)
                            : const Color.fromARGB(255, 148, 147, 147),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Select whether you're seeking employment opportunities or your organization requires talented individuals.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        fontFamily: AppFonts.basisGrotesquePro,
                        color: Theme.of(context).brightness == Brightness.light
                            ? const Color.fromARGB(255, 64, 64, 64)
                            : const Color.fromARGB(255, 148, 147, 147),
                      ),
                    ),
                    const SizedBox(height: 36),
                    Row(
                      children: [
                        _CategoryWidget(
                          onPressed: () => model.selectJob(),
                          bottomInset: 70,
                          borderWidth: model.isSelectedJob ? 3 : 1,
                          borderColor: model.isSelectedJob
                              ? AppStyles.mainColor
                              : const Color.fromARGB(255, 188, 190, 231),
                          icon: const Icon(
                            Icons.cases_rounded,
                            size: 26,
                            color: AppStyles.mainColor,
                          ),
                          category: 'Find a Job',
                          description: 'I want to find a job',
                        ),
                        const SizedBox(width: 20),
                        _CategoryWidget(
                          onPressed: () => model.selectEmployee(),
                          bottomInset: 23,
                          borderWidth: model.isSelectedJob ? 1 : 3,
                          borderColor: model.isSelectedJob
                              ? const Color.fromARGB(255, 188, 190, 231)
                              : AppStyles.mainColor,
                          icon: const Icon(
                            Icons.person_rounded,
                            size: 26,
                            color: Color.fromARGB(255, 217, 71, 31),
                          ),
                          category: 'Find an Employee',
                          description: 'I want to find employees',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          ContinueButtonWidget(
            onPressed: () => model.goToChooseExpertises(context),
            title: 'Continue',
          ),
        ],
      ),
    );
  }
}

class _CategoryWidget extends StatelessWidget {
  const _CategoryWidget({
    required this.onPressed,
    required this.bottomInset,
    required this.borderWidth,
    required this.borderColor,
    required this.icon,
    required this.category,
    required this.description,
  });

  final void Function() onPressed;
  final double bottomInset;
  final double borderWidth;
  final Color borderColor;
  final Icon icon;
  final String category;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          elevation: const MaterialStatePropertyAll(0),
          padding: MaterialStatePropertyAll(
              EdgeInsets.fromLTRB(10, 40, 10, bottomInset)),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              side: BorderSide(width: borderWidth, color: borderColor),
            ),
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              width: 55,
              height: 55,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 206, 212, 238),
                    shape: BoxShape.circle),
                child: icon,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              category,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: AppFonts.basisGrotesquePro,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).brightness == Brightness.light
                    ? const Color.fromARGB(255, 64, 64, 64)
                    : const Color.fromARGB(255, 148, 147, 147),
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: AppFonts.basisGrotesquePro,
                color: Theme.of(context).brightness == Brightness.light
                    ? const Color.fromARGB(255, 64, 64, 64)
                    : const Color.fromARGB(255, 148, 147, 147),
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContinueButtonWidget extends StatelessWidget {
  const ContinueButtonWidget({
    super.key,
    required this.onPressed,
    required this.title,
  });

  final void Function() onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : Theme.of(context).cardColor,
          border: Border(
              top: BorderSide(
                  width: 1,
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.white
                      : Theme.of(context).cardColor)),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).brightness == Brightness.light
                  ? const Color.fromARGB(255, 197, 195, 195)
                  : const Color.fromARGB(255, 54, 54, 54),
              blurRadius: 8,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ElevatedButton(
            onPressed: onPressed,
            style: AppStyles.firstScreensButtonStyle,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
