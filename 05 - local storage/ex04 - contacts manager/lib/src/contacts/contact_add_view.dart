import 'package:flutter/material.dart';

import 'contact.dart';
import 'contact_manager.dart';

class ContactAddView extends StatelessWidget {
  const ContactAddView({
    this.addContactCallback,
    super.key,
  });

  // Callback receives the id of the newly added contact
  final void Function(int)? addContactCallback;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Contact'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ContactAddForm(callback: addContactCallback),
        ),
      ),
    );
  }
}

// a Form widget for adding a new contact into the database
class ContactAddForm extends StatefulWidget {
  const ContactAddForm({
    this.callback,
    super.key,
  });

  final void Function(int)? callback;

  @override
  State<ContactAddForm> createState() => _ContactAddFormState();
}

class _ContactAddFormState extends State<ContactAddForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Add TextFormFields and ElevatedButton here.
          ContactFirstNameField(firstNameController: firstNameController),
          ContactLastNameField(
            lastNameController: lastNameController,
          ),
          ContactPhoneField(
            phoneController: phoneController,
          ),
          ContactEmailField(
            emailController: emailController,
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // Add the new contact to the database
                try {
                  ContactManager.instance
                      .addContact(Contact(
                        firstName: firstNameController.text,
                        lastName: lastNameController.text.isNotEmpty
                            ? lastNameController.text
                            : null,
                        phoneNumber: phoneController.text.isNotEmpty
                            ? phoneController.text
                            : null,
                        email: emailController.text.isNotEmpty
                            ? emailController.text
                            : null,
                      ))
                      .then((id) => widget.callback!(id));

                  Navigator.pop(context);
                } on Exception catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error adding contact: $e'),
                    ),
                  );
                }
              }
            },
            child: const Text('Add Contact'),
          ),
        ],
      ),
    );
  }
}

// a text field for the contact's name
class ContactFirstNameField extends StatelessWidget {
  const ContactFirstNameField({
    required this.firstNameController,
    super.key,
  });

  final TextEditingController firstNameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: firstNameController,
      decoration: const InputDecoration(
        hintText: 'Enter your contact\'s name',
        labelText: 'First Name',
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your contact\'s name';
        }
        return null;
      },
    );
  }
}

// a text field for the contact's last name
class ContactLastNameField extends StatelessWidget {
  const ContactLastNameField({
    required this.lastNameController,
    super.key,
  });

  final TextEditingController lastNameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: lastNameController,
      decoration: const InputDecoration(
        hintText: 'Enter your contact\'s name',
        labelText: 'Last Name',
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your contact\'s name';
        }
        return null;
      },
    );
  }
}

// a text field for the contact's phone number
class ContactPhoneField extends StatelessWidget {
  const ContactPhoneField({
    required this.phoneController,
    super.key,
  });

  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: phoneController,
      decoration: const InputDecoration(
        hintText: 'Enter your contact\'s phone number',
        labelText: 'Phone',
      ),
      validator: (value) {
        // validates using  regex for phone number
        if (value!.isNotEmpty &&
            !RegExp(r'^\(\d{3}\) \d{3}-\d{4}$').hasMatch(value)) {
          return 'Please enter the corrct format (###) ###-####';
        }
        return null;
      },
    );
  }
}

// a text field for the contact's email
class ContactEmailField extends StatelessWidget {
  const ContactEmailField({
    required this.emailController,
    super.key,
  });

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailController,
      decoration: const InputDecoration(
        hintText: 'Enter your contact\'s email',
        labelText: 'Email',
      ),
      validator: (value) {
        // validates using  regex for email
        if (value!.isNotEmpty &&
            !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }
}
