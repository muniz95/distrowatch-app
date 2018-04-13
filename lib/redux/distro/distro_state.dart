import 'package:distrowatchapp/data/loading_status.dart';
import 'package:distrowatchapp/data/models/distro.dart';
import 'package:meta/meta.dart';

@immutable
class DistroState {
  DistroState({
    @required this.loadingStatus,
    @required this.distros,
  });

  final LoadingStatus loadingStatus;
  final List<Distro> distros;

  factory DistroState.initial() {
    return new DistroState(
      loadingStatus: LoadingStatus.loading,
      distros: <Distro>[],
    );
  }

  DistroState copyWith({
    LoadingStatus loadingStatus,
    List<DateTime> availableDates,
    List<Distro> distros,
  }) {
    return new DistroState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      distros: distros ?? this.distros,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is DistroState &&
              runtimeType == other.runtimeType &&
              loadingStatus == other.loadingStatus &&
              distros == other.distros;

  @override
  int get hashCode =>
      loadingStatus.hashCode ^
      distros.hashCode;
}
