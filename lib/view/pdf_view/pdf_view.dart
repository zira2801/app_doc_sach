import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PDFViewerPage extends StatefulWidget {
  final String assetPath;

  const PDFViewerPage({super.key, required this.assetPath});

  @override
  _PDFViewerPageState createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  late PdfViewerController _pdfViewerController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();
    _loadLastPage();
  }

  void _loadLastPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentPage = (prefs.getInt('lastPage_${widget.assetPath}') ?? 0);
      _pdfViewerController.jumpToPage(_currentPage + 1);
    });
  }

  void _saveLastPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('lastPage_${widget.assetPath}', _currentPage);
  }

  @override
  void dispose() {
    _saveLastPage();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: SfPdfViewer.asset(
        widget.assetPath,
        controller: _pdfViewerController,
        onPageChanged: (PdfPageChangedDetails details) {
          setState(() {
            _currentPage = details.newPageNumber - 1;
          });
          _saveLastPage();
        },
      ),
    );
  }
}