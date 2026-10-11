enum WorkingHour {
  am8(8, '8:00 AM'),
  am9(9, '9:00 AM'),
  am10(10, '10:00 AM'),
  am11(11, '11:00 AM'),
  pm12(12, '12:00 PM'),
  pm1(13, '1:00 PM'),
  pm2(14, '2:00 PM'),
  pm3(15, '3:00 PM'),
  pm4(16, '4:00 PM'),
  pm5(17, '5:00 PM'),
  pm6(18, '6:00 PM'),
  pm7(19, '7:00 PM'),
  pm8(20, '8:00 PM'),
  pm9(21, '9:00 PM'),
  pm10(22, '10:00 PM'),
  pm11(23, '11:00 PM');

  final int hour24;
  final String label;

  const WorkingHour(this.hour24, this.label);

  @override
  String toString() => label;
}
