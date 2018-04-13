import 'package:html/dom.dart';
import 'package:html/parser.dart';

class MainDistro {
  MainDistro({
    this.name,
    this.info,
    this.pros,
    this.cons,
    this.packageManagement,
    this.editions,
    this.alternatives,
    this.screenshot,
  });

  final String name;
  final String info;
  final List<String> pros;
  final List<String> cons;
  final List<String> packageManagement;
  final List<String> editions;
  final List<String> alternatives;
  final String screenshot;

  static List<MainDistro> parseAll(String html) {
    var document = parse(html);
    List<Element> distros = document.getElementsByClassName('News1');
    // The last two elements are not actual distros, so they must be removed
    distros.removeLast();
    distros.removeLast();

    return distros.map((node) {
      String name = node.getElementsByClassName('NewsHeadline')[0].text;
      String info = node.getElementsByClassName('NewsText')[0].text;
      return new MainDistro(
        name: name,
        info: info,
        pros: [""],
        cons: [""],
        packageManagement: [""],
        editions: [""],
        alternatives: [""],
        screenshot: "",
      );
    }).toList();

  }
}