import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:universy_mobile_client/com/universy/views/main/bloc/navigation-events.dart';
import 'package:universy_mobile_client/com/universy/views/main/bloc/navigation-states.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  @override
  NavigationState get initialState => InitialState();

  @override
  Stream<NavigationState> mapEventToState(
      NavigationEvent event,
      ) async* {
    if (event is InitialEvent) {
      yield InitialState();
    } else if (event is ProfileEvent){
      yield ProfileState(event.student);
    } else if (event is SubjectsEvent){
      yield StudentSubjectsState();
    }
  }
}