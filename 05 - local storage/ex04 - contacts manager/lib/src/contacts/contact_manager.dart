import 'contact.dart';

/// A manager class for the contacts.
/// Currently stores contacts in memory only.
/// Supports reading a single contact by id,
/// reading all contacts, adding a new contact,
/// and updating an existing contact.
class ContactManager {
  ContactManager._();

  static final ContactManager instance = ContactManager._();
  static final List<Contact> _contacts = [];
  static int _nextId = 1;

  /// Returns a contact with the given [id].
  /// Throws an [Exception] if the contact cannot be found.
  Future<Contact?> getContact(int id) async {
    try {
      return _contacts.firstWhere((c) => c.id == id);
    } catch (_) {
      throw Exception('ID $id not found');
    }
  }

  /// Returns a list of all contacts.
  /// The list is ordered by last name, first name.
  Future<List<Contact>> getContacts() async {
    final sorted = List<Contact>.from(_contacts);
    sorted.sort((a, b) {
      final lastCmp = (a.lastName ?? '').compareTo(b.lastName ?? '');
      if (lastCmp != 0) return lastCmp;
      return a.firstName.compareTo(b.firstName);
    });
    return sorted;
  }

  /// Adds a new contact.
  /// Returns the id of the newly added contact.
  Future<int> addContact(Contact contact) async {
    contact.id = _nextId++;
    _contacts.add(contact);
    return contact.id!;
  }

  /// Updates an existing contact.
  /// Returns the number of contacts updated (0 or 1).
  Future<int> updateContact(Contact contact) async {
    final index = _contacts.indexWhere((c) => c.id == contact.id);
    if (index == -1) return 0;
    _contacts[index] = contact;
    return 1;
  }
}
