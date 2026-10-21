import 'package:bazar/screens/auth/auth_styles.dart';
import 'package:bazar/services/app_prefs.dart';
import 'package:bazar/services/auth_service.dart';
import 'package:bazar/widgets/auth_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({super.key});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final firebaseUser = _authService.currentUser;
    final savedName = await AppPrefs.getName();
    final savedEmail = await AppPrefs.getEmail();
    if (!mounted) return;
    setState(() {
      _nameController.text = (firebaseUser?.displayName ?? '').isNotEmpty
          ? firebaseUser!.displayName!
          : savedName;
      _emailController.text = (firebaseUser?.email ?? '').isNotEmpty
          ? firebaseUser!.email!
          : savedEmail;
    });
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _handleSave() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    setState(() => _isSaving = true);
    try {
      await AppPrefs.setName(name);
      await AppPrefs.setEmail(email);
      try {
        final user = _authService.currentUser;
        if (user != null) {
          if (user.displayName != name) {
            await user.updateDisplayName(name);
          }
          if (user.email != email) {
            await user.verifyBeforeUpdateEmail(
              email,
              ActionCodeSettings(
                url:
                    'https://bazar-b4c76.firebaseapp.com/__/auth/handler?email=$email',
                handleCodeInApp: true,
              ),
            );
          }
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'unauthorized-continue-uri' ||
            e.code == 'missing-continue-uri') {
          _showMessage('Saved locally. Add the auth domain to Firebase to '
              'change your email.');
        } else {
          _showMessage('Saved locally (Firebase: ${e.code})');
        }
      }
      if (!mounted) return;
      _showMessage('Saved');
    } catch (_) {
      if (!mounted) return;
      _showMessage('Could not save, please try again');
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: buildAuthTheme(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'My Account',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            children: [
              const AuthFieldLabel('Name'),
              const SizedBox(height: 8),
              TextField(
                controller: _nameController,
                decoration: buildAuthInputDecoration(hintText: 'Your name'),
              ),
              const SizedBox(height: 16),
              const AuthFieldLabel('Email'),
              const SizedBox(height: 8),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: buildAuthInputDecoration(hintText: 'Your email'),
              ),
              const SizedBox(height: 32),
              AuthButton(
                label: 'Save Changes',
                onPressed: _isSaving ? null : _handleSave,
              ),
            ],
          ),
        ),
      ),
    );
  }
}