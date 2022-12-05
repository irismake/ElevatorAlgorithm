import 'dart:io';
import 'dart:math';

void main() {
  List<int> oddFloor = [-5, -4, -3, -2, -1, 1, 3, 5, 7, 9, 11, 13, 15];
  List<int> evenFloor = [-5, -4, -3, -2, -1, 1, 2, 4, 6, 8, 10, 12, 14, 15];

  int elevatorMin = -5;
  int elevatorMax = 15;
  int? myDir;

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
    myDir = 0;
  } else {
    print("Your direction is up\n");
    myDir = 1;
  }

  myClass myclass = myClass(evenFloor, oddFloor, myDir, myFloor);

  if (myDest % 2 == 0) {
    myclass.even();
  } else {
    myclass.odd();
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
    int evenRnd = Random().nextInt(14) + 1; // 1~13 중 랜덤으로 경유 숫자 선택

    print(evenRnd);

    while (evenRnd > evenViaList.length) {
      int ran = Random().nextInt(13); // list 원소 가져오기

      if (!evenViaList.contains(ran)) {
        evenViaList.add(ran);
      }
    }

    evenViaList.sort(); //정렬
    evenViaListMax = evenViaList.first;
    evenViaListMin = evenViaList.last;
    print(evenViaList);
    print(evenViaListMax);
    print(evenViaListMin);

    for (int i = 0; i < evenViaList.length; i++) {
      int x = evenFloor[evenViaList[i]];
      evenVia.add(x);
    }

    print(evenVia);
    evenMin = evenVia.first;
    evenMax = evenVia.last;
    evenDir = Random().nextInt(1);
  }

  odd() {
    int oddRnd = Random().nextInt(12) + 1; // 1~12 중 랜덤으로 경유 숫자 선택

    print(oddRnd);

    while (oddRnd > oddViaList.length) {
      int ran = Random().nextInt(11); // list 원소 가져오기

      if (!oddViaList.contains(ran)) {
        oddViaList.add(ran);
      }
    }

    oddViaList.sort();
    print(oddViaList);

    for (int i = 0; i < oddViaList.length; i++) {
      int x = oddFloor[oddViaList[i]];
      oddVia.add(x);
    }

    print(oddVia);
    oddMin = oddVia[0];
    oddMax = oddVia[oddRnd - 1];

    oddDir = Random().nextInt(1);
  }

  numberOfCasesEven() {
    int? evenDest, evenStart;
    int finalTime;
    int moveTime = 1;
    int waitTime = 2;
    int via = evenVia.length - 2;
    int viaNumber = 0;

    if (evenDir == 0) {
      //down
      evenDest = evenMin;
      evenStart = evenMax;
    } else {
      //up
      evenDest = evenMax;
      evenStart = evenMin;
    }

    if (myDir != evenDir) {
      //다른 방향일때
      finalTime = moveTime * (evenViaListMax! - evenViaListMin!) +
          waitTime * (evenVia.length) +
          (evenDest! - myFloor).abs() * moveTime;
      print("elevator direction != my direction \n It takes $finalTime\n");
    } else {
      //같은 방향일때
      if ((evenDest! < myFloor) && (myFloor < evenStart!)) {
        // 나를 경유할때
        print("the elevator goes through me\n");
        //올라갈때
        if (evenDir == 1) {
          for (int i = 1; i < via; i++) {
            int a = evenVia[i];

            if (a >= myFloor) {
              break;
            }
            viaNumber++;
          }
          print("wait $viaNumber times\n");
          finalTime = moveTime * (evenViaListMax! - evenViaListMin!).abs() +
              viaNumber * waitTime;
        } else {
          List<int> reversedVia = List.from(evenVia.reversed);
          //내려갈때
          for (int i = 1; i < reversedVia.length; i++) {
            int a = reversedVia[i];

            if (a <= myFloor) {
              break;
            }
            viaNumber++;
          }
          print("wait $viaNumber times\n");
          finalTime = moveTime * (evenViaListMax! - evenViaListMin!).abs() +
              viaNumber * waitTime;
        }

        print("the elevator goes through me\n");
      } else if (myFloor == evenStart!) {
        finalTime = 0;
      } else {
        // 나를 경유하지 않을때
        finalTime = moveTime * (evenViaListMax! - evenViaListMin!).abs() +
            waitTime * evenVia.length +
            (evenDest - myFloor).abs() * moveTime;
        print("the elevator dosen't go through me\n");
      }
      print("elevator direction == my direction \n\nIt takes $finalTime");
    }
  }
}
