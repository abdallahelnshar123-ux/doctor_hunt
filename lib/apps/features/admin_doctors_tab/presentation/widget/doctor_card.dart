


part of '../screens/admin_doctors_tab.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainerWithShadow(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.white,
      ),
      child: Row(
        spacing: 15,
        children: [
          Container(
            width: context.width * 0.18,
            height: context.width * 0.18,
            decoration: BoxDecoration(
              shape: .circle,
              image: DecorationImage(
                fit: .cover,
                image: AssetImage(
                  AppAssets.images.testDoctorImage.path,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  'Dr.abdallah',
                  style: context.medium16.textTertiary.rubik,
                ),
                Text(
                  'Specialty',
                  style: context.medium12.textSecondary.rubik,
                ),
                Chip(
                  padding: EdgeInsets.all(5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  side: BorderSide(
                    width: 0,
                    color: AppColors.transparent,
                  ),
                  backgroundColor: AppColors.brandPrimary20,
                  label: Text(
                    'Active',
                    style: context.medium10.brandPrimaryDark.rubik,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert_rounded),
          ),
        ],
      ),
    );
  }
}
