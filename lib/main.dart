import 'dart:io';
import 'dart:math';

void main() {
  List<int> elevatorFloor = [
    -5,
    -4,
    -3,
    -2,
    -1,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15
  ];

  int elevatorMin = -5;
  int elevatorMax = 15;
  int? myDir;
  int elevatorWaitingTime;

  print("\nInput your floor");
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
    myDir = 0;
  } else {
    print("Your direction is up\n");
    myDir = 1;
  }

  myClass myclass = myClass(elevatorFloor, myDir, myFloor);

  myclass.elevator();
  elevatorWaitingTime = myclass.numberOfCases();
  print(elevatorWaitingTime);
}

class myClass {
  myClass(this.elevatorFloor, this.myDir, this.myFloor);
  List elevatorFloor;
  int myDir;
  int myFloor;
  int? Min;
  int? Max;
  int? elevatorDir;

  List<int> elvViaList = [];
  List<int> elvVia = [];

  elevator() {
    print("---------- elevator ----------");
    int evenRnd = Random().nextInt(20) + 1; // 1~20 중 랜덤으로 경유할 층의 개수 선택

    while (evenRnd > elvViaList.length) {
      int ran = Random().nextInt(19); // list 원소 가져오기

      if (!elvViaList.contains(ran)) {
        elvViaList.add(ran);
      }
    }

    elvViaList.sort(); //정렬

    for (int i = 0; i < elvViaList.length; i++) {
      int x = elevatorFloor[elvViaList[i]];
      elvVia.add(x);
    }

    print("The floors that elevators pass through is $elvVia");
    Min = elvVia.first;
    Max = elvVia.last;
    elevatorDir = Random().nextInt(1);
  }

  numberOfCases() {
    int? elvDest, elvStart;
    int finalTime;
    int moveTime = 1;
    int waitTime = 2;
    int via = elvVia.length - 2;
    int passedViaNumber = 0;
    int viaNumber;
    int? pathToMyFloor;
    int? MovePath;
    if (elevatorDir == 0) {
      //down
      elvDest = Min;
      elvStart = Max;
      print("Elevator direction is down");
    } else {
      //up
      elvDest = Max;
      elvStart = Min;
      print("Elevator direction is up");
    }

    if (elvDest! * elvStart! < -1) {
      MovePath = (elvDest - elvStart).abs() - 1;
    } else if (elvDest * elvStart == -1) {
      MovePath = 1;
    } else {
      MovePath = (elvDest - elvStart).abs();
    }

    if (elvVia.length <= 2) {
      viaNumber = 0;
    } else {
      viaNumber = elvVia.length - 2;
      // 엘리베이터가 경우하는 층의 수
    }

    if (myDir != elevatorDir) {
      //다른 방향일때
      if (elvDest * myFloor < -1) {
        pathToMyFloor = (elvDest - myFloor).abs() - 1;
      } else if (elvDest * myFloor == -1) {
        pathToMyFloor == 1;
      } else {
        pathToMyFloor = (elvDest - myFloor).abs();
      }

      finalTime = moveTime * MovePath +
          waitTime * viaNumber +
          pathToMyFloor! * moveTime;
      print(
          "elevator direction != my direction \nEven-numbered elevator takes $finalTime\n");
    } else {
      //같은 방향일때
      if ((elvDest < myFloor) && (myFloor < elvStart)) {
        // 나를 경유할때
        print("The elevator goes through me");

        if (elevatorDir == 1) {
          //같은 방향, 나를 경유, 올라갈때
          for (int i = 1; i < via; i++) {
            int a = elvVia[i];

            if (a >= myFloor) {
              break;
            }
            passedViaNumber++;
          }
          if (elvStart * myFloor <= -1) {
            pathToMyFloor = (elvStart - myFloor).abs() - 1;
          } else {
            pathToMyFloor = (elvStart - myFloor).abs();
          }
          print("Pass $passedViaNumber times");
          finalTime = moveTime * pathToMyFloor + passedViaNumber * waitTime;
        } else {
          List<int> reversedVia = List.from(elvVia.reversed);
          //같은 방향, 나를 경유, 내려갈때
          for (int i = 1; i < reversedVia.length; i++) {
            int a = reversedVia[i];

            if (a <= myFloor) {
              break;
            }
            passedViaNumber++;
          }
          if (elvStart * myFloor <= -1) {
            pathToMyFloor = (elvStart - myFloor).abs() - 1;
          } else {
            pathToMyFloor = (elvStart - myFloor).abs();
          }
          print("Pass $passedViaNumber times");
          finalTime = moveTime * pathToMyFloor + passedViaNumber * waitTime;
        }
      } else if (myFloor == elvStart) {
        finalTime = 0;
      } else {
        // 나를 경유하지 않을때
        if (elvDest * myFloor < -1) {
          pathToMyFloor = (elvDest - myFloor).abs() - 1;
        } else if (elvDest * myFloor == -1) {
          pathToMyFloor = 1;
        } else {
          pathToMyFloor = (elvDest - myFloor).abs();
        }
        finalTime = moveTime * MovePath +
            waitTime * viaNumber +
            pathToMyFloor * moveTime;

        print("the elevator dosen't go through me\n");
      }
      print("elevator direction == my direction \nElevator takes $finalTime\n");
    }
    return finalTime;
  }
}
