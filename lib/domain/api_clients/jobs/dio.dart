import 'package:dio/dio.dart';
import 'package:solyanka/domain/entities/response.dart';
import 'package:solyanka/domain/entities/vacancy_object.dart';

class MyDio {
  final dio = Dio();

  Future<List<VacancyObject>> getVacancies() async {
    final response = await dio.get(
        'http://opendata.trudvsem.ru/api/v1/vacancies?offset=1&limit=1&text=разработчик');

    return MyResponse.fromJson(response.data).results.vacancies;
  }

  Future<List<VacancyObject>> getSearchVacancies(
      int page, String search) async {
    final response = await dio.get(
        'http://opendata.trudvsem.ru/api/v1/vacancies?offset=$page&limit=20&text=$search');

    return MyResponse.fromJson(response.data).results.vacancies;
  }
}
