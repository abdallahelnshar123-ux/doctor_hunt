part of '../screens/select_time_screen.dart';

class SlotsTab extends HookWidget {
  const SlotsTab({
    super.key,
    required this.index,
    required this.state,
    required this.doctor,
  });

  final int index;
  final SelectTimeLoaded state;
  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    final availableSlots = useRef(
      state.weeklyAvailability[index].availableSlots,
    );
    final morningSlots = useRef(
      availableSlots.value.where((slot) => slot.time.hour < 12).toList(),
    );
    final afternoonSlots = useRef(
      availableSlots.value
          .where((slot) => slot.time.hour >= 12 && slot.time.hour < 17)
          .toList(),
    );
    final eveningSlots = useRef(
      availableSlots.value.where((slot) => slot.time.hour >= 17).toList(),
    );
    final date = useRef(state.weeklyAvailability[index].date);
    final tabText = DateFormatterUtils.formatToRelativeDayAndDate(date.value);

    final selectedSlot = useValueNotifier<DateTime?>(null);
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20),
      children: [
        Text(
          tabText,
          style: context.medium18.textTertiary.rubik,
          textAlign: .center,
        ),
        SizedBox(height: 40),
        _buildPeriodSlots(
          context: context,
          selectedSlot: selectedSlot,
          slotsList: morningSlots.value,
          title: t.select_time.morning_slots(Number: morningSlots.value.length),
        ),
        SizedBox(height: 20),
        _buildPeriodSlots(
          context: context,
          selectedSlot: selectedSlot,
          slotsList: afternoonSlots.value,
          title: t.select_time.afternoon_slots(
            Number: afternoonSlots.value.length,
          ),
        ),
        SizedBox(height: 20),
        _buildPeriodSlots(
          context: context,
          selectedSlot: selectedSlot,
          slotsList: eveningSlots.value,
          title: t.select_time.evening_slots(Number: eveningSlots.value.length),
        ),
        SizedBox(height: 20),
        _buildConfirmButton(context, selectedSlot, doctor),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildConfirmButton(
    BuildContext context,
    ValueNotifier<DateTime?> selectedSlot,
    Doctor doctor,
  ) {
    return CustomElevatedButton(
      buttonWidth: context.width - 80,
      onPressed: () {
        if (selectedSlot.value != null) {
          context.read<SelectTimeBloc>().add(
            BookAppointmentEvent(
              selectedTime: selectedSlot.value!,
              doctor: doctor,
            ),
          );
        } else {
          SnackBarUtils.showInfoSnackBar(
            context: context,
            message: t.select_time.you_must_select_appointment_time,
          );
        }
      },
      backgroundColor: AppColors.brandPrimary,
      child: Text(t.select_time.confirm, style: context.medium18.white.rubik),
    );
  }

  Widget _buildPeriodSlots({
    required List<TimeSlot> slotsList,
    required String title,
    required BuildContext context,
    required ValueNotifier<DateTime?> selectedSlot,
  }) {
    return Visibility(
      visible: slotsList.isNotEmpty,
      child: Column(
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        children: [
          Text(
            title,
            style: context.medium16.textTertiary.rubik,
            textAlign: .center,
          ),
          SizedBox(height: 10),
          ValueListenableBuilder(
            valueListenable: selectedSlot,
            builder: (context, selectedSlotValue, child) {
              return Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: .start,
                crossAxisAlignment: WrapCrossAlignment.center,

                children: List.generate(slotsList.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      selectedSlot.value = slotsList[index].time;
                    },
                    child: Chip(
                      padding: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: BorderSide(width: 0, color: AppColors.transparent),
                      backgroundColor:
                          selectedSlotValue == slotsList[index].time
                          ? AppColors.brandPrimary
                          : AppColors.brandPrimary8,

                      label: Text(
                        DateFormat('hh:mm a').format(slotsList[index].time),
                        // '${availableSlots[index].time.hour}:${availableSlots[index].time.minute}',
                        style: selectedSlotValue == slotsList[index].time
                            ? context.medium14.white.rubik
                            : context.medium14.brandPrimary.rubik,
                      ),
                    ),
                  );
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}
