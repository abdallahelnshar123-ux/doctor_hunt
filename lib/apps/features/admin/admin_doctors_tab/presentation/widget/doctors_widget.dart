part of '../screens/admin_doctors_tab.dart';

class DoctorsWidget extends StatelessWidget {
  const DoctorsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorBloc, DoctorState>(
      buildWhen: (previous, current) =>
          current is GetDoctorsSuccessState ||
          current is GetDoctorsLoadingState,
      builder: (context, state) {
        if (state is GetDoctorsSuccessState) {
          if (state.allDoctors.isEmpty ||
              (state.filteredDoctors?.isEmpty ?? false)) {
            return Expanded(child: _noDoctorFoundWidget(context: context));
          }
          return Expanded(
            child: Column(
              mainAxisSize: .min,
              children: [
                DefaultTabController(
                  length: state.specialtyCounts.length + 1,
                  child: TabBar(
                    overlayColor: WidgetStatePropertyAll(AppColors.transparent),
                    onTap: (index) {
                      if (index == 0) {
                        context.read<DoctorBloc>().add(
                          FilterDoctorsRequested(null),
                        );
                      } else {
                        final specialty =
                            state.specialtyCounts[index - 1].keys.first;
                        context.read<DoctorBloc>().add(
                          FilterDoctorsRequested(specialty),
                        );
                      }
                    },
                    tabAlignment: TabAlignment.start,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    isScrollable: true,
                    dividerColor: AppColors.transparent,
                    indicatorColor: AppColors.transparent,
                    labelPadding: EdgeInsets.symmetric(
                      horizontal: context.width * 0.01,
                    ),
                    tabs: [
                      TabBarWidget(
                        isSelected: state.selectedSpecialty == null,
                        number: state.allDoctors.length,
                        label: t.admin.doctors_tab.all,
                      ),
                      ...state.specialtyCounts.map((map) {
                        final label = map.keys.first.name;
                        final number = map.values.first;
                        return TabBarWidget(
                          isSelected: state.selectedSpecialty?.name == label,
                          number: number,
                          label: label,
                        );
                      }),
                    ],
                  ),
                ),
                Expanded(
                  child:
                      state.allDoctors.isEmpty &&
                          (state.filteredDoctors?.isEmpty ?? false)
                      ? _noDoctorFoundWidget(context: context)
                      : SafeArea(
                        child: ListView.separated(
                            padding: EdgeInsets.all(20),
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                AdminDoctorDetailsRoute(
                                  _buildDoctorsList(
                                    allDoctors: state.allDoctors,
                                    filteredDoctors: state.filteredDoctors,
                                  )[index],
                                ).push(context);
                              },
                              child: DoctorCard(
                                doctor: _buildDoctorsList(
                                  allDoctors: state.allDoctors,
                                  filteredDoctors: state.filteredDoctors,
                                )[index],
                              ),
                            ),
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 10),
                            itemCount: _buildDoctorsList(
                              allDoctors: state.allDoctors,
                              filteredDoctors: state.filteredDoctors,
                            ).length,
                          ),
                      ),
                ),
              ],
            ),
          );
        }
        return Expanded(child: AdminDoctorsShimmer());
      },
      listenWhen: (previous, current) => current is GetDoctorsErrorState,
      listener: (context, state) {
        if (state is GetDoctorsErrorState) {
          SnackBarUtils.showErrorSnackBar(
            context: context,
            message: state.message,
          );
        }
      },
    );
  }

  Widget _noDoctorFoundWidget({required BuildContext context}) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(40, 70, 40, 40),
      children: [
        Image.asset(
          AppAssets.images.noDoctorsFoundImage.path,
          width: context.width / 4,
          height: context.width / 4,
          fit: .fitHeight,
        ),
        Text(
          t.admin.doctors_tab.no_doctors_found,
          style: context.bold16.textPrimary.rubik.copyWith(height: 2),
          textAlign: .center,
        ),
        Text(
          t.admin.doctors_tab.no_doctors_description,
          style: context.regular12.textSecondary.rubik,
          textAlign: .center,
        ),
      ],
    );
  }

  List<Doctor> _buildDoctorsList({
    required List<Doctor> allDoctors,
    required List<Doctor>? filteredDoctors,
  }) {
    if (filteredDoctors == null) {
      return allDoctors;
    }
    return filteredDoctors;
  }
}
