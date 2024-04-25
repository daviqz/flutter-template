import 'package:flutter/material.dart';
import 'package:authorspace/utils/colors_utils.dart';

class InputForm extends StatelessWidget {
  const InputForm(
      {super.key,
      required TextEditingController inputFieldValueController,
      required String labelText,
      required String hintText,
      required IconData icon,
      required TextInputType keyboardType,
      required bool obscureText})
      : _inputFieldValueController = inputFieldValueController,
        _labelText = labelText,
        _hintText = hintText,
        _icon = icon,
        _keyboardType = keyboardType,
        _obscureText = obscureText;

  final TextEditingController _inputFieldValueController;
  final String _labelText;
  final String _hintText;
  final IconData _icon;
  final TextInputType _keyboardType;
  final bool _obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: _inputFieldValueController,
        decoration: InputDecoration(
          labelText: _labelText,
          hintText: _hintText,
          prefixIcon: Icon(
            _icon,
            color: ColorsUtils.whiteDarker,
          ),
          border: const OutlineInputBorder(),
        ),
        keyboardType: _keyboardType,
        obscureText: _obscureText);
  }
}
