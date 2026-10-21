import 'package:bazar/screens/auth/auth_styles.dart';
import 'package:bazar/services/app_prefs.dart';
import 'package:bazar/widgets/auth_button.dart';
import 'package:bazar/widgets/custom_numpad.dart';
import 'package:flutter/material.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleKeyTap(String key) {
    if (key == CustomNumpad.backspaceKey) {
      if (_phoneController.text.isNotEmpty) {
        _phoneController.text =
            _phoneController.text.substring(0, _phoneController.text.length - 1);
      }
    } else {
      _phoneController.text += key;
    }
    setState(() {});
  }

  Future<void> _handleContinue() async {
    final phone = _phoneController.text.trim();
    await AppPrefs.setPhone(phone);
    if (!mounted) return;
    Navigator.pushNamed(context, '/phone-verification', arguments: phone);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: buildAuthTheme(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: AppColors.textPrimary,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      const Text(
                        'Phone Number',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Please enter your phone number, so we can\nmore easily deliver your order',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 32),
                      const AuthFieldLabel('Phone Number'),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _phoneController,
                        focusNode: _focusNode,
                        readOnly: true,
                        enableInteractiveSelection: false,
                        enableSuggestions: false,
                        autocorrect: false,
                        keyboardType: TextInputType.none,
                        decoration: buildAuthInputDecoration(
                          hintText: '(+965) 123 435 7565',
                          prefixIcon: const Icon(
                            Icons.phone_outlined,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      AuthButton(
                        label: 'Continue',
                        isEnabled: _phoneController.text.isNotEmpty,
                        onPressed: _handleContinue,
                      ),
                    ],
                  ),
                ),
              ),
              CustomNumpad(onKeyTap: _handleKeyTap, showDot: true),
            ],
          ),
        ),
      ),
    );
  }
}