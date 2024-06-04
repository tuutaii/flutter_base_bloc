import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

import '../models/quote_model/quote_model.dart';
import '../utilities/string.dart';

part 'app_service.g.dart';

@RestApi()
@FormUrlEncoded()
abstract class AppService {
  factory AppService(Dio apiClient, {String baseUrl}) = _AppService;

  @GET(ApiUtils.demoApi)
  Future<QuoteList> demoApi();
}
