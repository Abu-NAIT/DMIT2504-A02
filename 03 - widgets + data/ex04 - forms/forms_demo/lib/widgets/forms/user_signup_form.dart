import 'package:flutter/material.dart';


class UserSignupForm extends StatefulWidget {
  
  const UserSignupForm({super.key});

  @override
  State<UserSignupForm> createState() => _UserSignupFormState();

}


class _UserSignupFormState extends State<UserSignupForm> {

  /* wtf is this?
      a) we need a unique identifier for the form, similar to how widgets instantiate with {super.key}
         we use these keys to access widgets/instances directly.
      b) GlobalKey allows element to move around tree w/o losing its state (e.g. mouse over super.key for more explanation)
      c) ok then why not GlobalKey<_UserSignupFormState> ? 
          -> the key needs to reach just the form's own state (which has validate(), save(), reset() ),
             *not* the state of the widget that contains it. Think about it as one stateful widget nested in another.
  */
  final _formKey = GlobalKey<FormState>(); // remember to ()  -> we want an instance of this, not the type itself
  // validation tells us if the input is *valid according to a condition*, not what the value *is* moment-to-moment. for that, we need text controllers
  final _usernameController = TextEditingController(); // tl;dr - if i want to read the values, i need to wire text controllers to form fields
  final _passwordController = TextEditingController(); // both of these are stateful, even if they're basically just glorified pointers


  FormFieldValidator<String?> requiredField(String fieldName) {
    // ternary gang: condition ? ifTrue : ifFalse
    return (value) => 
      value == null || value.trim().isEmpty // is it null OR is it blank when trimmed
      ? '$fieldName cannot be empty'  // value is bad:   return error message w/ dynamic fieldname
      : null;                         // value is gucci: return null
  }


  /*
    We have to manually call .dispose() on controllers because they hold on to various in-memory resources (e.g. listeners, mobile-native text editing state, etc.)
    that don't get automatically cleaned up if/when the widget is removed from the element tree. 
    Forgetting to do this is the el classico noob trap memory leak in a long-running app.
  */

  @override
  void dispose() {
    // State<T>.dispose() is the 'teardown/cleanup' method called whenever a stateful widget is removed from the element tree
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose(); // kind of backwards - I clean my stuff up FIRST, THEN clean up any potential superclass stuff
    // Usually you're used to seeing super.someMethod() *first* when we override a method(), because you're used to seeing *setup* behaviour.
    // For teardown behaviour, I do the parent .dispose() *last* because (instinctually) I don't want to risk tearing down base resources/hooks that my custom state rests on.
    // State<T>.dispose() has a @mustCallSuper decorator on it, so if you forget to write this, compiler will 'remind' you.
  }

  @override
  Widget build(BuildContext context) {
    // 1. wrap everything in a form. once I convert TextFields to TextFormFields, I can validate everything at once.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // code-writing style choice: you *can* compress stuff onto one line, if it's still easy to read
          
          const Text('New User Form', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
          
          /* 2. convert input fields to form fields, e.g. TextField -> TextFormField
                -> What do I get out of this?
                   a) a validation parameter, for validating the value
                   b) all FormFields plug into the Form wrapping them, so some button press / action
                      can validate every single one of its fields at once
          */
          TextFormField(
            controller: _usernameController,
            validator: requiredField('Username'),
            decoration: InputDecoration(label: Text('Username'))
          ),
          
          TextFormField(
            controller: _passwordController,
            validator: requiredField('Password'),
            obscureText: true, 
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(label: Text('Password')),
          ),
  
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {  // something! -> forced type assertion, aka playing with fire
              // sometimes, you run into a situation where you *know* that something *cannot possibly* be null, but the compiler doesn't
              // a.k.a. the "trust me bro" operator. see what happens when you take the ! out.

              // normally, we pass form data as e.g. a POST request to a server or something like that; this is just a responsive placeholder
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(
                    "Sent to MI6:\nUsername: ${_usernameController.text}\nPassword: ${_passwordController.text}"
                  ))
                  // I'm reading from state here just to show replacement feedback for what would otherwise be taking this form data
                  // and POSTing it to a server (which would also require being able to read the values directly.)
                );
              }
              // usually, you don't have fallback behaviour (i.e. an else clause) because the field errors get displayed if invalid.
              // you could write in additional behaviour on an }else{} if you wanted.
            },
            child: const Text('Sign Up'),
          ),

        ],
      ),
    );
  }
}