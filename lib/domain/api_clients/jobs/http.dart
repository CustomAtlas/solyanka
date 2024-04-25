import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:solyanka/domain/entities/response.dart';
import 'package:solyanka/domain/entities/vacancy_object.dart';

class MyHttpClient {
  final client = HttpClient();

  var choosedFieldsForSearch = <String>[];
  String field = '';

  Future<void> _getSearchFields() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final it = prefs.getBool('it') ?? false;
    final arts = prefs.getBool('arts') ?? false;
    final safety = prefs.getBool('safety') ?? false;
    final pr = prefs.getBool('pr') ?? false;
    final med = prefs.getBool('med') ?? false;
    final sci = prefs.getBool('sci') ?? false;
    final sales = prefs.getBool('sales') ?? false;
    final constr = prefs.getBool('constr') ?? false;
    final fin = prefs.getBool('fin') ?? false;

    if (it) choosedFieldsForSearch.add('IT');
    if (arts) choosedFieldsForSearch.add('искусство');
    if (safety) choosedFieldsForSearch.add('безопасность');
    if (pr) choosedFieldsForSearch.add('маркетолог');
    if (med) choosedFieldsForSearch.add('медик');
    if (sci) choosedFieldsForSearch.add('наука');
    if (sales) choosedFieldsForSearch.add('продажи');
    if (constr) choosedFieldsForSearch.add('недвижимость');
    if (fin) choosedFieldsForSearch.add('финансы');
  }

  Future<List<VacancyObject>> getVacancyObjects(int page) async {
    await _getSearchFields();
    switch (page) {
      case < 2:
        field = choosedFieldsForSearch[0];
      case (> 2 && < 4):
        if (choosedFieldsForSearch.length == 1) break;
        field = choosedFieldsForSearch[1];
      case (> 4 && < 6):
        if (choosedFieldsForSearch.length == 2) break;
        field = choosedFieldsForSearch[2];
      case (> 6 && < 8):
        if (choosedFieldsForSearch.length == 3) break;
        field = choosedFieldsForSearch[3];
      case (> 8 && < 10):
        if (choosedFieldsForSearch.length == 4) break;
        field = choosedFieldsForSearch[4];
      default:
        field = field;
    }
    final json = await get(
            'http://opendata.trudvsem.ru/api/v1/vacancies?offset=$page&limit=5&text=$field')
        as Map<String, dynamic>;

    return MyResponse.fromJson(json).results.vacancies;
  }

  Future<List<VacancyObject>> getSearchVacancies(
      int page, String search) async {
    final json = await get(
            'http://opendata.trudvsem.ru/api/v1/vacancies?offset=$page&limit=5&text=$search')
        as Map<String, dynamic>;

    return MyResponse.fromJson(json).results.vacancies;
  }

  Future<dynamic> get(String uri) async {
    final url = Uri.parse(uri);
    final request = await client.getUrl(url);
    final response = await request.close();
    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();
    final dynamic json = jsonDecode(jsonString);
    return json;
  }
}
