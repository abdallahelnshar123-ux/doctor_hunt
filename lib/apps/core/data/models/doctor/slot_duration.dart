enum SlotDuration {
  min10(10),
  min15(15),
  min20(20),
  min30(30),
  min40(40),
  min45(45),
  min60(60);

  final int minutes;

  const SlotDuration(this.minutes);

  @override
  String toString() => '$minutes Minutes';
}
