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
  }) = _MainViewModelState;
}

class MainViewModel extends StateNotifier<MainViewModelState> {
  MainViewModel() : super(const MainViewModelState()) {
    _listen();
  }

  final latController = TextEditingController();
  final lonController = TextEditingController();
  final digitsController = TextEditingController();

  double get inputLatitude => double.tryParse(latController.text) ?? -999.9;
  double get inputLongitude => double.tryParse(lonController.text) ?? -999.9;
  int? get digits => int.tryParse(digitsController.text);

  bool get isRightLat => inputLatitude >= -90.0 && inputLatitude <= 90.0;
  bool get isRightLon => inputLongitude >= -180.0 && inputLongitude <= 180.0;
  bool get isRightDigits => digits != null && digits! <= 9;

  bool get canConvert => isRightLat && isRightLon && isRightDigits;

  void _listen() {
    latController
        .addListener(() => canConvert ? _calculateGeoHash() : _clearGeoHash());
    lonController
        .addListener(() => canConvert ? _calculateGeoHash() : _clearGeoHash());
    digitsController
        .addListener(() => canConvert ? _calculateGeoHash() : _clearGeoHash());
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
    int latDigits = (digits! * 5 / 2).floor();
    int lonDigits = (digits! * 5 / 2).ceil();
    print('latDigits:$latDigits');
    print('lonDigits:$lonDigits');

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

    //二分探索計算
    //緯度
    while (binaryLatitude.length < latDigits) {
      final midLad = midLatitude();
      if (inputLatitude < midLad) {
        binaryLatitude = '${binaryLatitude}0';
        maxLatitude = midLad;
      } else {
        binaryLatitude = '${binaryLatitude}1';
        minLatitude = midLad;
      }
    }

    //経度
    while (binaryLongitude.length < lonDigits) {
      final midLon = midLongitude();
      if (inputLongitude < midLon) {
        binaryLongitude = '${binaryLongitude}0';
        maxLongitude = midLon;
      } else {
        binaryLongitude = '${binaryLongitude}1';
        minLongitude = midLon;
      }
    }

    //緯度経度の二進数での値の結合確認
    print('binaryLatitude:$binaryLatitude');
    print('binaryLongitude:$binaryLongitude');
    int i = 0;
    String totalBinaryStr = '';
    while (i < latDigits) {
      totalBinaryStr = totalBinaryStr + binaryLongitude[i] + binaryLatitude[i];
      i++;
    }
    if (i < lonDigits) {
      totalBinaryStr = totalBinaryStr + binaryLongitude[i];
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
    const digits = 5;
    while (end < binaryStr.length) {
      totalBinaryList.add(binaryStr.substring(start, end));
      start += digits;
      end += digits;
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
    var alphabetList =
        List.generate(26, (index) => String.fromCharCode(index + 97)).toList();
    alphabetList
        .removeWhere((e) => e == 'a' || e == 'i' || e == 'l' || e == 'o');
    print(alphabetList);
    var result = '';
    var i = 0;
    while (i < digits!) {
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
