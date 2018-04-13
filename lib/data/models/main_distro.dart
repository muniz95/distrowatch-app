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

    return distros.map(_parseMainDistroNode).toList();
  }

  static MainDistro _parseMainDistroNode(Element node) {
      List<Element> topics = node.getElementsByTagName('li');
      String name = node.getElementsByClassName('NewsHeadline')[0].text;
      String info = node.getElementsByClassName('NewsText')[0].text;
      List<String> pros = [];
      List<String> cons = [];
      List<String> packageManagement = [];
      List<String> editions = [];
      List<String> alternatives = [];
      try {
        pros = topics[0].text.substring(6).split(',');
      } catch (e) {}

      try {
        cons = topics[1].text.substring(6).split(',');
      } catch (e) {}

      try {
        packageManagement = topics[2].text.split(',');
      } catch (e) {}

      try {
        editions = topics[3].text.split(',');
      } catch (e) {}

      try {
        alternatives = topics[4].text.split(',');
      } catch (e) {}

      return new MainDistro(
        name: name,
        info: info,
        pros: pros,
        cons: cons,
        packageManagement: packageManagement,
        editions: editions,
        alternatives: alternatives,
        screenshot: "",
      );
  }
}