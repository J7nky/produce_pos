import 'package:form_field_validator/form_field_validator.dart';

class Validators {
  /// Email Validator
  static final email = EmailValidator(errorText: 'Enter a valid email address');

  /// Password Validator
  static final password = MultiValidator([
    RequiredValidator(errorText: 'Password is required'),
    MinLengthValidator(8, errorText: 'Password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'Passwords must have at least one special character')
  ]);

  /// Required Validator with Optional Field Name
  static RequiredValidator requiredWithFieldName(String? fieldName) =>
      RequiredValidator(errorText: '${fieldName ?? 'Field'} is required!');

  /// Plain Required Validator
  static final required = RequiredValidator(errorText: 'Field is required');
  static String? lebanesePhoneValidator(String? value) {
    // Regular expression for Lebanese phone numbers (mobile and landline)
    final RegExp lebanesePhoneRegExp = RegExp(
      r'^(?:\+961|961|0)?(?:3|70|71|76|78|79|81|01|04|05|06|07|08|09)\d{6}$',
    );

    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    } else if (!lebanesePhoneRegExp.hasMatch(value)) {
      return 'Please enter a valid Lebanese phone number';
    }
    return null; // Return null if the phone number is valid
  }
}
