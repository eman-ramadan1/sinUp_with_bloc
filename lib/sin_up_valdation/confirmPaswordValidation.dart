import 'package:flutter/material.dart';

String? Function(String?) ConfirmPasswordValidation({
  required BuildContext context,
  required TextEditingController passwordController,
}) {
  return (value) {
    if (value == null || value.isEmpty) {
      return 'Required Field';
    }

    if (value != passwordController.text) {
      return 'Passwords do not match';
    }

    return null;
  };
}
