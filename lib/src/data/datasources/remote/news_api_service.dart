import 'package:clean_architecture/src/core/utils/constants.dart';
import 'package:clean_architecture/src/data/models/breaking_news_response_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';

part 'news_api_service.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class NewsApiService {
  factory NewsApiService(Dio dio, {String baseUrl}) = _NewsApiService;

  @GET('/top-headlines')
  Future<HttpResponse<BreakingNewsResponseModel>> getBreakingNewsArticle({
    @Query('apiKey') required String apiKey,
    @Query('country') required String country,
    @Query('category') required String category,
    @Query('page') required int page,
    @Query('pageSize') required int pageSize,
  });
}
