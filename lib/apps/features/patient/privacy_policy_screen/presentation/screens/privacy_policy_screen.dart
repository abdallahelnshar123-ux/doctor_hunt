import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/core/widgets/app_container_with_shadow.dart';
import 'package:doctor_hunt/apps/core/widgets/app_scaffold.dart';
import 'package:doctor_hunt/apps/core/widgets/main_app_bar.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sections = t.privacyPolicy.sections;

    return AppScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MainAppBar(title: t.privacyPolicy.title),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              children: [
                _buildHeaderCard(context),
                const SizedBox(height: 20),
                _buildSectionCard(
                  context,
                  title: sections.informationWeCollect.title,
                  description: sections.informationWeCollect.description,
                  bullets: sections.informationWeCollect.bullets,
                  icon: Icons.shield_outlined,
                ),
                const SizedBox(height: 16),
                _buildSectionCard(
                  context,
                  title: sections.howWeUseInformation.title,
                  description: sections.howWeUseInformation.description,
                  bullets: sections.howWeUseInformation.bullets,
                  icon: Icons.analytics_outlined,
                ),
                const SizedBox(height: 16),
                _buildSectionCard(
                  context,
                  title: sections.dataSecurity.title,
                  description: sections.dataSecurity.description,
                  bullets: sections.dataSecurity.bullets,
                  icon: Icons.lock_outline,
                ),
                const SizedBox(height: 16),
                _buildSectionCard(
                  context,
                  title: sections.thirdPartyServices.title,
                  description: sections.thirdPartyServices.description,
                  bullets: sections.thirdPartyServices.bullets,
                  icon: Icons.extension_outlined,
                ),
                const SizedBox(height: 16),
                _buildSectionCard(
                  context,
                  title: sections.yourRights.title,
                  description: sections.yourRights.description,
                  bullets: sections.yourRights.bullets,
                  icon: Icons.admin_panel_settings_outlined,
                ),
                const SizedBox(height: 16),
                _buildSectionCard(
                  context,
                  title: sections.contactUs.title,
                  description: sections.contactUs.description,
                  bullets: null,
                  icon: Icons.mail_outline,
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCard(BuildContext context) {
    return AppContainerWithShadow(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 14,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.brandPrimary20,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.privacy_tip_rounded,
                  color: AppColors.brandPrimary,
                  size: 28,
                ),
              ),
              // const SizedBox(width: 14),
              Expanded(
                child: Column(
                  spacing: 2,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.privacyPolicy.title,
                      style: context.bold18.textPrimary.rubik,
                    ),
                    // const SizedBox(height: 2),
                    Text(
                      t.privacyPolicy.lastUpdated,
                      style: context.regular12.textMuted.rubik,
                    ),
                  ],
                ),
              ),
            ],
          ),
          // const SizedBox(height: 16),
          Text(
            t.privacyPolicy.introduction,
            style: context.regular14.textSecondary.rubik.copyWith(height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    List<String>? bullets,
  }) {
    return AppContainerWithShadow(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 10,
            children: [
              Icon(icon, color: AppColors.brandPrimary, size: 22),
              Expanded(
                child: Text(title, style: context.bold16.textPrimary.rubik),
              ),
            ],
          ),
          Text(
            description,
            style: context.regular14.textSecondary.rubik.copyWith(height: 1.4),
          ),
          if (bullets != null && bullets.isNotEmpty) ...[
            ...bullets.map(
              (bullet) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 6, right: 10, left: 2),
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppColors.brandPrimary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        bullet,
                        style: context.regular14.textSecondary.rubik.copyWith(
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
