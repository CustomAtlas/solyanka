import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:solyanka/main_view_model.dart';
import 'package:solyanka/resources/app_fonts.dart';
import 'package:solyanka/resources/app_images.dart';
import 'package:solyanka/resources/app_styles.dart';
import 'package:solyanka/ui/bottom_bar_screens/main_screen_view_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MainScreenViewModel>();
    final mainModel = context.watch<MainViewModel>();
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Profile Settings',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              fontFamily: AppFonts.basisGrotesquePro,
            ),
          ),
          const Text(
            'Here you can change it',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              fontFamily: AppFonts.basisGrotesquePro,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Theme brightness',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          '(Initially taken from your device)',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    trailing: Switch.adaptive(
                      activeTrackColor: AppStyles.mainColor,
                      value: mainModel.light,
                      onChanged: (bool value) => mainModel.changeTheme(),
                    ),
                  ),
                  const Divider(thickness: 1.2),
                  _SimpleListTile(
                    leadingText: 'Selected job category',
                    trailing: TextButton(
                      onPressed: () => model.changeJobCategory(),
                      child: Text(
                        model.isSelectedJob ? 'Find a job' : 'Find an employee',
                        style: const TextStyle(
                            fontSize: 16, color: AppStyles.mainColor),
                      ),
                    ),
                  ),
                  const Divider(thickness: 1.2),
                  _SimpleListTile(
                    leadingText: 'Fields of expertises',
                    trailing: TextButton(
                      onPressed: () async {
                        await showDialog(
                          context: context,
                          builder: (context) => StatefulBuilder(
                            builder: (context, setState) => AlertDialog(
                              actions: [
                                TextButton(
                                  onPressed: () => setState(() =>
                                      mainModel.toEditExpertises(context)),
                                  child: const Text(
                                    'Change',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: AppStyles.mainColor),
                                  ),
                                )
                              ],
                              content: SizedBox(
                                width: double.maxFinite,
                                height: 200,
                                child: ListView.separated(
                                  itemCount: model.choosedFields.length,
                                  itemBuilder: (context, index) => Text(
                                    '${index + 1}. ${model.choosedFields[index]}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const Divider(thickness: 1.2),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'Click to watch',
                        style:
                            TextStyle(fontSize: 16, color: AppStyles.mainColor),
                      ),
                    ),
                  ),
                  const Divider(thickness: 1.2),
                  _SimpleListTile(
                    leadingText: 'Full Name',
                    trailing: TextButton(
                      onPressed: () async {
                        await showDialog(
                          context: context,
                          builder: (context) => StatefulBuilder(
                            builder: (context, setState) => AlertDialog(
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      setState(() => model.changeName(context)),
                                  child: const Text(
                                    'Change',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: AppStyles.mainColor),
                                  ),
                                )
                              ],
                              content: SizedBox(
                                width: double.maxFinite,
                                height: 100,
                                child: TextField(
                                  controller: model.nameController,
                                  decoration: InputDecoration(
                                      errorText: model.nameError,
                                      border: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppStyles.mainColor),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)))),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      child: Text(
                        model.name,
                        style: const TextStyle(
                            fontSize: 16, color: AppStyles.mainColor),
                      ),
                    ),
                  ),
                  const Divider(thickness: 1.2),
                  _SimpleListTile(
                    leadingText: 'Date of birth',
                    trailing: TextButton(
                      onPressed: () async {
                        await model.myDatePicker(context);
                      },
                      child: Text(
                        model.birth,
                        style: const TextStyle(
                            fontSize: 16, color: AppStyles.mainColor),
                      ),
                    ),
                  ),
                  const Divider(thickness: 1.2),
                  _SimpleListTile(
                    leadingText: 'Email',
                    trailing: TextButton(
                      onPressed: () async {
                        await showDialog(
                          context: context,
                          builder: (context) => StatefulBuilder(
                            builder: (context, setState) => AlertDialog(
                              actions: [
                                TextButton(
                                  onPressed: () => setState(
                                      () => model.changeEmail(context)),
                                  child: const Text(
                                    'Change',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: AppStyles.mainColor),
                                  ),
                                )
                              ],
                              content: SizedBox(
                                width: double.maxFinite,
                                height: 100,
                                child: TextField(
                                  controller: model.emailController,
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                  decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 15),
                                      errorText: model.emailError,
                                      border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)))),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      child: Text(
                        model.email,
                        style: const TextStyle(
                            fontSize: 16, color: AppStyles.mainColor),
                      ),
                    ),
                  ),
                  const Divider(thickness: 1.2),
                  _SimpleListTile(
                    leadingText: 'Number',
                    trailing: TextButton(
                      onPressed: () async {
                        await showDialog(
                          context: context,
                          builder: (context) => StatefulBuilder(
                            builder: (context, setState) => AlertDialog(
                              actions: [
                                TextButton(
                                  onPressed: () => setState(
                                      () => model.changeNumber(context)),
                                  child: const Text(
                                    'Change',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: AppStyles.mainColor),
                                  ),
                                )
                              ],
                              content: SizedBox(
                                width: double.maxFinite,
                                height: 100,
                                child: TextField(
                                  controller: model.numberController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    TextInputFormatter.withFunction(
                                      (oldValue, newValue) => model
                                          .numbFormatter(oldValue, newValue),
                                    ),
                                  ],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                  decoration: InputDecoration(
                                      prefixText: '+7 ',
                                      labelText: '+7',
                                      hintText: '999 000 00 00',
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 15),
                                      errorText: model.numberError,
                                      border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)))),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      child: Text(
                        '+7 ${model.number}',
                        style: const TextStyle(
                            fontSize: 16, color: AppStyles.mainColor),
                      ),
                    ),
                  ),
                  const Divider(thickness: 1.2),
                  _SimpleListTile(
                    leadingText: 'Gender',
                    trailing: TextButton(
                      onPressed: () => model.changeGender(),
                      child: Text(
                        model.gender,
                        style: const TextStyle(
                            fontSize: 16, color: AppStyles.mainColor),
                      ),
                    ),
                  ),
                  const Divider(thickness: 1.2),
                  _SimpleListTile(
                    leadingText: 'Profile image',
                    trailing: TextButton(
                        onPressed: () => showDialog(
                            context: context,
                            builder: (context) {
                              const buttonStyle = ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Colors.transparent),
                                elevation: MaterialStatePropertyAll(0),
                                splashFactory: NoSplash.splashFactory,
                              );
                              return AlertDialog(
                                content: SizedBox(
                                  width: double.maxFinite,
                                  height: 400,
                                  child: GridView.count(
                                    crossAxisCount: 2,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () => model
                                              .setProfileImage('bmo', context),
                                          style: buttonStyle,
                                          child: const SizedBox(
                                            height: 80,
                                            width: 80,
                                            child: Image(image: AppImages.bmo),
                                          )),
                                      ElevatedButton(
                                          onPressed: () => model
                                              .setProfileImage('finn', context),
                                          style: buttonStyle,
                                          child: const SizedBox(
                                            height: 80,
                                            width: 80,
                                            child: Image(image: AppImages.finn),
                                          )),
                                      ElevatedButton(
                                          onPressed: () => model
                                              .setProfileImage('jake', context),
                                          style: buttonStyle,
                                          child: const SizedBox(
                                            height: 80,
                                            width: 80,
                                            child: Image(image: AppImages.jake),
                                          )),
                                      ElevatedButton(
                                          onPressed: () =>
                                              model.setProfileImage(
                                                  'marcy', context),
                                          style: buttonStyle,
                                          child: const SizedBox(
                                            height: 80,
                                            width: 80,
                                            child:
                                                Image(image: AppImages.marcy),
                                          )),
                                      ElevatedButton(
                                          onPressed: () =>
                                              model.setProfileImage(
                                                  'princess', context),
                                          style: buttonStyle,
                                          child: const SizedBox(
                                            height: 80,
                                            width: 80,
                                            child: Image(
                                                image: AppImages.princess),
                                          )),
                                    ],
                                  ),
                                ),
                              );
                            }),
                        style: const ButtonStyle(
                            splashFactory: NoSplash.splashFactory),
                        child: SizedBox(
                            height: 60, width: 60, child: model.image)),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: TextButton(
                      onPressed: () => model.goToHelpChat(context),
                      child: const Text(
                        'Help Chat',
                        style:
                            TextStyle(fontSize: 16, color: AppStyles.mainColor),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => model.signOut(context),
                    child: const Text(
                      'Sign Out',
                      style: TextStyle(color: Colors.red, fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SimpleListTile extends StatelessWidget {
  const _SimpleListTile({
    required this.leadingText,
    required this.trailing,
  });

  final String leadingText;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Text(
        leadingText,
        style: const TextStyle(fontSize: 16),
      ),
      trailing: trailing,
    );
  }
}
