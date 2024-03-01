import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:local_auth_android/local_auth_android.dart';

import '../Blocs/change_theme/change_theme_bloc.dart';

class FingerPrintScreen extends StatefulWidget {
  const FingerPrintScreen({Key? key}) : super(key: key);

  @override
  State<FingerPrintScreen> createState() => _FingerPrintScreenState();
}

class _FingerPrintScreenState extends State<FingerPrintScreen> {
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  bool _isFingerprintEnabled = false;

  final LocalAuthentication auth = LocalAuthentication();

  @override
  void initState() {
    super.initState();
    _loadFingerprintStatus();
  }

  Future<void> authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Scan your fingerprint to authenticate',
        authMessages: [
          const AndroidAuthMessages(
            signInTitle: 'Oops! authentication required!',
          ),
        ],
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );

      if (authenticated) {
        // Fingerprint authentication succeeded. Save the enabled status.
        _saveFingerprintStatus(true);
      } else {
        // Fingerprint authentication failed. Handle as needed.
        _saveFingerprintStatus(false);
      }
    } catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e}';
      });
      return;
    }
    if (!mounted) {
      return;
    }
  }

  Future<void> _loadFingerprintStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isEnabled = prefs.getBool('fingerprint_enabled') ?? false;
    setState(() {
      _isFingerprintEnabled = isEnabled;
    });
  }

  Future<void> _saveFingerprintStatus(bool isEnabled) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('fingerprint_enabled', isEnabled);
    setState(() {
      _isFingerprintEnabled = isEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 70),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios_rounded,size: 20)),
                ],
              ),
              const SizedBox(height: 20,),
              BlocBuilder<ChangeThemeBloc, ChangeThemeState>(
                  builder: (context, state) {
                    return  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Enable FingerPrint',
                            style: GoogleFonts.poppins(
                              color: state.isDark ? Colors.white : Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            )),
                        BlocBuilder<ChangeThemeBloc, ChangeThemeState>(builder: (context, state) {
                          return Switch(
                            activeColor: Colors.black,
                            inactiveThumbColor: Colors.grey,
                            value: _isFingerprintEnabled,
                            onChanged: (value) {
                              if (value) {
                                // Enable fingerprint
                                authenticateWithBiometrics();
                              } else {
                                // Disable fingerprint
                                _saveFingerprintStatus(false);
                              }
                            },
                          );
                        },)
                      ],
                    );
                  },)
            ],
          ),
        ),
      ),
    );
  }
}
