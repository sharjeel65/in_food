class Validator {
  static String? validateEmail(String email) {
    RegExp emailRegExp =
        RegExp(r"([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})");

    if (email.isEmpty) {
      return 'Email can\'t be empty';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Enter a correct email';
    }
    return null;
  }

  static String? validateAmount(String amount) {
    RegExp emailRegExp = RegExp(r"(^[0-9]*$)");

    if (amount.isEmpty) {
      return 'value can\'t be empty';
    } else if (!emailRegExp.hasMatch(amount)) {
      return 'value must be a number';
    }
    return null;
  }

  static String? validateName(String name) {
    if (name.isEmpty) {
      return 'Name can\'t be empty';
    } else if (name.trim().split(' ').length < 2) {
      return 'Enter your full name';
    }
    return null;
  }

  static String? validatePassword(String value) {
    RegExp uppercaseRegExp = RegExp(r'[A-Z]');
    RegExp lowercaseRegExp = RegExp(r'[a-z]');
    RegExp numberRegExp = RegExp(r'\d');
    RegExp specialCharacterRegExp =
        RegExp(r"[~`!@#\$%\^&\*\(\)_\+\-\={}\[\]\\|:;<>,.?/]");

    if (value.isEmpty) {
      return 'Password is required';
    }

    List<String> errors = [];
    if (value.length < 8) {
      errors.add('Password must be at least 8 characters');
    }
    if (!uppercaseRegExp.hasMatch(value)) {
      errors.add('Password must contain at least one uppercase letter');
    }
    if (!lowercaseRegExp.hasMatch(value)) {
      errors.add('Password must contain at least one lowercase letter');
    }
    if (!numberRegExp.hasMatch(value)) {
      errors.add('Password must contain at least one number');
    }
    if (!specialCharacterRegExp.hasMatch(value)) {
      errors.add('Password must contain at least one special character');
    }

    if (errors.isNotEmpty) {
      String errorMessage = '';
      for (String error in errors) {
        if (errorMessage.isNotEmpty) {
          errorMessage += '\n';
        }
        errorMessage += error;
      }
      return errorMessage;
    }

    return null;
  }
}
