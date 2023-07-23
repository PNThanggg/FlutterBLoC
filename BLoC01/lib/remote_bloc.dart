import 'dart:async';

part 'remote_event.dart';
part 'remote_state.dart';

class RemoteBloc {
  var state = RemoteState(0);

  // quản lý event, đảm nhận nhiệm vụ nhận event từ UI
  final eventController = StreamController<RemoteEvent>();

  // quản lý state, đảm nhận nhiệm vụ truyền state đến UI
  final stateController = StreamController<RemoteState>();

  RemoteBloc() {
    // lắng nghe khi eventController push event mới
    eventController.stream.listen((RemoteEvent event) {
      if (event is InitEven) {
        state = RemoteState(event.intiValue);
      } else if (event is IncrementEvent) {
        // nếu eventController vừa add vào 1 IncrementEvent thì chúng ta xử lý tăng âm lượng
        state = RemoteState(state.volume + event.increment);
      } else if (event is DecrementEvent) {
        // xử lý giảm âm lượng
        state = RemoteState(state.volume - event.decrement);
      } else {
        // xử lý mute
        state = RemoteState(0);
      }

      // add state mới vào stateController để bên UI nhận được
      stateController.sink.add(state);
    });
  }

  void dispose() {
    stateController.close();
    eventController.close();
  }
}
