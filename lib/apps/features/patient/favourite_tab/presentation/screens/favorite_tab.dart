import 'package:doctor_hunt/apps/core/data/models/doctor/doctor.dart';
import 'package:doctor_hunt/apps/core/widgets/search_text_field_widget.dart';
import 'package:doctor_hunt/apps/features/patient/favourite_tab/presentation/widget/favourite_doctor_card.dart';
import 'package:doctor_hunt/apps/features/patient/favourite_tab/presentation/widget/favourite_doctors_shimmer.dart';
import 'package:doctor_hunt/apps/features/patient/home_tab/presentation/controller/patient_doctors_bloc.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../core/widgets/app_scaffold.dart';
import '../../../../common/auth/presentation/controller/user/user_bloc.dart';
import '../../../../common/auth/presentation/controller/user/user_state.dart';
import '../controller/favourite_doctors_bloc.dart';

class FavoriteTab extends HookWidget {
  const FavoriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    final patientState = context.read<PatientDoctorsBloc>().state;
    final allDoctors = patientState is PatientDoctorsSuccess
        ? patientState.doctors
        : <Doctor>[];

    final initialFavIds =
        context.read<UserBloc>().state.user?.patientInfo?.favDoctors ?? [];

    useEffect(() {
      context.read<FavouriteDoctorsBloc>().add(
        LoadFavoritesEvent(
          allDoctors: allDoctors,
          favoriteDoctorIds: initialFavIds,
        ),
      );
      return null;
    }, const []);
    return BlocListener<UserBloc, UserState>(
      listenWhen: (previous, current) {
        final prevFavs = previous.user?.patientInfo?.favDoctors ?? [];
        final currFavs = current.user?.patientInfo?.favDoctors ?? [];
        return prevFavs !=
            currFavs; // استمع فقط لو المفضلة اتغيرت (اليوزر داس على القلب)
      },
      listener: (context, state) {
        final newFavIds = state.user?.patientInfo?.favDoctors ?? [];
        // 4. إخبار بلوك المفضلة بإزالة الدكتور من الـ UI لحظياً
        context.read<FavouriteDoctorsBloc>().add(
          UpdateFavoriteIdsEvent(newFavIds),
        );
      },
      child: AppScaffold(
        bottomSafeArea: false,
        body: Column(
          spacing: 10,
          children: [
            AppBar(title: Text(t.home.favourite_doctors)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SearchTextFieldWidget(
                onTapOutside: (event) {},
                onChanged: (query) {
                  context.read<FavouriteDoctorsBloc>().add(
                    SearchFavouriteDoctorsRequested(query),
                  );
                },
              ),
            ),
            Expanded(
              child: SafeArea(
                top: false,
                child: BlocBuilder<FavouriteDoctorsBloc, FavouriteDoctorsState>(
                  builder: (context, state) {
                    if (state is FavouriteDoctorsSuccess) {
                      if (state.filteredDoctors.isEmpty) {
                        if (state.searchQuery?.isNotEmpty ?? false) {
                          return _buildText(
                            text: t
                                .favourite_doctors
                                .no_favourite_doctors_match_search,
                            context: context,
                          );
                        } else {
                          return _buildText(
                            text: t
                                .favourite_doctors
                                .no_favourite_doctors_description,
                            context: context,
                          );
                        }
                      }

                      final currentDoctorsList = state.filteredDoctors;

                      return GridView.builder(
                        padding: EdgeInsets.all(20),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 180 / 160,
                          mainAxisExtent: 280,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 15,
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) => FavouriteDoctorCard(
                          doctor: currentDoctorsList[index],
                        ),
                        itemCount: currentDoctorsList.length,
                      );
                    }
                    return const FavouriteDoctorsShimmer();

                    // return Center(
                    //   child: Text(
                    //     t.favourite_doctors.no_favourite_doctors_description,
                    //   ),
                    // );
                  },
                ),
              ),
            ),
            // SizedBox(height: 20,)
            // SizedBox(
            //   width: double.infinity,
            //   height: 450,
            //   child:
            // ),
            // TopRatedDoctorsWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildText({required String text, required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Center(
        child: Text(
          text,
          style: context.medium16.textTertiary.rubik,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
