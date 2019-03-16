import 'dart:html';
import 'dart:math';
import 'dart:async';
import '../Canvas.dart';
import '../Keyboard.dart';
import '../constants.dart';
import 'Snake.dart';



Canvas canvas = Canvas();
Keyboard keyboard = Keyboard();



class Game {
  Game({this.speed}) {
    init();
  }
  
  final num speed;

  num _lastTimeStamp = 0;
  Snake _snake;
  Point _food;

  void init() {
    _snake = Snake(initialLength: 5);
    _food = _randomPoint();
  }

  Future run() async {
    while(true) {
      update(await window.animationFrame);
    }
  }
  
  void update(num delta) {
    final num diff = delta - _lastTimeStamp;
    if (diff > speed) {
      _lastTimeStamp = delta;
      frame();
    }
  }

  void frame() {
    canvas.clear();
    canvas.drawCell(_food, FOOD_COLOR);
    canvas.drawScore((_snake.length-4) * 100);
    _snake.update(shouldGrow: _checkForCollisions());
  }
  
  bool _checkForCollisions() {
    _checkForLosingCollisions();
    return _checkForFoodCollision();
  }

  bool _checkForFoodCollision() {
    if (_snake.eatsFood(_food)) {
      _food = _randomPoint();
      return true;
    } else {
      return false;
    }
  }
  
  void _checkForLosingCollisions() {
    if (
      _snake.head.x <= -1 ||
      _snake.head.x >= canvas.rightEdgeX ||
      _snake.head.y <= -1 ||
      _snake.head.y >= canvas.bottomEdgeY ||
      _snake.checkForBodyCollision()
    ) {
      init();
    }    
  }

  Point _randomPoint() {
    Random random = Random();
    return Point(
      random.nextInt(canvas.rightEdgeX),
      random.nextInt(canvas.bottomEdgeY),
    );
  }

}