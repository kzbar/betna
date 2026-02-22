import 'package:betna/generated/l10n.dart';
import 'package:betna/style/style.dart';
import 'package:betna/style/widget/logo_widget.dart';
import 'package:flutter/material.dart';

class MobileDrawer extends StatelessWidget {
  const MobileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Drawer(
      backgroundColor: Style.luxuryCharcoal,
      child: SafeArea(
        child: Column(
          children: [
            // Drawer Header
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Logo(hi: 32, we: 90, withBackground: false),
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 28,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            const Divider(color: Colors.white10, height: 1),

            // Navigation Links
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 24),
                children: [
                  _buildDrawerItem(
                    context,
                    title: s.kProjectsSectionTitle,
                    icon: Icons.business_outlined,
                    onTap: () {
                      Navigator.pop(context);
                      if (ModalRoute.of(context)?.settings.name !=
                          '/projects') {
                        Navigator.pushNamed(context, '/projects');
                      }
                    },
                  ),
                  _buildDrawerItem(
                    context,
                    title: s.kResaleSectionTitle,
                    icon: Icons.vpn_key_outlined,
                    onTap: () {
                      Navigator.pop(context);
                      if (ModalRoute.of(context)?.settings.name != '/resale') {
                        Navigator.pushNamed(context, '/resale');
                      }
                    },
                  ),
                  _buildDrawerItem(
                    context,
                    title: s.kBetnaHomePageAbout,
                    icon: Icons.info_outline,
                    onTap: () {
                      Navigator.pop(context);
                      if (ModalRoute.of(context)?.settings.name != '/about') {
                        Navigator.pushNamed(context, '/about');
                      }
                    },
                  ),
                  _buildDrawerItem(
                    context,
                    title: s.kEidsPageTitle,
                    icon: Icons.gavel_outlined,
                    onTap: () {
                      Navigator.pop(context);
                      if (ModalRoute.of(context)?.settings.name != '/eids') {
                        Navigator.pushNamed(context, '/eids');
                      }
                    },
                  ),
                ],
              ),
            ),

            // Footer Info
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                "© ${DateTime.now().year} Betna Gayrimenkul",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white.withValues(alpha: 0.3),
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 32, vertical: 4),
      leading: Icon(icon, color: Style.luxuryGold, size: 22),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
          fontSize: 16,
        ),
      ),
      onTap: onTap,
    );
  }
}
