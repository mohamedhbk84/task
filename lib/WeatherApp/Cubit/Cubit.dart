import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/WeatherApp/Cubit/States.dart';
import 'package:task/WeatherApp/model/weather_model.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitionalStates());

  static AppCubit get(context) => BlocProvider.of(context);

  WeatherForecastModel forecastModel;
}
