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
          child: Consumer(
            builder: (context, ref, _) {
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
                      labelText: LatAndLon.latitude.label,
                      hintText: LatAndLon.latitude.hintText,
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
                      labelText: LatAndLon.longitude.label,
                      hintText: LatAndLon.longitude.hintText,
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: viewModel.digitsController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      labelText: '桁数（0〜9）',
                    ),
                    maxLength: 1,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'geoHash:${ref.watch(mainViewModelProvider.select((value) => value.geoHashString))}',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(height: 64),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

enum LatAndLon {
  latitude,
  longitude,
}

extension LatAndLonExt on LatAndLon {
  String get label {
    switch (this) {
      case LatAndLon.latitude:
        return '緯度(-90.0 ~ 90.0)';
      case LatAndLon.longitude:
        return '経度（-180.0 ~ 180.0）';
    }
  }

  String get hintText {
    switch (this) {
      case LatAndLon.latitude:
        return '例）35.4875';
      case LatAndLon.longitude:
        return '例）139.458';
    }
  }
}
