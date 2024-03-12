import 'package:flutter/material.dart';
import 'package:gen_x/tls/tls_view.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TLS Shake',
      theme: FlexThemeData.light(
        scheme: FlexScheme.brandBlue,
        useMaterial3: true,
        visualDensity: const VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity),
        fontFamily: GoogleFonts.aBeeZee().fontFamily,
        textTheme: GoogleFonts.aBeeZeeTextTheme(),
      ),
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.brandBlue,
        useMaterial3: true,
        visualDensity: const VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity),
        fontFamily: GoogleFonts.aBeeZee().fontFamily,
        textTheme: GoogleFonts.aBeeZeeTextTheme(),
        scaffoldBackground: const Color.fromARGB(255, 40, 44, 51),
      ),
      themeMode: ThemeMode.system,
      home: const TlsView(),
    );
  }
}

