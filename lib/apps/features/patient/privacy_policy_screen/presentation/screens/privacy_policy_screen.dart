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
    final sections = t.privacy_policy.sections;

    return AppScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MainAppBar(title: t.privacy_policy.title),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              children: [
                _buildHeaderCard(context),
                const SizedBox(height: 20),
                _buildSectionCard(
                  context,
                  title: sections.information_we_collect.title,
                  description: sections.information_we_collect.description,
                  bullets: sections.information_we_collect.bullets,
                  icon: Icons.shield_outlined,
                ),
                const SizedBox(height: 16),
                _buildSectionCard(
                  context,
                  title: sections.how_we_use_information.title,
                  description: sections.how_we_use_information.description,
                  bullets: sections.how_we_use_information.bullets,
                  icon: Icons.analytics_outlined,
                ),
                const SizedBox(height: 16),
                _buildSectionCard(
                  context,
                  title: sections.data_security.title,
                  description: sections.data_security.description,
                  bullets: sections.data_security.bullets,
                  icon: Icons.lock_outline,
                ),
                const SizedBox(height: 16),
                _buildSectionCard(
                  context,
                  title: sections.third_party_services.title,
                  description: sections.third_party_services.description,
                  bullets: sections.third_party_services.bullets,
                  icon: Icons.extension_outlined,
                ),
                const SizedBox(height: 16),
                _buildSectionCard(
                  context,
                  title: sections.your_rights.title,
                  description: sections.your_rights.description,
                  bullets: sections.your_rights.bullets,
                  icon: Icons.admin_panel_settings_outlined,
                ),
                const SizedBox(height: 16),
                _buildSectionCard(
                  context,
                  title: sections.contact_us.title,
                  description: sections.contact_us.description,
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
                      t.privacy_policy.title,
                      style: context.bold18.textPrimary.rubik,
                    ),
                    // const SizedBox(height: 2),
                    Text(
                      t.privacy_policy.last_updated,
                      style: context.regular12.textMuted.rubik,
                    ),
                  ],
                ),
              ),
            ],
          ),
          // const SizedBox(height: 16),
          Text(
            t.privacy_policy.introduction,
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
