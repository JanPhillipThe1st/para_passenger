import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserState());
  void setUsername(String username) => emit(UserState(username: username));
  void setPassword(String password) => emit(UserState(password: password));
  void setName(String name) => emit(UserState(name: name));
}
