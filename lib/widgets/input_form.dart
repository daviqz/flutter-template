import 'package:flutter/material.dart';

class InputForm extends StatelessWidget {
  const InputForm(
      {super.key,
      required TextEditingController inputFieldValueController,
      required String labelText,
      required String hintText,
      required IconData icon,
      required TextInputType keyboardType,
      required bool obscureText,
      String? errorText})
      : _inputFieldValueController = inputFieldValueController,
        _labelText = labelText,
        _hintText = hintText,
        _icon = icon,
        _keyboardType = keyboardType,
        _obscureText = obscureText,
        _errorText = errorText;

  final TextEditingController _inputFieldValueController;
  final String _labelText;
  final String _hintText;
  final IconData _icon;
  final TextInputType _keyboardType;
  final bool _obscureText;
  final String? _errorText;

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: _inputFieldValueController,
        decoration: InputDecoration(
          labelText: _labelText,
          hintText: _hintText,
          errorText: _errorText,
          prefixIcon: Icon(
            _icon,
          ),
          border: const OutlineInputBorder(),
        ),
        keyboardType: _keyboardType,
        obscureText: _obscureText);
  }
}
