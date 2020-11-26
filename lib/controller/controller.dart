import "package:mobx/mobx.dart";
part "controller.g.dart";

class Controller = ControllerBase with _$Controller;

abstract class ControllerBase with Store {
  @observable
  int numeroDeClicks = 0;

  increment() {
    numeroDeClicks++;
  }

  @action
  addClick() {
    numeroDeClicks++;
  }
}
