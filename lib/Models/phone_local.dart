class PhoneLocal {
  /// This class is for the selection of the country and its phone number symbol.
  PhoneLocal({
    this.countryLocal = 'dz',
    this.countryCode = 213,
    this.flagPath,
  });

  /// Country local abreaviation
  ///
  ///
  /// For example:
  /// Algeria: 'dz'
  final String countryLocal;

  /// Phone number country code
  ///
  /// For example:
  /// Algeria: 213
  final int countryCode;

  /// Flag image path in the assets (Must be in pubspec.yaml)
  final String? flagPath;
}
