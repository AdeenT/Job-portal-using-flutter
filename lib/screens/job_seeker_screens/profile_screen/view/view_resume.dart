import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ResumeViewPage extends StatelessWidget {
  const ResumeViewPage({super.key, required this.resumeUrl});

  final String resumeUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SfPdfViewer.network(resumeUrl),
      ),
    );
  }
}