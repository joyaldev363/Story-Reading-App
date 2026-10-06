import '../../../app/router/route_names.dart';
import '../data/splash_local_datasource.dart';

class CheckInitialRouteUseCase {
  final SplashLocalDatasource datasource;

  CheckInitialRouteUseCase(this.datasource);

  Future<String> execute() async {
    final isFirst = await datasource.isFirstLaunch();
    if (isFirst) {
      return RouteNames.onboarding;
    }
    final hasToken = await datasource.hasAuthToken();
    if (hasToken) {
      return RouteNames.home;
    }
    return RouteNames.home;
  }
}
