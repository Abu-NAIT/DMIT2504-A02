import 'package:flutter/material.dart';


class PasswordFormField extends StatefulWidget {

  final TextEditingController controller;
  final String label;

  const PasswordFormField({
    super.key,
    required this.controller,
    this.label = 'Password',
  });


  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}


class _PasswordFormFieldState extends State<PasswordFormField> {

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: (value) => value == null || value.trim() == ''
        ? 'Password cannot be empty'
        : null,
      obscureText: true, 
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputDecoration(label: Text('Password'))
    );
  }
}
