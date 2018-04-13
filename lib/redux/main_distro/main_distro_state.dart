import 'package:distrowatchapp/data/loading_status.dart';
import 'package:distrowatchapp/data/models/main_distro.dart';
import 'package:meta/meta.dart';

@immutable
class MainDistroState {
  MainDistroState({
    @required this.loadingStatus,
    @required this.mainDistros,
  });

  final LoadingStatus loadingStatus;
  final List<MainDistro> mainDistros;

  factory MainDistroState.initial() {
    return new MainDistroState(
      loadingStatus: LoadingStatus.loading,
      mainDistros: <MainDistro>[],
    );
  }

  MainDistroState copyWith({
    LoadingStatus loadingStatus,
    List<DateTime> availableDates,
    List<MainDistro> mainDistros,
  }) {
    return new MainDistroState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      mainDistros: mainDistros ?? this.mainDistros,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is MainDistroState &&
              runtimeType == other.runtimeType &&
              loadingStatus == other.loadingStatus &&
              mainDistros == other.mainDistros;

  @override
  int get hashCode =>
      loadingStatus.hashCode ^
      mainDistros.hashCode;
}
