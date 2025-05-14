import 'package:auth_mappers/data/models/place_suggestion.dart';
import 'package:auth_mappers/data/repository/map_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'maps_state.dart';

class MapsCubit extends Cubit<MapsState> {
  final MapRepository mapRepository;
  MapsCubit({required this.mapRepository}) : super(MapsInitial());

  void emitPlaceSuggestion(String place,String sessiontoken){
    mapRepository.fetchSuggestions(place, sessiontoken).then((suggestions){
      emit(PlacesLoaded(suggestions: suggestions));
    });
  }
}
