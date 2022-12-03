import 'dart:io';
import 'dart:math';

void main() {
  int oddRnd;
  int evenMax;
  int oddMin, oddMax;

  List<int> oddFloor = [-5, -4, -3, -2, -1, 1, 3, 5, 7, 9, 11, 13, 15];
  List<int> evenFloor = [-5, -4, -3, -2, -1, 1, 2, 4, 6, 8, 10, 12, 14, 15];
  List<int> oddViaList = [];
  List<int> oddVia = [];

  oddRnd = Random().nextInt(13) + 1; // 1~13 중 랜덤으로

  myClass myclass = myClass(evenFloor);
  myclass.even();
  int evenMin = myclass.even();

  print(evenMin);
}

class myClass {
  myClass(
    this.evenFloor,
  );
  List evenFloor;
  int? evenMin;
  int? evenMax;

  even() {
    int evenRnd;

    List<int> evenViaList = [];
    List<int> evenVia = [];
    evenRnd = Random().nextInt(14) + 1; // 1~14 중 랜덤으로 경유 숫자 선택

    print(evenRnd);

    while (evenRnd > evenViaList.length) {
      int ran = Random().nextInt(13); // list 원소 가져오기

      if (!evenViaList.contains(ran)) {
        evenViaList.add(ran);
      }
    }

    evenViaList.sort();
    print(evenViaList);

    for (int i = 0; i < evenViaList.length; i++) {
      int x = evenFloor[evenViaList[i]];
      evenVia.add(x);
    }

    print(evenVia);
    evenMin = evenVia[0];
    evenMax = evenVia[evenRnd - 1];

    return evenMin;
  }
}
