import 'package:flutter/material.dart';
import 'package:solyanka/domain/entities/vacancy_object.dart';

class VacancyInfoScreen extends StatelessWidget {
  const VacancyInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
    const descriptionStyle =
        TextStyle(fontSize: 16, fontWeight: FontWeight.w400);
    const topInfoStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w400);
    final vacancyObject =
        ModalRoute.of(context)!.settings.arguments as VacancyObject;
    final vacancy = vacancyObject.vacancy;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vacancy Information'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      border: Border.all(width: 0.3, color: Colors.grey)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                vacancy.jobName,
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                vacancy.salaryMin == 0
                                    ? 'Зарпалата не указанa'
                                    : '${vacancy.salaryMin} - ${vacancy.salaryMax} ${vacancy.currency.substring(1, 5)}',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                '${vacancy.employment}, ${vacancy.schedule}',
                                style: topInfoStyle,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                vacancy.region.name == ''
                                    ? 'Регион не указан'
                                    : vacancy.region.name,
                                style: topInfoStyle,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                vacancy.company.name,
                                style: topInfoStyle,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                const Text('Category', style: titleStyle),
                const SizedBox(height: 10),
                Text(vacancy.category.specialisation, style: descriptionStyle),
                const SizedBox(height: 30),
                const Text('Description', style: titleStyle),
                const SizedBox(height: 10),
                Text(
                    vacancy.duty.replaceAll(
                      RegExp(r'</p>|<p>|&nbsp;|</ul>|</li>|<ul>|<li>|<b>|</b>'),
                      '',
                    ),
                    style: descriptionStyle),
                const SizedBox(height: 30),
                const Text('Address', style: titleStyle),
                const SizedBox(height: 10),
                Text(vacancy.addresses.address[0].location,
                    style: descriptionStyle),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
