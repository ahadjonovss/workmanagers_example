part of 'movement_cubit.dart';

@immutable
abstract class MovementState {}

class MovementInitial extends MovementState {}


class GotMovementInProgress extends MovementState{}

class GotMovementInSuccess extends MovementState{
  List<MovementModel> movements;
  GotMovementInSuccess({required this.movements});
}
