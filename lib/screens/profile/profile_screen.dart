import 'package:bazar/data/dummy_data.dart';
import 'package:bazar/screens/auth/auth_styles.dart';
import 'package:bazar/screens/profile/favorites_screen.dart';
import 'package:bazar/screens/profile/help_center_screen.dart';
import 'package:bazar/screens/profile/my_account_screen.dart';
import 'package:bazar/screens/profile/order_history_screen.dart';
import 'package:bazar/services/app_prefs.dart';
import 'package:bazar/services/auth_service.dart';
import 'package:bazar/state/favorites_store.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _name = '';
  String _phone = '';
  final String _avatarPath = currentUser.avatarPath;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final firebaseUser = AuthService().currentUser;
    final name = firebaseUser?.displayName?.trim();
    final savedName = await AppPrefs.getName();
    final phone = await AppPrefs.getPhone();
    if (!mounted) return;
    setState(() {
      _name = (name != null && name.isNotEmpty) ? name : savedName;
      _phone = phone;
    });
  }

  static const List<({String label, IconData icon})> _menuItems = [
    (label: 'My Account', icon: Icons.account_circle_outlined),
    (label: 'Your Favorites', icon: Icons.favorite_border),
    (label: 'Order History', icon: Icons.receipt_long_outlined),
    (label: 'Help Center', icon: Icons.help_outline),
  ];

  Future<void> _open(BuildContext context, String label) async {
    final Widget screen = switch (label) {
      'My Account' => const MyAccountScreen(),
      'Your Favorites' => const FavoritesScreen(),
      'Order History' => const OrderHistoryScreen(),
      _ => const HelpCenterScreen(),
    };
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
    await _loadProfile();
  }

  Future<void> _handleLogout(BuildContext context) async {
    try {
      await AuthService().signOut();
    } catch (_) {
      // continue to onboarding even if the network call fails
    }
    await AppPrefs.setSeenOnboarding(false);
    await AppPrefs.clearProfile();
    favoritesStore.clear();
    if (!context.mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, '/onboarding', (route) => false);
  }

  void _showLogoutSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => _LogoutSheet(
        onLogout: () => _handleLogout(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final displayName = _name.isNotEmpty ? _name : currentUser.name;
    final displayPhone = _phone.isNotEmpty ? _phone : currentUser.phone;

    return ListView(
      padding: const EdgeInsets.only(bottom: 16),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
          child: Row(
            children: [
              ClipOval(
                child: Image.asset(
                  _avatarPath,
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stack) => Container(
                    width: 56,
                    height: 56,
                    color: AppColors.cardBackground,
                    child: const Icon(
                      Icons.person,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      displayName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      displayPhone,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => _showLogoutSheet(context),
                child: const Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.error,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(color: AppColors.inputBorder, height: 1),
        for (final item in _menuItems)
          _MenuRow(
            label: item.label,
            icon: item.icon,
            onTap: () => _open(context, item.label),
          ),
      ],
    );
  }
}

class _MenuRow extends StatelessWidget {
  const _MenuRow({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        child: Row(
          children: [
            Icon(icon, size: 22, color: AppColors.primary),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              size: 22,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}

class _LogoutSheet extends StatelessWidget {
  const _LogoutSheet({required this.onLogout});

  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Logout',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Lorem Ipsum is simply dummy text of the printing and '
                'typesetting industry.',
                style: TextStyle(
                  fontSize: 13,
                  height: 1.5,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 48,
                child: FilledButton(
                  onPressed: () {
                    Navigator.pop(context);
                    onLogout();
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 48,
                child: FilledButton(
                  onPressed: () => Navigator.pop(context),
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFFECE6FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}