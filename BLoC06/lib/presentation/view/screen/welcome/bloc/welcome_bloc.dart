import 'package:bloc/bloc.dart';
import 'package:bloc_06/common/utils/app_log.dart';

part 'welcome_event.dart';

part 'welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(WelcomeInitial()) {
    AppLog.info("Welcome bloc");

    on<WelcomeEvent>((event, emit) {
      emit(WelcomeState(page: state.page));
    });
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);

    AppLog.error(error, tag: "Welcome Bloc onError");
  }

  @override
  void onChange(Change<WelcomeState> change) {
    super.onChange(change);

    AppLog.info("{${change.currentState.toString()}} -> {${change.nextState.toString()}}", tag: "Welcome Bloc onChange");
  }

  @override
  void onTransition(Transition<WelcomeEvent, WelcomeState> transition) {
    super.onTransition(transition);

    AppLog.info(transition, tag: "Welcome Bloc onTransition");
  }

  @override
  Future<void> close() {
    AppLog.info("Welcome Bloc onClose");

    return super.close();
  }
}
