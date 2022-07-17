part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const FORECAST = _Paths.FORECAST;

}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const FORECAST = '/splash';
}
