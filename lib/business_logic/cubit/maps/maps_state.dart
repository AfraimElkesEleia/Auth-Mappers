part of 'maps_cubit.dart';

@immutable
sealed class MapsState {}

final class MapsInitial extends MapsState {}

final class PlacesLoaded extends MapsState{
  final List<PlaceSuggestion> suggestions;
  PlacesLoaded({required this.suggestions});
}