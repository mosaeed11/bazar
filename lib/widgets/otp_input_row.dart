import 'package:bazar/screens/auth/auth_styles.dart';
import 'package:bazar/widgets/custom_numpad.dart';
import 'package:flutter/material.dart';

mixin OtpKeyHandling<T extends StatefulWidget> on State<T> {
  List<TextEditingController> get otpControllers;

  List<FocusNode> get otpFocusNodes;

  String get otpValue => otpControllers.map((c) => c.text).join();

  bool get isOtpComplete =>
      otpValue.length == otpControllers.length && otpValue.isNotEmpty;

  int get _focusedIndex {
    final index = otpFocusNodes.indexWhere((node) => node.hasFocus);
    return index == -1 ? 0 : index;
  }

  void handleOtpKeyTap(String key) {
    final index = _focusedIndex;
    final controller = otpControllers[index];

    if (key == CustomNumpad.backspaceKey) {
      if (controller.text.isNotEmpty) {
        controller.clear();
      } else if (index > 0) {
        otpControllers[index - 1].clear();
        otpFocusNodes[index - 1].requestFocus();
      }
    } else {
      controller.text = key;
      if (index < otpControllers.length - 1) {
        otpFocusNodes[index + 1].requestFocus();
      } else {
        otpFocusNodes[index].unfocus();
      }
    }

    setState(() {});
  }
}

class OtpInputRow extends StatelessWidget {
  const OtpInputRow({
    required this.controllers,
    required this.focusNodes,
    this.length = 4,
    super.key,
  });

  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;
  final int length;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        length,
        (i) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: _OtpBox(
            controller: controllers[i],
            focusNode: focusNodes[i],
          ),
        ),
      ),
    );
  }
}

class _OtpBox extends StatefulWidget {
  const _OtpBox({required this.controller, required this.focusNode});

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  State<_OtpBox> createState() => _OtpBoxState();
}

class _OtpBoxState extends State<_OtpBox> {
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _isFocused = widget.focusNode.hasFocus;
    widget.focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_handleFocusChange);
    super.dispose();
  }

  void _handleFocusChange() {
    if (!mounted) return;
    setState(() => _isFocused = widget.focusNode.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _isFocused ? AppColors.primary : AppColors.inputBorder,
          width: _isFocused ? 1.5 : 1,
        ),
      ),
      alignment: Alignment.center,
      child: TextField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        readOnly: true,
        showCursor: true,
        enableInteractiveSelection: false,
        enableSuggestions: false,
        autocorrect: false,
        keyboardType: TextInputType.none,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          isDense: true,
        ),
      ),
    );
  }
}