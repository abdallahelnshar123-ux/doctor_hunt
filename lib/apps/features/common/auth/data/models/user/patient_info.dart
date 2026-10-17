import 'package:equatable/equatable.dart';

class PatientInfo extends Equatable {
  final List<String> favDoctors;

  const PatientInfo({this.favDoctors = const []});

  PatientInfo copyWith({List<String>? favDoctors}) {
    return PatientInfo(favDoctors: favDoctors ?? this.favDoctors);
  }

  @override
  List<Object?> get props => [favDoctors];
}
