import '../interfaces/screen.interface.dart';

class MenuScreen implements Screen {
  @override
  late bool openNewScreen;
  MenuScreen() {
    openNewScreen = false;
  }
}
