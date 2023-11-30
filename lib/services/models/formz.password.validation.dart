import 'package:formz/formz.dart';

// Define input validation errors
enum PasswordInputError { empty, tooShort, needNumbers, needCapitals }

class PasswordInput extends FormzInput<String, PasswordInputError> {
  // Call super.pure to represent an unmodified form input.
  const PasswordInput.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const PasswordInput.dirty({String value = ''}) : super.dirty(value);

  // Override validator to handle validating a given input value.
  @override
  PasswordInputError? validator(String value) {
    if (value.isEmpty) {
      return PasswordInputError.empty;
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return PasswordInputError.needCapitals;
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return PasswordInputError.needNumbers;
    }
    if (value.length < 6) {
      return PasswordInputError.tooShort;
    }

    return null;
  }
}
