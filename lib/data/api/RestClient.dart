import 'package:dio/dio.dart';
import 'package:rest_countries/data/models/Country.dart';
import 'package:retrofit/retrofit.dart';

part 'RestClient.g.dart';

@RestApi(
    baseUrl:
        'https://restcountries.com/v3.1/region/europe?fields=name,capital,flags,region,languages,population,capital')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/all')
  Future<List<Country>> getAllCountries();

}
