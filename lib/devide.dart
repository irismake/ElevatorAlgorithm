import 'dart:io';
import 'dart:math';

void main() {
  List<int> oddFloor = [-5, -4, -3, -2, -1, 1, 3, 5, 7, 9, 11, 13, 15];
  List<int> evenFloor = [-5, -4, -3, -2, -1, 1, 2, 4, 6, 8, 10, 12, 14, 15];

  int elevatorMin = -5;
  int elevatorMax = 15;
  int? myDir;
  int? evenElevator, oddElevator;

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

  myClass myclass = myClass(evenFloor, oddFloor, myDir, myFloor);

  if (evenFloor.contains(myDest) && evenFloor.contains(myFloor)) {
    myclass.even();
    evenElevator = myclass.numberOfCasesEven();
  }
  if (oddFloor.contains(myDest) && oddFloor.contains(myFloor)) {
    myclass.odd();
    oddElevator = myclass.numberOfCasesOdd();
  }
  if (evenElevator != null && oddElevator != null) {
    if (evenElevator < oddElevator) {
      print("Take the even-numbered floor elevator\n");
    } else if (evenElevator > oddElevator) {
      print("Take the odd-numbered floor elevator\n");
    } else if (evenElevator == oddElevator) {
      print("Take any elevator :)\n");
    }
  }
}

class myClass {
  myClass(this.evenFloor, this.oddFloor, this.myDir, this.myFloor);
  List evenFloor;
  List oddFloor;
  int myDir;
  int myFloor;
  int? evenMin;
  int? evenMax;
  int? oddMin;
  int? oddMax;
  int? evenDir, oddDir;
  int? evenViaListMin, evenViaListMax;

  List<int> evenViaList = [];
  List<int> evenVia = [];
  List<int> oddViaList = [];
  List<int> oddVia = [];

  even() {
    print("---------- Even-numbered elevator ----------");
    int evenRnd = Random().nextInt(14) + 1; // 1~14 ??? ???????????? ????????? ?????? ?????? ??????

    while (evenRnd > evenViaList.length) {
      int ran = Random().nextInt(13); // list ?????? ????????????

      if (!evenViaList.contains(ran)) {
        evenViaList.add(ran);
      }
    }

    evenViaList.sort(); //??????

    for (int i = 0; i < evenViaList.length; i++) {
      int x = evenFloor[evenViaList[i]];
      evenVia.add(x);
    }

    print("The floors that even-numbered elevators pass through is $evenVia");
    evenMin = evenVia.first;
    evenMax = evenVia.last;
    evenDir = Random().nextInt(1);
  }

  odd() {
    print("---------- Odd-numbered elevator ----------");
    int oddRnd = Random().nextInt(13) + 1; // 1~13 ??? ???????????? ?????? ?????? ??????

    while (oddRnd > oddViaList.length) {
      int ran = Random().nextInt(12); // list ?????? ????????????

      if (!oddViaList.contains(ran)) {
        oddViaList.add(ran);
      }
    }

    oddViaList.sort();

    for (int i = 0; i < oddViaList.length; i++) {
      int x = oddFloor[oddViaList[i]];
      oddVia.add(x);
    }

    print("The floors that even-numbered elevators pass through is $oddVia");

    oddMin = oddVia.first;
    oddMax = oddVia.last;
    oddDir = Random().nextInt(1);
  }

  numberOfCasesEven() {
    int? evenDest, evenStart;
    int finalTime;
    int moveTime = 1;
    int waitTime = 2;
    int via = evenVia.length - 2;
    int viaNumber = 0;
    int waitNumber;
    int? evenViaPath;
    int? evenMovePath;
    if (evenDir == 0) {
      //down
      evenDest = evenMin;
      evenStart = evenMax;
      print("Elevator direction is down");
    } else {
      //up
      evenDest = evenMax;
      evenStart = evenMin;
      print("Elevator direction is up");
    }

    if (evenDest! * evenStart! < -1) {
      evenMovePath = (evenDest - evenStart).abs() - 1;
    } else if (evenDest * evenStart == -1) {
      evenMovePath = 1;
    } else {
      evenMovePath = (evenDest - evenStart).abs();
    }

    if (evenVia.length <= 2) {
      waitNumber = 0;
    } else {
      waitNumber = evenVia.length - 2;
      // ?????????????????? ???????????? ?????? ???
    }

    if (myDir != evenDir) {
      //?????? ????????????
      if (evenDest * myFloor < -1) {
        evenViaPath = (evenDest - myFloor).abs() - 1;
      } else if (evenDest * myFloor == -1) {
        evenViaPath == 1;
      } else {
        evenViaPath = (evenDest - myFloor).abs();
      }

      finalTime = moveTime * evenMovePath +
          waitTime * waitNumber +
          evenViaPath! * moveTime;
      print(
          "elevator direction != my direction \nEven-numbered elevator takes $finalTime\n");
    } else {
      //?????? ????????????
      if ((evenDest < myFloor) && (myFloor < evenStart)) {
        // ?????? ????????????
        print("the elevator goes through me");

        if (evenDir == 1) {
          //?????? ??????, ?????? ??????, ????????????
          for (int i = 1; i < via; i++) {
            int a = evenVia[i];

            if (a >= myFloor) {
              break;
            }
            viaNumber++;
          }
          if (evenStart * myFloor <= -1) {
            evenViaPath = (evenStart - myFloor).abs() - 1;
          } else {
            evenViaPath = (evenStart - myFloor).abs();
          }
          print("pass $viaNumber times");
          finalTime = moveTime * evenViaPath + viaNumber * waitTime;
        } else {
          List<int> reversedVia = List.from(evenVia.reversed);
          //?????? ??????, ?????? ??????, ????????????
          for (int i = 1; i < reversedVia.length; i++) {
            int a = reversedVia[i];

            if (a <= myFloor) {
              break;
            }
            viaNumber++;
          }
          if (evenStart * myFloor <= -1) {
            evenViaPath = (evenStart - myFloor).abs() - 1;
          } else {
            evenViaPath = (evenStart - myFloor).abs();
          }
          print("pass $viaNumber times");
          finalTime = moveTime * evenViaPath + viaNumber * waitTime;
        }
      } else if (myFloor == evenStart) {
        finalTime = 0;
      } else {
        // ?????? ???????????? ?????????
        if (evenDest * myFloor < -1) {
          evenViaPath = (evenDest - myFloor).abs() - 1;
        } else if (evenDest * myFloor == -1) {
          evenViaPath = 1;
        } else {
          evenViaPath = (evenDest - myFloor).abs();
        }
        finalTime = moveTime * evenMovePath.abs() +
            waitTime * waitNumber +
            evenViaPath * moveTime;

        print("the elevator dosen't go through me\n");
      }
      print(
          "elevator direction == my direction \nEven-numbered elevator takes $finalTime\n");
    }
    return finalTime;
  }

  numberOfCasesOdd() {
    int? oddDest, oddStart;
    int finalTime;
    int moveTime = 1;
    int waitTime = 2;
    int via = oddVia.length - 2;
    int viaNumber = 0;
    int waitNumber;
    int? oddViaPath;
    int? oddMovePath;
    if (oddDir == 0) {
      //down
      oddDest = oddMin;
      oddStart = oddMax;
      print("Elevator direction is down");
    } else {
      //up
      oddDest = oddMax;
      oddStart = oddMin;
      print("Elevator direction is up");
    }

    if (oddDest! * oddStart! < -1) {
      oddMovePath = (oddDest - oddStart).abs() - 1;
    } else if (oddDest * oddStart == -1) {
      oddMovePath = 1;
    } else {
      oddMovePath = (oddDest - oddStart).abs();
    }

    if (oddVia.length <= 2) {
      waitNumber = 0;
    } else {
      waitNumber = oddVia.length - 2;
      // ?????????????????? ???????????? ?????? ???
    }

    if (myDir != oddDir) {
      //?????? ????????????
      if (oddDest * myFloor < -1) {
        oddViaPath = (oddDest - myFloor).abs() - 1;
      } else if (oddDest * myFloor == -1) {
        oddViaPath == 1;
      } else {
        oddViaPath = (oddDest - myFloor).abs();
      }

      finalTime = moveTime * oddMovePath +
          waitTime * waitNumber +
          oddViaPath! * moveTime;
      print(
          "elevator direction != my direction \nOdd-numbered elevator takes $finalTime\n");
    } else {
      //?????? ????????????
      if ((oddDest < myFloor) && (myFloor < oddStart)) {
        // ?????? ????????????
        print("the elevator goes through me");

        if (oddDir == 1) {
          //?????? ??????, ?????? ??????, ????????????
          for (int i = 1; i < via; i++) {
            int a = oddVia[i];

            if (a >= myFloor) {
              break;
            }
            viaNumber++;
          }
          if (oddStart * myFloor <= -1) {
            oddViaPath = (oddStart - myFloor).abs() - 1;
          } else {
            oddViaPath = (oddStart - myFloor).abs();
          }
          print("pass $viaNumber times");
          finalTime = moveTime * oddViaPath + viaNumber * waitTime;
        } else {
          List<int> reversedVia = List.from(oddVia.reversed);
          //?????? ??????, ?????? ??????, ????????????
          for (int i = 1; i < reversedVia.length; i++) {
            int a = reversedVia[i];

            if (a <= myFloor) {
              break;
            }
            viaNumber++;
          }
          if (oddStart * myFloor <= -1) {
            oddViaPath = (oddStart - myFloor).abs() - 1;
          } else {
            oddViaPath = (oddStart - myFloor).abs();
          }
          print("pass $viaNumber times");
          finalTime = moveTime * oddViaPath + viaNumber * waitTime;
        }
      } else if (myFloor == oddStart) {
        finalTime = 0;
      } else {
        // ?????? ???????????? ?????????
        if (oddDest * myFloor < -1) {
          oddViaPath = (oddDest - myFloor).abs() - 1;
        } else if (oddDest * myFloor == -1) {
          oddViaPath = 1;
        } else {
          oddViaPath = (oddDest - myFloor).abs();
        }
        finalTime = moveTime * oddMovePath.abs() +
            waitTime * waitNumber +
            oddViaPath * moveTime;

        print("the elevator dosen't go through me\n");
      }
      print(
          "elevator direction == my direction\nOdd-numbered elevator takes $finalTime\n");
    }
    return finalTime;
  }
}
