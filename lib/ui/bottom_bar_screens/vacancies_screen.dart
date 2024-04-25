import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solyanka/resources/app_styles.dart';
import 'package:solyanka/ui/bottom_bar_screens/home_screen.dart';
import 'package:solyanka/ui/bottom_bar_screens/main_screen_view_model.dart';

class VacanciesScreen extends StatelessWidget {
  const VacanciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MainScreenViewModel>();
    return PageView(
      controller: model.pageController,
      children: [
        MainVacanciesPage(model: model),
        FavoriteVacanciesPage(model: model),
      ],
    );
  }
}

class MainVacanciesPage extends StatelessWidget {
  const MainVacanciesPage({super.key, required this.model});

  final MainScreenViewModel model;

  @override
  Widget build(BuildContext context) {
    // final model = context.watch<MainScreenViewModel>();
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: model.searchJobController,
              onChanged: (value) async {
                await model.getSearchVacancies(value);
              },
              decoration: const InputDecoration(
                  hintText: 'Search',
                  suffixIcon: Icon(
                    Icons.flutter_dash_outlined,
                    color: AppStyles.mainColor,
                  ),
                  prefixIcon: Icon(Icons.search),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)))),
            ),
          ),
          const SizedBox(height: 20),
          const Text('Swipe left to check favorite'),
          const SizedBox(height: 20),
          model.httpError == ''
              ? Flexible(
                  fit: FlexFit.loose,
                  child: ListView.separated(
                      separatorBuilder: (context, index) => const Divider(
                          height: 40, thickness: 0.4, color: Colors.grey),
                      itemCount: model.vacancies.length,
                      itemBuilder: (context, index) {
                        model.getNextSearchPage(
                            model.searchJobController.text, index);
                        final vacancies = model.vacancies;
                        return vacancies.isEmpty
                            ? const SizedBox.shrink()
                            : VacancyCardWidget(
                                jobName: vacancies[index].vacancy.jobName,
                                companyName:
                                    vacancies[index].vacancy.company.name,
                                region: vacancies[index].vacancy.region.name,
                                salaryMin: vacancies[index].vacancy.salaryMin,
                                salaryMax: vacancies[index].vacancy.salaryMax,
                                currency: vacancies[index].vacancy.currency,
                                employment: vacancies[index].vacancy.employment,
                                schedule: vacancies[index].vacancy.schedule,
                                index: index,
                                id: vacancies[index].vacancy.id,
                              );
                      }),
                )
              : Column(
                  children: [
                    Text(model.httpError),
                    TextButton(
                        onPressed: () => model.getVacancies(),
                        child: const Text('Try again'))
                  ],
                ),
        ],
      ),
    );
  }
}

class FavoriteVacanciesPage extends StatelessWidget {
  const FavoriteVacanciesPage({super.key, required this.model});

  final MainScreenViewModel model;

  @override
  Widget build(BuildContext context) {
    // final model = context.watch<MainScreenViewModel>();
    final vacancies = model.favoriteVacancies;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            "Favorite vacancies",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          vacancies.isEmpty
              ? const Text("You haven't yet add any vacancy to favorite")
              : Expanded(
                  child: ListView.separated(
                      separatorBuilder: (context, index) => const Divider(
                          height: 40, thickness: 0.4, color: Colors.grey),
                      itemCount: vacancies.length,
                      itemBuilder: (context, index) {
                        return VacancyCardWidget(
                          jobName: vacancies[index].vacancy.jobName,
                          companyName: vacancies[index].vacancy.company.name,
                          region: vacancies[index].vacancy.region.name,
                          salaryMin: vacancies[index].vacancy.salaryMin,
                          salaryMax: vacancies[index].vacancy.salaryMax,
                          currency: vacancies[index].vacancy.currency,
                          employment: vacancies[index].vacancy.employment,
                          schedule: vacancies[index].vacancy.schedule,
                          index: index,
                          id: vacancies[index].vacancy.id,
                        );
                      }),
                ),
        ],
      ),
    );
  }
}
