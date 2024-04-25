import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solyanka/main_view_model.dart';
import 'package:solyanka/resources/app_fonts.dart';
import 'package:solyanka/resources/app_styles.dart';
import 'package:solyanka/ui/profile_settings_screens/choose_expertises_view_model.dart';
import 'package:solyanka/ui/profile_settings_screens/select_category_screen.dart';

class ChooseExpertisesScreen extends StatelessWidget {
  const ChooseExpertisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ChooseExpertisesViewModel>();
    final mainModel = context.watch<MainViewModel>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leadingWidth: 25,
        title:
            const Text('Back', style: TextStyle(fontWeight: FontWeight.w500)),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Text(
                    "What is your Field of Expertise?",
                    textAlign: TextAlign.center,
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
                    "Please select your field of experise\n(up to 5)",
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
                  Text(
                    model.errorMessage,
                    style: const TextStyle(fontSize: 16, color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  const Expanded(
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _ExpertiseField('IT'),
                            _ExpertiseField('Arts, entertainment, media'),
                            _ExpertiseField('Safety'),
                            _ExpertiseField('Marketing, advertising, PR'),
                            _ExpertiseField('Medicine, pharmaceuticals'),
                            _ExpertiseField('Science, education'),
                            _ExpertiseField('Sales, customer service'),
                            _ExpertiseField('Construction, real estate'),
                            _ExpertiseField('Finance, accounting'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ContinueButtonWidget(
            onPressed: () => mainModel.editExpertises
                ? model.backToProfile(context)
                : model.goToProfileSettings(context),
            title: mainModel.editExpertises ? 'Edit' : 'Continue',
          ),
        ],
      ),
    );
  }
}

class _ExpertiseField extends StatelessWidget {
  final String expertise;
  const _ExpertiseField(this.expertise);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ChooseExpertisesViewModel>();

    bool check = false;

    switch (expertise) {
      case 'IT':
        check = model.it;
      case 'Arts, entertainment, media':
        check = model.arts;
      case 'Safety':
        check = model.safety;
      case 'Marketing, advertising, PR':
        check = model.pr;
      case 'Medicine, pharmaceuticals':
        check = model.med;
      case 'Science, education':
        check = model.sci;
      case 'Sales, customer service':
        check = model.sales;
      case 'Construction, real estate':
        check = model.constr;
      case 'Finance, accounting':
        check = model.fin;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        onPressed: () {
          model.toggleMarked(expertise);
        },
        style: ButtonStyle(
          elevation: const MaterialStatePropertyAll(0),
          padding:
              const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 4)),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              side: BorderSide(
                width: check ? 2 : 1,
                color: check
                    ? AppStyles.mainColor
                    : Theme.of(context).brightness == Brightness.light
                        ? const Color.fromARGB(255, 232, 232, 232)
                        : const Color.fromARGB(255, 41, 40, 40),
              ),
            ),
          ),
        ),
        child: Row(
          children: [
            Checkbox(
              value: check,
              onChanged: (_) {
                model.toggleMarked(expertise);
              },
              activeColor: AppStyles.mainColor,
              side: const BorderSide(color: AppStyles.mainColor),
            ),
            const SizedBox(width: 5),
            Text(
              expertise,
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.grey,
                fontSize: 17,
                fontFamily: AppFonts.basisGrotesquePro,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
