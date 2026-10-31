import 'package:flutter/material.dart';

/// Displays detailed information about a contact.
class ContactDetailsView extends StatelessWidget {
  const ContactDetailsView({required this.contactMap, super.key});

  final Map<String, dynamic> contactMap;
  static const routeName = '/contact_details';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Details'),
      ),
      restorationId: 'contactDetailsView',
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 16.0,
              ),
              ContactDetail(
                label: 'First Name: ',
                value: contactMap['firstName'] ?? '',
              ),
              ContactDetail(
                label: 'Last Name: ',
                value: contactMap['lastName'] ?? '',
              ),
              ContactDetail(
                label: 'Phone: ',
                value: contactMap['phoneNumber'] ?? '',
              ),
              ContactDetail(
                label: 'Email: ',
                value: contactMap['email'] ?? '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContactDetail extends StatelessWidget {
  const ContactDetail({
    required this.label,
    required this.value,
    super.key,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
      ],
    );
  }
}
