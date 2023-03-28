import 'package:flutter/material.dart';

void main() => runAppp(MaterialApp
(
  debugShowCheckedModeBanner: false,
  home: FingerprintApp()
  ))


class FingerprintApp extends StatefulWidget {
  const FingerprintApp({super.key});

  @override
  State FingerprintApp> createState() =>  FingerprintAppState();
}

class  FingerprintAppState extends State FingerprintApp> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}