import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solyanka/resources/app_fonts.dart';
import 'package:solyanka/resources/app_images.dart';
import 'package:solyanka/resources/app_styles.dart';
import 'package:solyanka/ui/bottom_bar_screens/home_job_cubit/job_cubit.dart';
import 'package:solyanka/ui/bottom_bar_screens/main_screen_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MainScreenViewModel>();
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: _SliverPinnedSearch(),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: model.searchController.text.trim().isNotEmpty
                ? BlocBuilder<JobCubit, JobState>(
                    builder: (context, state) {
                      final cubit = context.watch<JobCubit>();

                      return RefreshIndicator(
                          onRefresh: () async {
                            final completer = Completer();
                            await cubit.getSearchVacancies(
                                completer, model.searchController.text);
                            return await completer.future;
                          },
                          child: state is JobStateLoading
                              ? const Padding(
                                  padding: EdgeInsets.only(top: 40),
                                  child: Center(
                                    child: SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                )
                              : state is JobStateLoadingFailure
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Center(
                                          child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text(
                                              'Something went wrong or no results for query'),
                                          TextButton(
                                              onPressed: () async {
                                                final completer = Completer();
                                                await cubit.getSearchVacancies(
                                                    completer,
                                                    model
                                                        .searchController.text);
                                                return await completer.future;
                                              },
                                              child: const Text('Try again'))
                                        ],
                                      )),
                                    )
                                  : ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxHeight:
                                            MediaQuery.of(context).size.height -
                                                220,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20),
                                        child: ListView.separated(
                                            separatorBuilder:
                                                (context, index) =>
                                                    const Divider(
                                                        height: 40,
                                                        thickness: 0.4,
                                                        color: Colors.grey),
                                            itemCount: cubit.vacancies.length,
                                            itemBuilder: (context, index) {
                                              final vacancies = cubit.vacancies;
                                              model.vacancies.addAll(vacancies);
                                              return vacancies.isEmpty
                                                  ? const SizedBox.shrink()
                                                  : VacancyCardWidget(
                                                      jobName: vacancies[index]
                                                          .vacancy
                                                          .jobName,
                                                      companyName:
                                                          vacancies[index]
                                                              .vacancy
                                                              .company
                                                              .name,
                                                      region: vacancies[index]
                                                          .vacancy
                                                          .region
                                                          .name,
                                                      salaryMin:
                                                          vacancies[index]
                                                              .vacancy
                                                              .salaryMin,
                                                      salaryMax:
                                                          vacancies[index]
                                                              .vacancy
                                                              .salaryMax,
                                                      currency: vacancies[index]
                                                          .vacancy
                                                          .currency,
                                                      employment:
                                                          vacancies[index]
                                                              .vacancy
                                                              .employment,
                                                      schedule: vacancies[index]
                                                          .vacancy
                                                          .schedule,
                                                      index: index,
                                                      id: vacancies[index]
                                                          .vacancy
                                                          .id,
                                                    );
                                            }),
                                      ),
                                    ));
                    },
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 20),
                      const _PosterWidget(),
                      const SizedBox(height: 36),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Recommendations',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          TextButton(
                            onPressed: () => model.openVacanciesPage(),
                            style: const ButtonStyle(
                                padding:
                                    MaterialStatePropertyAll(EdgeInsets.zero)),
                            child: const Text(
                              'See All',
                              style: TextStyle(
                                  color: AppStyles.mainColor, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      const Divider(thickness: 0.4, color: Colors.grey),
                      const SizedBox(height: 20),
                      model.vacancies.isEmpty
                          ? const SizedBox.shrink()
                          : VacancyCardWidget(
                              jobName: model.vacancies[0].vacancy.jobName,
                              companyName:
                                  model.vacancies[0].vacancy.company.name,
                              region: model.vacancies[0].vacancy.region.name,
                              salaryMin: model.vacancies[0].vacancy.salaryMin,
                              salaryMax: model.vacancies[0].vacancy.salaryMax,
                              currency: model.vacancies[0].vacancy.currency,
                              employment: model.vacancies[0].vacancy.employment,
                              schedule: model.vacancies[0].vacancy.schedule,
                              index: 0,
                              id: model.vacancies[0].vacancy.id,
                            )
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class _PosterWidget extends StatelessWidget {
  const _PosterWidget();

  @override
  Widget build(BuildContext context) {
    final model = context.read<MainScreenViewModel>();
    return SizedBox(
      height: 170,
      width: double.infinity,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AppImages.decor,
            colorFilter: ColorFilter.mode(
              AppStyles.mainColor,
              BlendMode.colorDodge,
            ),
          ),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Stack(
            children: [
              const Positioned(
                right: 0,
                bottom: 14,
                child: Image(
                  image: AppImages.myCase,
                  width: 130,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Explore how you can secure\nemployment swiftly!',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontFamily: AppFonts.basisGrotesquePro,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                      onPressed: () => model.explore(),
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.white),
                          padding: MaterialStatePropertyAll(
                              EdgeInsets.symmetric(horizontal: 20)),
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                          )),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Explore',
                            style: TextStyle(
                              color: AppStyles.mainColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.double_arrow_rounded,
                            size: 18,
                            color: AppStyles.mainColor,
                          )
                        ],
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VacancyCardWidget extends StatelessWidget {
  const VacancyCardWidget({
    super.key,
    required this.jobName,
    required this.companyName,
    required this.region,
    required this.salaryMin,
    required this.salaryMax,
    required this.currency,
    required this.employment,
    required this.schedule,
    required this.index,
    required this.id,
  });

  final String jobName;
  final String companyName;
  final String region;
  final int salaryMin;
  final int salaryMax;
  final String currency;
  final String employment;
  final String schedule;
  final int index;
  final String id;

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MainScreenViewModel>();
    return DecoratedBox(
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(12)),
                  child: const Padding(
                    padding: EdgeInsets.all(14),
                    child: Image(image: AppImages.googleIcon, width: 24),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 200,
                        child: Text(
                          jobName,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppStyles.mainColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                          width: 200,
                          child: Text(companyName,
                              overflow: TextOverflow.ellipsis)),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () => model.saveVacancy(id),
                    icon: Icon(
                      model.favoriteVacancies.contains(model.vacancies[index])
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      color: AppStyles.mainColor,
                      size: 28,
                    )),
              ],
            ),
            const Divider(thickness: 0.4, height: 40, color: Colors.grey),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(region == '' ? 'Регион не указан' : region,
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 5),
                Text(
                  salaryMin == 0
                      ? 'Зарпалата не указанa'
                      : '$salaryMin - $salaryMax ${currency.substring(1, 5)}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppStyles.mainColor,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(employment,
                                style: const TextStyle(fontSize: 12)),
                          ),
                        ),
                        const SizedBox(height: 10),
                        DecoratedBox(
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(schedule,
                                style: const TextStyle(fontSize: 12)),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    ElevatedButton(
                        onPressed: () => model.goToVacancyInfo(context, index),
                        style: const ButtonStyle(
                            padding:
                                MaterialStatePropertyAll(EdgeInsets.all(8)),
                            side: MaterialStatePropertyAll(
                              BorderSide(
                                color: AppStyles.mainColor,
                              ),
                            ),
                            foregroundColor: MaterialStatePropertyAll(
                              AppStyles.mainColor,
                            ),
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                            )),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Read More', style: TextStyle(fontSize: 12)),
                            SizedBox(width: 5),
                            Icon(
                              Icons.double_arrow_rounded,
                              size: 11,
                            )
                          ],
                        ))
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SliverPinnedSearch extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final model = context.read<MainScreenViewModel>();
    final cubit = context.watch<JobCubit>();
    return Stack(
      children: [
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 20,
              child: ColoredBox(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.white
                    : Theme.of(context).cardColor,
              ),
            )),
        DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: model.searchController,
            onChanged: (value) async {
              final completer = Completer();
              cubit.getSearchVacancies(completer, value);
              return await completer.future;
            },
            decoration: const InputDecoration(
                hintText: 'Search',
                suffixIcon: Icon(
                  Icons.flutter_dash_outlined,
                  color: Color.fromARGB(255, 81, 109, 230),
                ),
                prefixIcon: Icon(Icons.search),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)))),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => 54;

  @override
  double get minExtent => 54;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
