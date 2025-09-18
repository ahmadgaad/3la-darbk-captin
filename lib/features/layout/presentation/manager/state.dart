import 'package:equatable/equatable.dart';

class LayoutState extends Equatable {
  final int index;

  const LayoutState({ this.index=0});

  LayoutState copyWith({int? index}) =>
        LayoutState(index: index ?? this.index);
        
          @override
          List<Object?> get props => [
            index
          ];
}
