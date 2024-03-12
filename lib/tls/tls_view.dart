import 'package:flutter/material.dart';

import '../ffi/api/simple.dart' as ffi;
import 'generator_form.dart';

class TlsView extends StatefulWidget {
  const TlsView({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TlsViewState();
  }
}

class _TlsViewState extends State<TlsView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      animationDuration: Duration.zero,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: const TabBar(
            tabs: [
              Tab(text: "Server"),
              Tab(text: "Client"),
              Tab(text: "Root CA"),
              Tab(text: "Sub CA"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            GeneratorForm(
              certProfile: ffi.CertProfile.server,
            ),
            GeneratorForm(
              certProfile: ffi.CertProfile.client,
            ),
            GeneratorForm(
              certProfile: ffi.CertProfile.rootCa,
            ),
            GeneratorForm(
              certProfile: ffi.CertProfile.subCa,
            ),
          ],
        ),
      ),
    );
  }
}
