import 'dart:html';
import 'dart:math';
import '../Canvas.dart';
import '../Keyboard.dart';
import '../constants.dart';



Canvas canvas = Canvas();
Keyboard keyboard = Keyboard();



class Snake {
  Snake({this.initialLength}) {
    _body = List<Point>.generate(initialLength, 
      (int i) => new Point(initialLength - 1 - i, 9)
    );
  }
  
  final int initialLength;

  static const Point LEFT = const Point(-1, 0);
  static const Point RIGHT = const Point(1, 0);
  static const Point UP = const Point(0, -1);
  static const Point DOWN = const Point(0, 1);
  
  List<Point> _body;
  Point _dir = RIGHT;
  int _growthDebt = 0;
  
  Point get head => _body.first;
  int get length => _body.length;
  
  void update({bool shouldGrow = false}) {
  	_handleInput();
    _move(grow: shouldGrow);
    _draw();
  }
  
  void _draw() {
    for (Point p in _body) {
      canvas.drawCell(p, SNAKE_COLOR);
    }
  }
 
  void _move({bool grow = false}) {
    _moveForward();
    if (grow == true) {
      _growthDebt += _body.length;
    }
    if (_growthDebt == 0) {
      _body.removeLast();
    } else {
      _growthDebt -= 1;
    }
  }
  
  void _moveForward() => _body.insert(0, head+_dir);

  bool checkForBodyCollision() {
    for (Point p in _body.skip(1)) {
      if (p == head) {
        return true;
      }
    }
    return false;
  }

  bool eatsFood(Point food) => _body.first == food;

  void _handleInput() {
    if (keyboard.isPressed(KeyCode.LEFT) && _dir != RIGHT) {
      _dir = LEFT;
    } else if (keyboard.isPressed(KeyCode.RIGHT) && _dir != LEFT) {
      _dir = RIGHT;
    } else if (keyboard.isPressed(KeyCode.UP) && _dir != DOWN) {
      _dir = UP;
    } else if (keyboard.isPressed(KeyCode.DOWN) && _dir != UP) {
      _dir = DOWN;
    }
  }
  
}