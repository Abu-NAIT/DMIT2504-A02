import 'package:flutter/material.dart';


class UsernameFormField extends StatefulWidget {

  // we need to pass two things to a custom field:
  //  - a controller (so that the outer form using it can read its values)
  //  - a label for the field (not necessary, but may as well make it flexible)
  final TextEditingController controller;
  final String label;

  const UsernameFormField({
    super.key,
    required this.controller,
    this.label = 'Username',
  });


  @override
  State<UsernameFormField> createState() => _UsernameFormFieldState();
}


class _UsernameFormFieldState extends State<UsernameFormField> {

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: (value) => value == null || value.trim() == ''
        ? 'Username cannot be empty'
        : null,
      decoration: InputDecoration(label: Text('Username'))
      // ideally we'd still have helper functions e.g. "requiredField"
    );
  }
}
