import 'dart:html';
import 'dart:collection';



class Keyboard {
  Keyboard() {
    window.onKeyDown.listen((KeyboardEvent e) {
      _keys.putIfAbsent(e.keyCode, () => e.timeStamp);
    });
    window.onKeyUp.listen((KeyboardEvent e) {
      _keys.remove(e.keyCode);
    });
  }
  
  HashMap<int, num> _keys = new HashMap<int, num>();
  bool isPressed(int keyCode) => _keys.containsKey(keyCode);
}