import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required TextEditingController controller,
    required FocusNode focusNode,
    void Function(String)? onFieldSubmitted,
    required String labelText,
    required bool isPassword
  }) : 
    _controller = controller, 
    _focusNode = focusNode ,
    _onFieldSubmitted = onFieldSubmitted,
    _labelText = labelText,
    _isPassword = isPassword;

  final TextEditingController _controller;
  final FocusNode _focusNode;
  final void Function(String)? _onFieldSubmitted;
  final String _labelText;
  final bool _isPassword;

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      controller: _controller,
      focusNode: _focusNode,
      decoration: InputDecoration(
        labelText: _labelText,
        labelStyle: TextStyle(color: Color.fromRGBO(156, 112, 74, 1)),
        filled: true,
        fillColor: Color.fromRGBO(245, 237, 232, 1),
        border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(20))
      ),
      textInputAction: TextInputAction.next,
      onFieldSubmitted: _onFieldSubmitted,
      onTapOutside: (event) {
        _focusNode.unfocus();
      },
      obscureText: _isPassword,
    );
  }
}