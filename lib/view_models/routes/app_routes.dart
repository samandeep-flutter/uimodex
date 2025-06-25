// ignore_for_file: constant_identifier_names

sealed class _AppRoutes {
  static const String ROOT = 'root-view';
  static const String THEME = 'theme';
}

sealed class AppRoutes {
  // root routes
  static const String ROOT = '/${_AppRoutes.ROOT}';
  static const String THEME = '/${_AppRoutes.THEME}';
}
