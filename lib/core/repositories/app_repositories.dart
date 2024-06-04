part of repositories;

abstract class AppRepository {
  Future<dynamic> demoApi();
}

class AppRepositoryIml extends BaseRepository implements AppRepository {
  final _appService = AppService(ApiClient.dio);

// Add your api here
  @override
  Future<dynamic> demoApi() async {
    return request(_appService.demoApi());
  }
}
