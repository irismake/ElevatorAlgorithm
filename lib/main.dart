//import 'package:main_elevator/main_elevator.dart' as main_elevator;
import 'dart:io';
import 'dart:math';

void main() {
  int elevatorMax = 14;
  int elevatorMin = -5;
  int elvFloor_1, elvDest_1, elvDir_1, elvVia_1;
  int min, max;
  int rnd;
  int myDir;
  int moveTime = 1;
  int waitTime = 2;
  int finalTime;
  int viaNumber = 0;

  List<int> via = [];

//나의 층, 목적지 입력하기
  print("Input your floor");
  int? myFloor = int.parse(stdin.readLineSync()!);
  print("Input your destination");
  int? myDest = int.parse(stdin.readLineSync()!);
  if (myFloor < elevatorMin ||
      myFloor > elevatorMax ||
      myDest < elevatorMin ||
      myDest > elevatorMax ||
      myDest == myFloor) {
    print("ERROR");
    return;
  }
  print("Your floor : $myFloor");
  print("Your destination : $myDest");

  if (myDest < myFloor) {
    print("Your direction is down\n");
    myDir = -1;
  } else {
    print("Your direction is up\n");
    myDir = 1;
  }

//엘리베이터 움직임 난수로 출력
  elvFloor_1 = Random().nextInt(14) - 5;
  elvDest_1 = Random().nextInt(14) - 5;

  print("Elevator floor is $elvFloor_1");
  print("Elevator destination is $elvDest_1");

  if (elvDest_1 < elvFloor_1) {
    print("Elevator direction is down\n");
    elvDir_1 = -1;
    min = elvDest_1;
    max = elvFloor_1;
  } else if (elvDest_1 > elvFloor_1) {
    print("Elevator direction is up\n");
    elvDir_1 = 1;
    max = elvDest_1;
    min = elvFloor_1;
  } else {
    print("ERROR");
    return;
  }

  if (max - min - 1 == 0) {
    elvVia_1 = 0;
  } else {
    elvVia_1 = Random().nextInt(max - min - 1);
  }

  print("The number of stops in the elevator is $elvVia_1");
  while (via.length < elvVia_1) {
    if (via.length >= elvVia_1) break;

    rnd = Random().nextInt(max - 1) + (min + 1);

    if (!via.contains(rnd)) {
      via.add(rnd);
    }
  }
  via.sort();
  print("The floor to pass is $via\n");

//엘리베이터 방향 , 나의 방향 비교
  if (myDir != elvDir_1) {
    //다른 방향일때
    finalTime = moveTime * (max - min) +
        waitTime * via.length +
        (elvDest_1 - myFloor).abs() * moveTime;
    print("elevator direction != my direction \n It takes $finalTime\n");
  } else {
    //같은 방향일때
    if ((min < myFloor) && (myFloor <= max)) {
      // 나를 경유할때

      //올라갈때
      if (elvDir_1 == 1) {
        for (int i = 0; i < via.length; i++) {
          int a = via[i];

          if (a >= myFloor) {
            break;
          }
          viaNumber++;
        }
      } else {
        List<int> reversedVia = List.from(via.reversed);
        //내려갈때
        for (int i = 0; i < reversedVia.length; i++) {
          int a = reversedVia[i];

          if (a <= myFloor) {
            break;
          }
          viaNumber++;
        }
      }
      print("wait $viaNumber times\n");

      finalTime = moveTime * (min - myFloor).abs() + viaNumber * waitTime;
      print("the elevator goes through me\n");
    } else if (myFloor == min) {
      return;
    } else {
      // 나를 경유하지 않을때
      finalTime = moveTime * (max - min) +
          waitTime * via.length +
          (elvDest_1 - myFloor).abs() * moveTime;
      print("the elevator dosen't go through me\n");
    }
    print("elevator direction == my direction \n\nIt takes $finalTime");
  }
}
