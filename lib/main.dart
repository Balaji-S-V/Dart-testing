import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biometric Button Example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Biometric Button Example'),
        ),
        body: Center(
          child: BiometricButton(),
        ),
      ),
    );
  }
}

class BiometricButton extends StatelessWidget {
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  Future<void> _authenticate(BuildContext context) async {
    if (Platform.isIOS) {
      // iOS supports Touch ID and Face ID
      bool authenticated = false;
      try {
        authenticated = await _localAuthentication.authenticate(
          localizedReason: 'Please authenticate to continue',
          useErrorDialogs: true,
          stickyAuth: true,
        );
      } on PlatformException catch (e) {
        print(e);
      }

      if (authenticated) {
        print('User authenticated');
      } else {
        print('Authentication failed');
      }
    } else if (Platform.isAndroid) {
      // Android supports fingerprint authentication
      try {
        bool canCheckBiometrics = await _localAuthentication.canCheckBiometrics;
        if (canCheckBiometrics) {
          bool authenticated = false;
          try {
            authenticated = await _localAuthentication.authenticate(
              localizedReason: 'Please authenticate to continue',
              useErrorDialogs: true,
              stickyAuth: true,
            );
          } on PlatformException catch (e) {
            print(e);
          }

          if (authenticated) {
            print('User authenticated');
          } else {
            print('Authentication failed');
          }
        } else {
          // Fingerprint authentication not available on this device
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Fingerprint authentication not available on this device.'),
            ),
          );
        }
      } on PlatformException catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _authenticate(context),
      child: Text('Authenticate'),
    );
  }
}
