import 'package:main_elevator/main_elevator.dart' as main_elevator;
import 'dart:io';

void main() {
  print("Input your floor");
  int? myDest = int.parse(stdin.readLineSync()!);
  print("Input your destination");
  int? myFloor = int.parse(stdin.readLineSync()!);
  print("Your floor : $myDest");
  print("Your destination : $myFloor");

  if (myDest - myFloor < 0) {
    print("down");
  } else {
    print("up");
  }
}
