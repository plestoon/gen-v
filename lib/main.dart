import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ffi/frb_generated.dart';
import 'tls/tls_view.dart';

void main() {
  RustLib.init();

  GoogleFonts.config.allowRuntimeFetching = false;
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/LICENSE.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gen V',
      theme: FlexThemeData.light(
        scheme: FlexScheme.brandBlue,
        useMaterial3: true,
        visualDensity: const VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity),
        fontFamily: GoogleFonts.roboto().fontFamily,
        textTheme: GoogleFonts.robotoTextTheme(),
      ),
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.brandBlue,
        useMaterial3: true,
        visualDensity: const VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity),
        fontFamily: GoogleFonts.roboto().fontFamily,
        textTheme: GoogleFonts.robotoTextTheme(),
        scaffoldBackground: const Color.fromARGB(255, 40, 44, 51),
      ),
      themeMode: ThemeMode.system,
      home: const TlsView(),
    );
  }
}

