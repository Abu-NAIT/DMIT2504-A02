import 'package:flutter/material.dart';
import 'package:week_06_contacts_mgr/src/contacts/contact_add_view.dart';

import '../settings/settings_view.dart';
import 'contact.dart';
import 'contact_details_view.dart';
import 'contact_manager.dart';

/// Displays a list of SampleItems.
class ContactListView extends StatefulWidget {
  const ContactListView({
    super.key,
  });

  static const routeName = '/';
  final contactManager = ContactManager.instance;

  @override
  State<ContactListView> createState() => _ContactListViewState();
}

class _ContactListViewState extends State<ContactListView> {
  List<Contact> contacts = <Contact>[];

  // Get all contacts for display
  @override
  void initState() {
    super.initState();
    try {
      widget.contactManager.getContacts().then((contacts) {
        setState(() {
          this.contacts = contacts;
        });
      });
    } catch (e) {
      print(e);
    }
  }

  // When a contact is added, update the list of contacts
  void _addContact(int id) {
    widget.contactManager.getContact(id).then((contact) {
      setState(() {
        contacts.add(contact!);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Contacts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the new contact view to add a new contact.
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return ContactAddView(addContactCallback: _addContact);
              },
            ),
          );
        },
        tooltip: 'Add a contact',
        child: const Icon(Icons.add),
      ),

      // To work with lists that may contain a large number of items, it’s best
      // to use the ListView.builder constructor.
      //
      // In contrast to the default ListView constructor, which requires
      // building all Widgets up front, the ListView.builder constructor lazily
      // builds Widgets as they’re scrolled into view.
      body: ListView.builder(
        // Providing a restorationId allows the ListView to restore the
        // scroll position when a user leaves and returns to the app after it
        // has been killed while running in the background.
        restorationId: 'contactListView',
        itemCount: contacts.length,
        itemBuilder: (BuildContext context, int index) {
          final contact = contacts[index];

          return ListTile(
              title: Text('${contact.firstName} ${contact.lastName}'),
              // leading: const CircleAvatar(
              //   // Display the Flutter Logo image asset.
              //   foregroundImage: AssetImage('assets/images/flutter_logo.png'),
              // ),
              onTap: () {
                // Navigate to the details page. If the user leaves and returns to
                // the app after it has been killed while running in the
                // background, the navigation stack is restored.
                Navigator.restorablePushNamed(
                  context,
                  ContactDetailsView.routeName,
                  arguments: contact.toMap(),
                );
              });
        },
      ),
    );
  }
}
