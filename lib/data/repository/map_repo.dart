import 'package:auth_mappers/data/models/place_suggestion.dart';
import 'package:auth_mappers/data/web_services/places_web_services.dart';
import 'package:flutter/cupertino.dart';

class MapRepository {
  late final PlacesWebServices placesWebServices;
  MapRepository({required this.placesWebServices});
  Future<List<PlaceSuggestion>> fetchSuggestions(String place,String sessionTokn)async{
      final suggestions = await placesWebServices.fetchSuggestions(place, sessionTokn);
      debugPrint(suggestions.toString());
      return suggestions.map((suggestion)=> PlaceSuggestion.fromJson(suggestion)).toList();
  }
}