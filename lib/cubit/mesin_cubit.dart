import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_home/models/arduino.dart';

part 'mesin_state.dart';

class MesinCubit extends Cubit<Arduino> {
  MesinCubit() : super(null);

  void kirimdata(value) {
    emit(value);
  }
}

class IpCubit extends Cubit<String> {
  IpCubit() : super('');

  void setIp(value) {
    emit(value);
  }
}
