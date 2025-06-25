import 'package:uimodex/view/root_view.dart';
import 'package:uimodex/view/change_theme.dart';
import 'package:uimodex/view_models/routes/app_routes.dart';

sealed class AppPages {
  static String initial = AppRoutes.ROOT;

  static final routes = {
    AppRoutes.ROOT: (_) => RootView(),
    AppRoutes.THEME: (_) => ChangeTheme(),
  };
}
