import 'dart:typed_data';
import 'package:esc_pos_utils_plus/esc_pos_utils.dart';
import 'package:image/image.dart' as img;

class ESCPrinterService {
  final Uint8List receipt;
  /// List<int> _bytes;
  /// List<int> get bytes => _bytes;
  late PaperSize _paperSize;
  CapabilityProfile? _profile;

  ESCPrinterService(this.receipt, {PaperSize? paperSize}) {
    this._paperSize = paperSize ?? PaperSize.mm80;
  }

  Future<List<int>> getBytes({
    PaperSize paperSize = PaperSize.mm80,
    CapabilityProfile? profile,
    bool drawer = false,
    bool beep = false,
  }) async {
    List<int> bytes = [];
    _profile = profile ?? (await CapabilityProfile.load());
    _paperSize = paperSize;
    assert(_profile != null);
    Generator generator = Generator(_paperSize, _profile!);
    if (receipt.isNotEmpty) {
      final decodedImage = img.decodeImage(receipt)!;
      final img.Image _resize =
          img.copyResize(decodedImage, width: _paperSize.width);
      bytes += generator.image(_resize);
      bytes += generator.feed(2);
      bytes += generator.cut();
    }
    if (beep) {
      bytes += generator.beep();
    }
    if (drawer) {
      bytes += generator.drawer();
    }

    return bytes;
  }
}
