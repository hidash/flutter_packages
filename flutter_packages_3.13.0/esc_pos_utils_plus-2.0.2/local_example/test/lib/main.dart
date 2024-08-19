import 'dart:io' as io;
import 'package:esc_pos_utils_plus/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test/demo.dart';
import 'package:test/esc_printer_service.dart';
import 'package:webcontent_converter/webcontent_converter.dart';
import 'package:image/image.dart' as im;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  io.File? _f;
  @override
  void initState() {
    super.initState();
    generate();
  }

  @override
  void setState(VoidCallback fn) {
    if (!mounted) return;
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("test"),
      ),
      body: _f != null
          ? Container(
              width: 600,
              child: SingleChildScrollView(
                child: Image.memory(_f!.readAsBytesSync()),
              ),
            )
          : Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: generate,
        child: Text("generate"),
      ),
    );
  }

  generate() async {
    var path = (await getApplicationDocumentsDirectory()).path;
    final content = Demo.getShortReceiptContent();
    var image = await WebcontentConverter.contentToImage(
      content: content,
      executablePath: WebViewHelper.executablePath(),
    );

    final profile = await CapabilityProfile.load();
    List<int> bytes = [];
    if (image.isNotEmpty) {
      bytes = await ESCPrinterService(image).getBytes(
        profile: profile,
        drawer: true,
        beep: true,
      );
    }

    // bytes += generator.text(
    //     'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
    // print(bytes);
    var text = io.File(join(path, "text.txt"));
    await text.writeAsBytes(bytes);
    final pngPath = join(path, "receipt.png");
    var f = io.File(pngPath);
    await f.writeAsBytes(image);
    setState(() {
      _f = f;
    });

    var file = io.File(join(path, "bytes.txt"));
    await file.writeAsString("[${bytes.join(",").toString()}]");
    print(file.absolute.path);
    print(f.absolute.path);
  }
}
