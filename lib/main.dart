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
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Geohash 変換'),
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
                      controller: viewModel.latController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        labelText: FormElement.latitude.label,
                        hintText: FormElement.latitude.hintText,
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: viewModel.lonController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        labelText: FormElement.longitude.label,
                        hintText: FormElement.longitude.hintText,
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
                        labelText: FormElement.digits.label,
                        hintText: FormElement.digits.hintText,
                      ),
                      maxLength: 1,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Geohash:${ref.watch(mainViewModelProvider.select((value) => value.geoHashString))}',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const SizedBox(height: 64),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

enum FormElement {
  latitude,
  longitude,
  digits,
}

extension FormElementExt on FormElement {
  String get label {
    switch (this) {
      case FormElement.latitude:
        return '緯度(-90.0 ~ 90.0)';
      case FormElement.longitude:
        return '経度（-180.0 ~ 180.0）';
      case FormElement.digits:
        return '桁数（0〜9）';
    }
  }

  String get hintText {
    switch (this) {
      case FormElement.latitude:
        return '例）35.4875';
      case FormElement.longitude:
        return '例）139.4580';
      case FormElement.digits:
        return '例）5';
    }
  }
}
