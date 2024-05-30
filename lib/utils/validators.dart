class Validators {
  static String? lengthValidator(String? text, [int length = 8]) {
    if (text != null && text.length > length) {
      return 'Invalid length';
    }
    return null;
  }

  static String? required(String? text) {
    if (text == null || text.isEmpty) {
      return 'Field required';
    }
    return null;
  }

  static String? emailValidator(String? email) {
    if (email == null ||
        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      return 'Invalid email format';
    }
    return null;
  }

  static String? passwordValidator(String? password) {
    if (password == null ||
        !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
            .hasMatch(password)) {
      return 'Invalid password format';
    }
    return null;
  }
}
