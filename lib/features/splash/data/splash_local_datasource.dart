abstract class SplashLocalDatasource {
  Future<bool> isFirstLaunch();
  Future<bool> hasAuthToken();
}

class SplashLocalDatasourceImpl implements SplashLocalDatasource {
  @override
  Future<bool> isFirstLaunch() async {
    return true;
  }

  @override
  Future<bool> hasAuthToken() async {
    return false;
  }
}
