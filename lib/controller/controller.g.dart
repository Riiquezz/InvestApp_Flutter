// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Controller on ControllerBase, Store {
  final _$numeroDeClicksAtom = Atom(name: 'ControllerBase.numeroDeClicks');

  @override
  int get numeroDeClicks {
    _$numeroDeClicksAtom.context.enforceReadPolicy(_$numeroDeClicksAtom);
    _$numeroDeClicksAtom.reportObserved();
    return super.numeroDeClicks;
  }

  @override
  set numeroDeClicks(int value) {
    _$numeroDeClicksAtom.context.conditionallyRunInAction(() {
      super.numeroDeClicks = value;
      _$numeroDeClicksAtom.reportChanged();
    }, _$numeroDeClicksAtom, name: '${_$numeroDeClicksAtom.name}_set');
  }

  final _$ControllerBaseActionController =
      ActionController(name: 'ControllerBase');

  @override
  dynamic addClick() {
    final _$actionInfo = _$ControllerBaseActionController.startAction();
    try {
      return super.addClick();
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }
}
