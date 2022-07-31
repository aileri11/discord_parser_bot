import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:dio/dio.dart';

Response? resp;

Future<void> envSetUp(u) async {
  resp = await Dio().get(u!);
}

String? getTextByClass(String class_, {required String HTML}) {
  BeautifulSoup sp = BeautifulSoup(HTML);
  return sp.find("div", class_: class_)?.getText();
}

String? getTextById(String id, {required String HTML}){
  BeautifulSoup sp = BeautifulSoup(HTML);
  return sp.find("div", id: id)?.getText();
}

String? parseSoloqKda({required String HTML}) {
  BeautifulSoup sp = BeautifulSoup(HTML);
  var kda = sp.find('div', id: 'profileKda')?.find('div', attrs: {'data-tab-id' : 'championsData-soloqueue'});
  return '\n        ${kda?.find('span', class_: 'kills')?.getText()}/${kda?.find('span', class_: 'deaths')?.getText()}/${kda?.find('span', class_: 'assists')?.getText()}';
}

String? parseSoloqTier() {
  return '\n${getTextByClass("leagueTier", HTML: resp!.data)?.replaceAll('\n', '').substring(28)}';
}

String? parseFlexTier() {
  return '\n${getTextByClass("medium-14 columns leagueTier", HTML: resp!.data)?.replaceAll('\n', '').substring(32)}';
}

String? parseSoloqGames(){
  return getTextById('graphDD5', HTML: resp!.data);
}

String? parseSoloqWinrate(){
  return getTextById('graphDD6', HTML: resp!.data);
}

String? parseSoloqStats() {
  return 'Games: ${parseSoloqGames()}\nWinrate: ${parseSoloqWinrate()}\nAverage K/D/A: ${parseSoloqKda(HTML: resp!.data)}';
}
