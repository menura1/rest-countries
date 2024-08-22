import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:rest_countries/data/models/country.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi(
  parser: Parser.FlutterCompute,
    baseUrl:
        'https://restcountries.com/v3.1/region/europe?fields=name,capital,flags,region,languages,population,capital')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/all')
  Future<List<Country>> getAllCountries();

}
