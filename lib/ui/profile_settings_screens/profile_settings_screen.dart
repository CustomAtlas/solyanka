import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:solyanka/resources/app_images.dart';
import 'package:solyanka/resources/app_styles.dart';
import 'package:solyanka/ui/profile_settings_screens/profile_settings_view_model.dart';
import 'package:solyanka/ui/profile_settings_screens/select_category_screen.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final model = context.watch<ProfileSettingsViewModel>();
    const buttonStyle = ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(Colors.transparent),
      elevation: MaterialStatePropertyAll(0),
      splashFactory: NoSplash.splashFactory,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leadingWidth: 25,
        title: const Text(
          'Complete Your Profile',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
            child: Column(
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Stack(
                    children: [
                      DecoratedBox(
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 206, 212, 238),
                            shape: BoxShape.circle),
                        child: SizedBox(
                            height: 100, width: 100, child: model.image),
                      ),
                      Positioned(
                        right: -12,
                        bottom: -12,
                        child: IconButton(
                          onPressed: () => showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              content: SizedBox(
                                width: double.maxFinite,
                                height: 400,
                                child: GridView.count(
                                  crossAxisCount: 2,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () => model.setProfileImage(
                                            'bmo', context),
                                        style: buttonStyle,
                                        child: const SizedBox(
                                          height: 80,
                                          width: 80,
                                          child: Image(image: AppImages.bmo),
                                        )),
                                    ElevatedButton(
                                        onPressed: () => model.setProfileImage(
                                            'finn', context),
                                        style: buttonStyle,
                                        child: const SizedBox(
                                          height: 80,
                                          width: 80,
                                          child: Image(image: AppImages.finn),
                                        )),
                                    ElevatedButton(
                                        onPressed: () => model.setProfileImage(
                                            'jake', context),
                                        style: buttonStyle,
                                        child: const SizedBox(
                                          height: 80,
                                          width: 80,
                                          child: Image(image: AppImages.jake),
                                        )),
                                    ElevatedButton(
                                        onPressed: () => model.setProfileImage(
                                            'marcy', context),
                                        style: buttonStyle,
                                        child: const SizedBox(
                                          height: 80,
                                          width: 80,
                                          child: Image(image: AppImages.marcy),
                                        )),
                                    ElevatedButton(
                                        onPressed: () => model.setProfileImage(
                                            'princess', context),
                                        style: buttonStyle,
                                        child: const SizedBox(
                                          height: 80,
                                          width: 80,
                                          child:
                                              Image(image: AppImages.princess),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          icon: const Icon(Icons.edit_square),
                          color: AppStyles.mainColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  model.fieldsError,
                  style: const TextStyle(fontSize: 16, color: Colors.red),
                ),
                const SizedBox(height: 26),
                Expanded(
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          model.isNameFieldEmpty
                              ? const SizedBox.shrink()
                              : const _MyHelperTextWidget(text: 'Full Name'),
                          _ProfileTextField(
                              controller: model.nameController,
                              keyboardType: null,
                              inputFormatters: null,
                              hintText: 'Full Name',
                              prefixText: null,
                              labelText: null,
                              suffixIcon: null,
                              errorText: null),
                          const SizedBox(height: 36),
                          model.isDateFieldEmpty
                              ? const SizedBox.shrink()
                              : const _MyHelperTextWidget(
                                  text: 'Date of Birth'),
                          _ProfileTextField(
                              controller: model.dateController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                TextInputFormatter.withFunction((oldValue,
                                        newValue) =>
                                    model.dateFormatter(oldValue, newValue)),
                              ],
                              hintText: 'Date of Birth',
                              prefixText: null,
                              labelText: null,
                              suffixIcon: IconButton(
                                  onPressed: () async {
                                    await model.myDatePicker(context);
                                  },
                                  icon: const Icon(Icons.date_range_outlined)),
                              errorText: model.dateErrorText),
                          const SizedBox(height: 36),
                          model.isnumberFieldEmpty
                              ? const SizedBox.shrink()
                              : const _MyHelperTextWidget(text: 'Number'),
                          _ProfileTextField(
                              controller: model.numberController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                TextInputFormatter.withFunction(
                                  (oldValue, newValue) =>
                                      model.numbFormatter(oldValue, newValue),
                                ),
                              ],
                              hintText: '999 000 00 00',
                              prefixText: '+7 ',
                              labelText: '+7',
                              suffixIcon: null,
                              errorText: null),
                          const SizedBox(height: 36),
                          model.gender
                              ? const SizedBox.shrink()
                              : const _MyHelperTextWidget(text: 'Gender'),
                          DropdownMenu<String>(
                            width: MediaQuery.of(context).size.width - 40,
                            inputDecorationTheme: const InputDecorationTheme(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                            ),
                            hintText: 'Gender',
                            dropdownMenuEntries: const [
                              DropdownMenuEntry(value: 'Male', label: 'Male'),
                              DropdownMenuEntry(
                                  value: 'Female', label: 'Female'),
                            ],
                            onSelected: (value) => model.showGender(value),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ContinueButtonWidget(
            onPressed: () => model.goToMainScreen(context),
            title: 'Continue',
          ),
        ],
      ),
    );
  }
}

class _MyHelperTextWidget extends StatelessWidget {
  const _MyHelperTextWidget({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, bottom: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(text),
      ),
    );
  }
}

class _ProfileTextField extends StatelessWidget {
  const _ProfileTextField({
    required this.controller,
    required this.keyboardType,
    required this.inputFormatters,
    required this.hintText,
    required this.prefixText,
    required this.labelText,
    required this.suffixIcon,
    required this.errorText,
  });

  final TextEditingController controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String hintText;
  final String? prefixText;
  final String? labelText;
  final Widget? suffixIcon;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      style: const TextStyle(fontWeight: FontWeight.w500),
      decoration: InputDecoration(
          hintText: hintText,
          prefixText: prefixText,
          labelText: labelText,
          suffixIcon: suffixIcon,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          errorText: errorText,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)))),
    );
  }
}
