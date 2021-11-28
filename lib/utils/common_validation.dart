class CommonValidation {
  static String? commonValidation(String name, String labelName) {
    if (name.isEmpty) {
      return '$labelName is required';
    }
    return null;
  }
}
