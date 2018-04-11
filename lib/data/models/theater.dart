import 'package:meta/meta.dart';
import 'package:xml/xml.dart' as xml;
import 'package:distrowatchapp/utils/xml_utils.dart';

final RegExp _nameExpr = new RegExp(r'([A-Z])([A-Z]+)');

class Theater {
  /// Entirely redundant theater, which isn't actually even a theater.
  /// The API returns this as "Valitse alue/teatteri", which means "choose a
  /// theater". Thanks Finnkino.
  static const String kChooseTheaterId = '1029';

  Theater({
    @required this.id,
    @required this.name,
  });

  final String id;
  final String name;

  static List<Theater> parseAll(String xmlString) {
    var document = xml.parse(xmlString);
    var theaters = document.findAllElements('TheatreArea');

    return theaters.map((node) {
      var id = tagContents(node, 'ID');
      var normalizedName = _normalize(tagContents(node, 'Name'));

      if (id == kChooseTheaterId) {
        normalizedName = 'All theaters';
      }

      return new Theater(
        id: id,
        name: normalizedName,
      );
    }).toList();
  }

  static _normalize(String text) {
    return text.replaceAllMapped(_nameExpr, (match) {
      return '${match.group(1)}${match.group(2).toLowerCase()}';
    });
  }
}
