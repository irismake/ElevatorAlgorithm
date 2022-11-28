//import 'package:main_elevator/main_elevator.dart' as main_elevator;
import 'dart:io';
import 'dart:math';

void main() {
  int elvFloor_1, elvDest_1, elvDir_1, elvVia_1;
  int min, max;
  int rnd;
  int myDir;
  int moveTime = 1;
  int waitTime = 2;
  int finalTime;

  List<int> via = [];

//나의 층, 목적지 입력하기
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

//엘리베이터 움직임 난수로 출력
  elvFloor_1 = Random().nextInt(14) - 5;
  elvDest_1 = Random().nextInt(14) - 5;

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
  if (max - min - 1 == 0) {
    elvVia_1 = 0;
  } else {
    elvVia_1 = Random().nextInt(max - min - 1);
  }

  print(elvVia_1);
  while (via.length < elvVia_1) {
    if (via.length >= elvVia_1) break;

    rnd = Random().nextInt(max - 1) + (min + 1);

    if (!via.contains(rnd)) {
      via.add(rnd);
    }
  }
  print("The floor to pass is $via");

//엘리베이터 방향 , 나의 방향 비교
  if (myDir != elvDir_1) {
    //다른 방향일때
    finalTime = moveTime * (max - min) +
        waitTime * via.length +
        (elvDest_1 - myFloor).abs() * moveTime;
  } else {
    //같은 방향일때
    if ((min < myFloor) && (myFloor < max)) {
      // 나를 경유할때
      if (via.contains(myFloor)) {
        ;
      }
    } else {
      // 나를 경유하지 않을때
      finalTime = moveTime * (max - min) +
          waitTime * via.length +
          (elvDest_1 - myFloor).abs() * moveTime;
    }
  }
}
