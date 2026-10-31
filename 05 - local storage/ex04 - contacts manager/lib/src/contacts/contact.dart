/// A contact model with first name, last name, email and phone number.
class Contact {
  Contact({
    required String firstName,
    lastName,
    email,
    phoneNumber,
    id,
  }) {
    this.firstName = firstName;
    lastName != null ? this.lastName = lastName : _lastName = null;
    email != null ? this.email = email : _email = null;
    phoneNumber != null ? this.phoneNumber = phoneNumber : _phoneNumber = null;
    id != null ? this.id = id : _id = null;
  }

  String? _firstName;
  String? _lastName;
  String? _email;
  String? _phoneNumber;
  int? _id;

  set firstName(String value) {
    if (value.trim().isEmpty) {
      throw Exception('First name cannot be empty');
    }

    _firstName = value.trim();
  }

  String get firstName => _firstName!;

  set lastName(String? value) {
    if (value == null || value.trim().isEmpty) {
      throw Exception('Last name cannot be empty');
    }

    _lastName = value.trim();
  }

  String? get lastName => _lastName;

  // phone number must be in the format (###) ###-####
  set phoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      throw Exception('Phone number cannot be empty');
    }

    if (!RegExp(r'^\(\d{3}\) \d{3}-\d{4}$').hasMatch(value)) {
      throw Exception('Phone number must be in the format (###) ###-####');
    }

    _phoneNumber = value;
  }

  String? get phoneNumber => _phoneNumber;

  // email must be in the format of an email address
  set email(String? value) {
    if (value == null || value.trim().isEmpty) {
      throw Exception('Email cannot be empty');
    }

    if (!RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(value)) {
      throw Exception('Email must be in the format of an email address');
    }

    _email = value;
  }

  String? get email => _email;

  set id(int? value) {
    if (value == null || value < 0) {
      throw Exception('Id cannot be null or negative');
    }

    _id = value;
  }

  int? get id => _id;

  // returns a Map/JSON representation of the contact
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }

  // Creates a contact from a Map/JSON representation
  // Throws an exception if the map does not contain the required firstName key
  factory Contact.fromMap(Map<String, dynamic> json) {
    if (json['firstName'] == null) {
      throw Exception('Required key: firstName is missing');
    }

    return Contact(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      id: json['id'],
    );
  }

  // returns a string representation of the contact
  @override
  String toString() {
    return 'Contact{firstName: $firstName, lastName: $lastName ${email != null ? ', email: $email' : ''} ${phoneNumber != null ? ', phoneNumber: $phoneNumber' : ''}';
  }
}
