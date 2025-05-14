import 'package:auth_mappers/constants/api_key.dart';
import 'package:auth_mappers/constants/strings.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

class PlacesWebServices {
  late final Dio dio;
  PlacesWebServices(){
    final BaseOptions options = BaseOptions(
      connectTimeout: Duration(seconds: 20),
      receiveTimeout: Duration(seconds: 20),
      receiveDataWhenStatusError: true
    );
    dio = Dio(options);
  }
  Future<List<dynamic>> fetchSuggestions(String place,String sessionTokn)async{
    try{
      Response response = await dio.get(urlPlaceApi,queryParameters: {
        'key':mapKey,
        'input':place,
        'sessiontoken':sessionTokn,
        'type':'address',
        'components':'country:eg'
      });
      return response.data["predictions"];
    }catch(e){
      debugPrint(e.toString());
      return [];
    }
  }
}