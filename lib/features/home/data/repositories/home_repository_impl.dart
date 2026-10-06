import '../../domain/entities/home_data.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_datasource.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeLocalDataSource dataSource;

  const HomeRepositoryImpl({required this.dataSource});

  @override
  Future<HomeDataEntity> getHomeData() async {
    return await dataSource.fetchHomeData();
  }
}
