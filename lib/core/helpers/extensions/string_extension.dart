extension StringExtensions on String {

  /// MARK: [toSvg] uygulama içerisinde assets/icons/ klasörüne kısa erişim
  String get toSvg => 'assets/icons/ic_$this.svg';
}
