import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('boolean hash test', (){
    List<String> falseHashes = [];
    List<String> trueHashes = [];

    for (var i = 0; i < 5; i++){
      bool trueHash = true;
      bool falseHash = false;

      final hashValue1 = trueHash.hashCode.toString();
      final hashValue2 = falseHash.hashCode.toString();

      trueHashes.add(hashValue1);
      falseHashes.add(hashValue2);
    }

    debugPrint('=== trueHashes ===');
    debugPrint('$trueHashes');
    debugPrint('=== falseHashes ===');
    debugPrint('$falseHashes');
  });
}