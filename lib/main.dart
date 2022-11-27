//import 'package:main_elevator/main_elevator.dart' as main_elevator;
import 'dart:io';
import 'dart:math';

void main() {
  int elvFloor_1, elvDest_1, elvDir_1, elvVia_1;
  int min, max;
  int rnd;
  int myDir;
  int timeStamp;
  List<int> via = [];

  print("Input your floor");
  int? myFloor = int.parse(stdin.readLineSync()!);
  print("Input your destination");
  int? myDest = int.parse(stdin.readLineSync()!);
  print("Your floor : $myFloor");
  print("Your destination : $myDest");

  if (myDest < myFloor) {
    print("Your direction is down");
    myDir = -1;
  } else {
    print("Your direction is up");
    myDir = 1;
  }
  elvFloor_1 = Random().nextInt(15) - 5;
  elvDest_1 = Random().nextInt(15) - 5;
  //min = elvFloor_1 > elvDest_1 ? elvDest_1 : elvFloor_1;

  print("Elevator floor is $elvFloor_1");
  print("Elevator destination is $elvDest_1");

  if (elvDest_1 < elvFloor_1) {
    print("Elevator direction is down");
    elvDir_1 = -1;
    min = elvDest_1;
    max = elvFloor_1;
  } else {
    print("Elevator direction is up");
    elvDir_1 = 1;
    max = elvDest_1;
    min = elvFloor_1;
  }
  print(max);
  print(min);
  elvVia_1 = Random().nextInt(max - min - 1); // 멈출 층 갯수

  while (via.length < elvVia_1) {
    // 랜덤으로 번호를 생성해준다.

    if (via.length >= elvVia_1) break;
    rnd = Random().nextInt(max - 1) + (min + 1);
    print("The floor to pass is $rnd");
    // 만약 리스트에 생성된 번호가 없다면
    if (!via.contains(rnd)) {
      // 리스트에 추가해준다.
      via.add(rnd);
    }

    // 리스트의 길이가 6이면 while문을 종료한다.

  }

  print(via);

  print("Elevator via is $elvVia_1");
}
