import 'package:flutter/material.dart';


class PasswordInput extends StatefulWidget {

  // we need to pass two things to a custom field:
  //  - a controller (so that the outer form using it can read its values)
  //  - a label for the field (not necessary, but may as well make it flexible)
  final TextEditingController controller;
  final String label;

  const PasswordInput({
    super.key,
    required this.controller,
    this.label = 'Password',
  });


  @override
  State<PasswordInput> createState() => _PasswordInputState();
}


class _PasswordInputState extends State<PasswordInput> {

  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}
