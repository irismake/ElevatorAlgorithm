//import 'package:main_elevator/main_elevator.dart' as main_elevator;
import 'dart:io';
import 'dart:math';

void main() {
  int elvFloor_1, elvDest_1, elvDir_1;
  int myDir;
  int timeStamp;
  print("Input your floor");
  int? myFloor = int.parse(stdin.readLineSync()!);
  print("Input your destination");
  int? myDest = int.parse(stdin.readLineSync()!);
  print("Your floor : $myDest");
  print("Your destination : $myFloor");

  if (myDest - myFloor < 0) {
    print("down");
    myDir = -1;
  } else {
    print("up");
    myDir = 1;
  }
  elvFloor_1 = Random().nextInt(15) - 5;
  elvDest_1 = Random().nextInt(15) - 5;

  if (elvDest_1 - elvFloor_1 < 0) {
    print("down");
    elvDir_1 = -1;
  } else {
    print("up");
    elvDir_1 = 1;
  }

  if (myDir == elvDir_1) {
    // 같은 방향

  } else {}
}
