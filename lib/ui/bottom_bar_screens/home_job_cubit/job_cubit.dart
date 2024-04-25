import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solyanka/domain/api_clients/jobs/dio.dart';
import 'package:solyanka/domain/entities/vacancy_object.dart';

part 'job_state.dart';

class JobCubit extends Cubit<JobState> {
  JobCubit() : super(JobStateLoading()) {
    getVacancies();
  }

  final myDio = MyDio();
  var vacancies = <VacancyObject>[];

  Future<void> getVacancies() async {
    try {
      vacancies.clear();
      vacancies.addAll(await myDio.getVacancies());
      emit(JobStateLoaded(vacancyObjecs: vacancies));
    } catch (e) {
      emit(JobStateLoadingFailure(exception: e.toString()));
    }
  }

  Timer? searchTimer;

  Future<void> getSearchVacancies(Completer? completer, String search) async {
    searchTimer?.cancel();
    searchTimer = Timer(const Duration(milliseconds: 700), () async {
      try {
        emit(JobStateLoading());
        vacancies.clear();
        vacancies.addAll(await myDio.getSearchVacancies(1, search));

        emit(JobStateLoaded(vacancyObjecs: vacancies));
      } catch (e) {
        emit(JobStateLoadingFailure(exception: e.toString()));
      } finally {
        completer?.complete();
      }
    });
  }
}
