import 'dart:math';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'main_view_model.freezed.dart';

final mainViewModelProvider =
    StateNotifierProvider<MainViewModel, MainViewModelState>((ref) {
  final mainViewModel = MainViewModel();
  return mainViewModel;
});

@freezed
class MainViewModelState with _$MainViewModelState {
  const factory MainViewModelState({
    @Default('') geoHashString,
    String? firstName,
  }) = _MainViewModelState;
}

class MainViewModel extends StateNotifier<MainViewModelState> {
  MainViewModel() : super(const MainViewModelState()) {
    _listen();
  }

  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();

  double get inputLatitude =>
      double.tryParse(latitudeController.text) ?? -999.9;
  double get inputLongitude =>
      double.tryParse(longitudeController.text) ?? -999.9;

  bool get isRightLat => inputLatitude > -90.0 && inputLatitude < 90.0;
  bool get isRightLon => inputLongitude > -180.0 && inputLongitude < 180.0;

  bool get canConvert => isRightLat && isRightLon;

  void _listen() {
    latitudeController.addListener(() {
      canConvert ? _calculateGeoHash() : _clearGeoHash();
    });
    longitudeController.addListener(() {
      canConvert ? _calculateGeoHash() : _clearGeoHash();
    });
  }

  void _clearGeoHash() {
    state = state.copyWith(geoHashString: '');
  }

  void _calculateGeoHash() {
    final binaryStr = _toBinaryStr();
    final binaryList = _toBinaryList(binaryStr);
    final decimalList = _toDecimalList(binaryList);
    final hexString = _toHexString(decimalList);
    state = state.copyWith(geoHashString: hexString);
  }

  String _toBinaryStr() {
    //二分探索初期設定
    //緯度
    var minLatitude = -90.0;
    var maxLatitude = 90.0;
    double midLatitude() => (minLatitude + maxLatitude) / 2;
    var binaryLatitude = '';

    //経度
    var minLongitude = -180.0;
    var maxLongitude = 180.0;
    double midLongitude() => (minLongitude + maxLongitude) / 2;
    var binaryLongitude = '';

    //確認
    print('latitude');
    print('min|mid|max = $minLatitude|$midLatitude()|$maxLatitude');

    print('longitude');
    print('min|mid|max = $minLongitude|$midLongitude()|$maxLongitude');

    //二分探索計算
    //緯度
    while (binaryLatitude.length < 16) {
      print('binaryLatitude:$binaryLatitude');
      print('min|mid|max = $minLatitude|$midLatitude|$maxLatitude');

      if (inputLatitude < midLatitude()) {
        binaryLatitude = '${binaryLatitude}0';
        maxLatitude = midLatitude();
        midLatitude;
      } else {
        binaryLatitude = '${binaryLatitude}1';
        minLatitude = midLatitude();
      }
    }

    //経度
    while (binaryLongitude.length < 16) {
      print('binaryLongitude:$binaryLongitude');

      if (inputLongitude < midLongitude()) {
        binaryLongitude = '${binaryLongitude}0';
        maxLongitude = midLongitude();
      } else {
        binaryLongitude = '${binaryLongitude}1';
        minLongitude = midLongitude();
      }
    }

    //緯度経度の二進数での値の結合確認
    print('binaryLatitude:$binaryLatitude');
    print('binaryLongitude:$binaryLongitude');
    int i = 0;
    String totalBinaryStr = '';
    while (i < 16) {
      totalBinaryStr = totalBinaryStr + binaryLongitude[i] + binaryLatitude[i];
      i++;
    }
    print('totalBinaryStr:$totalBinaryStr');
    return totalBinaryStr;
  }

  List _toDecimalList(binaryList) {
    var l = 0;
    var decimalList = [];
    while (l < binaryList.length) {
      var i = 0;
      int value = 0;

      while (i < 5) {
        final tempValue = int.parse(binaryList[l][i]) * pow(2, 4 - i).toInt();
        value += tempValue;
        i++;
      }
      decimalList.add(value);
      l++;
    }
    print(decimalList);
    return decimalList;
  }

  List _toBinaryList(String binaryStr) {
    // 二進数を5桁ずつに分ける
    var totalBinaryList = [];
    var start = 0;
    var end = 5;
    const length = 5;
    while (end < binaryStr.length) {
      totalBinaryList.add(binaryStr.substring(start, end));
      start += length;
      end += length;
    }
    var lastStr = binaryStr.substring(start, binaryStr.length);
    while (lastStr.length < 5) {
      lastStr += '0';
    }
    totalBinaryList.add(lastStr);

    print(totalBinaryList);
    return totalBinaryList;
  }

  String _toHexString(decimalList) {
    // final value =
    var alphabetList =
        List.generate(25, (index) => String.fromCharCode(index + 97)).toList();
    alphabetList
        .removeWhere((e) => e == 'a' || e == 'i' || e == 'l' || e == 'o');
    print(alphabetList);
    // print(value);
    var result = '';
    var i = 0;
    while (i < 5) {
      if (decimalList[i] < 10) {
        result = result + decimalList[i].toString();
      } else if (decimalList[i] >= 10 && decimalList[i] < 32) {
        result = result + alphabetList[decimalList[i] - 10];
      }
      i++;
    }
    print('result:$result');
    return result;
  }
}
