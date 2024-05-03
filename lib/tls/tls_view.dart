import 'package:flutter/material.dart';

import 'generator_form.dart';
import 'models.dart';

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
              certProfile: CertProfile.server,
            ),
            GeneratorForm(
              certProfile: CertProfile.client,
            ),
            GeneratorForm(
              certProfile: CertProfile.rootCa,
            ),
            GeneratorForm(
              certProfile: CertProfile.subCa,
            ),
          ],
        ),
      ),
    );
  }
}
