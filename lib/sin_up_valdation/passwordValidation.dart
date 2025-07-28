import 'package:flutter/material.dart';

String? Function(String?)? PasswordValidation({
  required BuildContext context,
}) {
  return (value) {
    if (value == null || value.isEmpty) {
      return 'Required Field';
    }

    if (value.length < 6) {
      return 'Less length';
    }

    return null;
  };
}
