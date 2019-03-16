import 'dart:html';
import 'constants.dart';



class Canvas {
  Canvas() {
    canvas = querySelector('#canvas');
    ctx = canvas.getContext('2d');
    rightEdgeX = canvas.width ~/ CELL_SIZE;
    bottomEdgeY = canvas.height ~/ CELL_SIZE;
  }

  CanvasElement canvas;
  CanvasRenderingContext2D ctx;
  int rightEdgeX;
  int bottomEdgeY;

  void drawCell(Point coords, String color) {
    final int x = coords.x * CELL_SIZE;
    final int y = coords.y * CELL_SIZE; 
    ctx.fillStyle = color;
    ctx.fillRect(x, y, CELL_SIZE, CELL_SIZE);
  }

  void clear() {
    ctx.fillStyle = BACKGROUND_COLOR;
    ctx.fillRect(0, 0, canvas.width, canvas.height);
  }

  void drawScore(int score) {
    ctx.fillStyle = 'white';
    ctx.font = 'bold 24px Serif';
    ctx.fillText('Score: $score', 8, 24);
  }
}