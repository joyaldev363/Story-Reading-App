import '../../domain/check_initial_route.dart';
import '../../data/splash_local_datasource.dart';

class SplashController {
  final CheckInitialRouteUseCase checkInitialRouteUseCase;

  SplashController({CheckInitialRouteUseCase? useCase})
      : checkInitialRouteUseCase = useCase ??
            CheckInitialRouteUseCase(SplashLocalDatasourceImpl());

  Future<String> handleSplashNavigation() async {
    final results = await Future.wait([
      Future.delayed(const Duration(seconds: 3)),
      checkInitialRouteUseCase.execute(),
    ]);
    return results[1] as String;
  }
}
