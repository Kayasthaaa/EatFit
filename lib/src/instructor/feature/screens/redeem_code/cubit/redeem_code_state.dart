part of 'redeem_code_cubit.dart';

@immutable
abstract class RedeemCodeState {}

class RedeemCodeInitial extends RedeemCodeState {}

class RedeemCodeLoading extends RedeemCodeState {}

class RedeemCodeSuccess extends RedeemCodeState {
  final RedeemCodeModels redeemCodeModels;
  RedeemCodeSuccess(this.redeemCodeModels);
}

class RedeemCodeError extends RedeemCodeState {}

class RedeemCodeNoInternet extends RedeemCodeState {}
