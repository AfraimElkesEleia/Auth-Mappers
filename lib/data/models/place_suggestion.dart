class PlaceSuggestion {
  final String description;
  final String placeId;

  PlaceSuggestion({required this.description, required this.placeId});

  factory PlaceSuggestion.fromJson(json) {
    return PlaceSuggestion(
      description: json["description"],
      placeId: json["place_id"],
    );
  }
}
