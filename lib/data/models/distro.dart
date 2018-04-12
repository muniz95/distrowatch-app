import 'package:xml/xml.dart' as xml;

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
    var document = xml.parse(html);
    var distros = document.findAllElements('Event');

    return distros.map((node) =>
      new Distro(
        name: "",
        osType: "",
        basedOn: "",
        origin: "",
        arch: [""],
        environment: [""],
        categories: [""],
        status: "",
        popularity: 0,
        hpd: 0,
        info: "",
      )
    ).toList();
  }
}