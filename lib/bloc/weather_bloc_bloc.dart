import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
part 'weather_bloc_event.dart';
part 'weather_bloc_state.dart';

class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  WeatherBlocBloc() : super(WeatherBlocInitial()) {
    on<Fetchweaather>((event, emit) async {
       emit(WeatherBlocLoading());
      try{
        WeatherFactory wf= WeatherFactory('apiKey',language: Language.ENGLISH);
        Weather weather = await wf.currentWeatherByLocation(
         event.position. latitude,
         event.position.longitude
        );
        print(weather);
         emit(WeatherBlocSuccess( weather));
      }catch(e){
       emit(WeatherBlocFailure()); 
      }
    });
  }
}
