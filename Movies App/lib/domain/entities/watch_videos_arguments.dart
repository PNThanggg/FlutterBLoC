import 'package:equatable/equatable.dart';

import 'video.dart';

class WatchVideosArguments extends Equatable {
  final List<Video> videos;

  const WatchVideosArguments({required this.videos});

  @override
  List<Object?> get props => [videos];
}
