import 'package:bloc/bloc.dart';
import 'package:bloc_06/common/utils/app_log.dart';
import 'package:meta/meta.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(const SignInState()) {
    AppLog.info({
      "Sign In bloc",
      state.email,
      state.password,
    });

    on<EmailEvent>((event, emit) => _emailEvent);
    on<PasswordEvent>((event, emit) => _passwordEvent);
  }

  void _emailEvent(EmailEvent event, Emitter<SignInState> emit) {
    AppLog.debug(event.email, tag: "Update email");

    emit(
      state.copyWith(
        email: event.email,
      ),
    );
  }

  void _passwordEvent(PasswordEvent event, Emitter<SignInState> emit) {
    AppLog.debug(event.password, tag: "Update password");

    emit(
      state.copyWith(
        password: event.password,
      ),
    );
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);

    AppLog.error(error, tag: "SignIn Bloc onError");
  }

  @override
  void onChange(Change<SignInState> change) {
    super.onChange(change);

    AppLog.info("{${change.currentState} -> {${change.nextState}}", tag: "SignIn Bloc onChange");
  }

  @override
  void onTransition(Transition<SignInEvent, SignInState> transition) {
    super.onTransition(transition);

    AppLog.info(transition, tag: "SignIn Bloc onTransition");
  }
}
