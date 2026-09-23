import 'package:doctor_hunt/generated/translations.g.dart';

enum TimeSlot {
  tenAm(time: '10:00', isAm: true),
  twelvePm(time: '12:00', isAm: false),
  twoPm(time: '02:00', isAm: false),
  threePm(time: '03:00', isAm: false),
  fourPm(time: '04:00', isAm: false),
  sixPm(time: '06:00', isAm: false),
  sevenPm(time: '07:00', isAm: false);

  final String time;
  final bool isAm;

  const TimeSlot({required this.time, required this.isAm});

  String get localizedLabel =>
      '$time\n${isAm ? t.common.am : t.common.pm}';
}

enum ReminderInterval {
  tenMinutes(minutes: 10),
  twentyFiveMinutes(minutes: 25),
  thirtyMinutes(minutes: 30),
  thirtyFiveMinutes(minutes: 35),
  fortyMinutes(minutes: 40),
  fortyFiveMinutes(minutes: 45),
  fiftyMinutes(minutes: 50);

  final int minutes;

  const ReminderInterval({required this.minutes});

  String get localizedLabel => '$minutes\n${t.common.min}';
}
