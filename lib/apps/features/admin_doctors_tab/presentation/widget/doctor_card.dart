part of '../screens/admin_doctors_tab.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({super.key});

  @override
  Widget build(BuildContext context) {
    var t = Translations.of(context);
    return AppContainerWithShadow(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.white,
      ),
      child: Row(
        spacing: 15,
        children: [
          Container(
            width: context.width * 0.18,
            height: context.width * 0.18,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                fit: .cover,
                image: AssetImage(AppAssets.images.testDoctorImage.path),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(t.doctor_details.doctor_name, style: context.medium16.textTertiary.rubik),
                Text(t.doctor_details.specialist_cardiology, style: context.medium12.textSecondary.rubik),
                Chip(
                  padding: EdgeInsets.all(5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  side: BorderSide(width: 0, color: AppColors.transparent),
                  backgroundColor: AppColors.statusErrorSurface,
                  avatarBoxConstraints: .tightFor(width: 15),
                  avatar: Icon(
                    Icons.circle,
                    size: 10,
                    color: AppColors.statusError,
                  ),
                  // visualDensity: .compact,
                  label: Text(
                    t.admin.inactive,
                    style: context.regular10.statusError.rubik,
                  ),
                ),

                /// Do not delete it !!!
                // Chip(
                //   padding: EdgeInsets.all(5),
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(30),
                //   ),
                //   side: BorderSide(width: 0, color: AppColors.transparent),
                //   backgroundColor: AppColors.brandPrimary20,
                //   avatarBoxConstraints: .tightFor(width: 15),
                //   avatar: Icon(
                //     Icons.circle,
                //     size: 10,
                //     color: AppColors.brandPrimaryDark,
                //   ),
                //   // visualDensity: .compact,
                //   label: Text(
                //     'Active',
                //     style: context.medium10.brandPrimaryDark.rubik,
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
