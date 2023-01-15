import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'main_view_model.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geohash_convert'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(80.0),
        child: Center(
          child: Consumer(builder: (context, ref, _) {
            final viewModel = ref.read(mainViewModelProvider.notifier);
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: viewModel.latitudeController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    labelText: '緯度',
                    hintText: '例）35.4875',
                  ),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: viewModel.longitudeController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    labelText: '経度',
                    hintText: '例）139.458',
                  ),
                ),
                const SizedBox(height: 24),
                const SizedBox(height: 24),
                DropdownButton(
                  items: const [
                    DropdownMenuItem(
                      value: 1,
                      child: Text('1'),
                    ),
                  ],
                  value: 1,
                  onChanged: (value) {
                    // setState(() {
                    // isSelectedValue = value!;
                    // });
                    print(0);
                  },
                ),
                Text(
                  'geoHash:${ref.watch(mainViewModelProvider.select((value) => value.geoHashString))}',
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(height: 64),
              ],
            );
          }),
        ),
      ),
    );
  }

  // final latitudeKey = Key;
  // final longtudeKey = Key;

  // String? _validateLatitude() {
  //   if (latitudeString.isEmpty) {
  //     return 'フォームに値を入力してください';
  //   }
  //   final latitudeInt = double.parse(latitudeString);
  //   if (latitudeInt > 90 || latitudeInt < -90) {
  //     return '-90から90の間の小数点を含む数字を入力してください';
  //   }
  //   return null;
  // }

  // String? _validateLongitude() {
  //   if (latitudeString.isEmpty) {
  //     return 'フォームに値を入力してください';
  //   }
  //   final longitudeInt = double.parse(latitudeString);
  //   if (longitudeInt > 180 || longitudeInt < -180) {
  //     return '-180から180の間の小数点を含む数字を入力してください';
  //   }
  //   return null;
  // }
}

enum LatAndLon {
  latitude,
  longitude,
}

extension LatAndLonExt on LatAndLon {
  String get name {
    switch (this) {
      case LatAndLon.latitude:
        return '緯度';
      case LatAndLon.longitude:
        return '経度';
    }
  }

  String get defaultValue {
    switch (this) {
      case LatAndLon.latitude:
        return '35.4875';
      case LatAndLon.longitude:
        return '139.458';
    }
  }

  // TextEditingController get controller {
  //   switch (this) {
  //     case LatAndLon.latitude:
  //       return latitudeController;
  //     case LatAndLon.longitude:
  //       return longitudeController;
  //   }
  // }

  // Key get key {
  //   switch (this) {
  //     case LatAndLon.latitude:
  //       return '35.4875';
  //     case LatAndLon.longitude:
  //       return '139.458';
  //   }
  // }
}
