import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;

class Distro {
  Distro({
    this.name,
    this.osType,
    this.basedOn,
    this.origin,
    this.arch,
    this.environment,
    this.categories,
    this.status,
    this.popularity,
    this.hpd,
    this.info,
  });

  final String name;
  final String osType;
  final String basedOn;
  final String origin;
  final List<String> arch;
  final List<String> environment;
  final List<String> categories;
  final String status;
  final int popularity;
  final int hpd;
  final String info;

  static List<Distro> parseAll(String html) {
    var document = parse(html);
    List<Element> distros = document.getElementsByClassName('News1');
    // The last two elements are not actual distros, so they must be removed
    distros.removeLast();
    distros.removeLast();

    return distros.map((node) {
      String name = node.getElementsByClassName('NewsHeadline')[0].text;
      String info = node.getElementsByClassName('NewsText')[0].text;
      return new Distro(
        name: name,
        osType: "",
        basedOn: "",
        origin: "",
        arch: [""],
        environment: [""],
        categories: [""],
        status: "",
        popularity: 0,
        hpd: 0,
        info: info,
      );
    }).toList();

  }
}