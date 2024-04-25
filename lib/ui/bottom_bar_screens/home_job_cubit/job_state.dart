part of 'job_cubit.dart';

sealed class JobState extends Equatable {}

class JobStateLoading extends JobState {
  @override
  List<Object?> get props => [];
}

class JobStateLoaded extends JobState {
  JobStateLoaded({
    required this.vacancyObjecs,
  });

  final List<VacancyObject> vacancyObjecs;

  @override
  List<Object?> get props => [vacancyObjecs];
}

class JobStateLoadingFailure extends JobState {
  JobStateLoadingFailure({
    required this.exception,
  });

  final Object? exception;

  @override
  List<Object?> get props => [exception];
}
