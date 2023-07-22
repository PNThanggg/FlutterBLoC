import 'package:flutter/material.dart';

import 'native/native_channel.dart';
import 'remote_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final bloc = RemoteBloc(); // khởi tạo bloc

  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () async {
        int value = await NativeChannel().getCurrentVolume();
        // bloc.state = RemoteState(value);
        bloc.eventController.sink.add(InitEven(value));
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<RemoteState>(
          stream: bloc.stateController.stream,
          initialData: bloc.state,
          builder: (BuildContext context, AsyncSnapshot<RemoteState> snapshot) {
            return Text('Âm lượng hiện tại: ${snapshot.data?.volume}'); // update UI
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () async {
              await NativeChannel().adjustRaiseVolume();

              int value = await NativeChannel().getCurrentVolume();
              bloc.eventController.sink.add(InitEven(value));
            }, // add event
            child: const Icon(Icons.volume_up),
          ),
          const SizedBox(width: 6),
          FloatingActionButton(
            onPressed: () async {
              await NativeChannel().adjustLowerVolume();

              int value = await NativeChannel().getCurrentVolume();
              bloc.eventController.sink.add(InitEven(value));
            },
            child: const Icon(Icons.volume_down),
          ),
          const SizedBox(width: 6),
          FloatingActionButton(
            onPressed: () async {
              await NativeChannel().mute();

              int value = await NativeChannel().getCurrentVolume();
              bloc.eventController.sink.add(InitEven(value));
            }, // add event
            child: const Icon(Icons.volume_mute),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose(); // dispose bloc
  }
}
