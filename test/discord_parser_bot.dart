import 'package:discord_parser_bot/discord_parser_bot.dart';
import 'package:test/test.dart';
import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:logger/logger.dart';

void main() {
  group("UNIT TEST", (){
    setUp( () async {
      await envSetUp('https://www.leagueofgraphs.com/summoner/ru/huetao');
    });
    test("Parse elo", () {
      BeautifulSoup sp = BeautifulSoup(resp!.data);
      Logger().d(parseSoloqTier());
    });
    test("Parse avg soloq kda", () {
      BeautifulSoup sp = BeautifulSoup(resp!.data);
      var kda = sp.find('div', id: 'profileKda')?.find('div', attrs: {'data-tab-id' : 'championsData-soloqueue'});
      Logger().d('${kda?.find('span', class_: 'kills')?.getText()}/${kda?.find('span', class_: 'deaths')?.getText()}/${kda?.find('span', class_: 'assists')?.getText()}\n');
    });
    test("Parse flex elo", () {
      BeautifulSoup sp = BeautifulSoup(resp!.data);
      Logger().d(sp.find('div', class_: 'medium-14 columns leagueTier')?.getText().replaceAll('\n', ''));
    });
    test('Parse SoloQ wRate', () {
      BeautifulSoup sp = BeautifulSoup(resp!.data);
      Logger().d(sp.find('div', id: 'graphDD6')?.getText());
    });
    test('Parse SoloQ amount of games', () {
      BeautifulSoup sp = BeautifulSoup(resp!.data);
      Logger().d(sp.find('div', id: 'graphDD5')?.getText());
    });
  });
  group('func test', () {
    setUp( () async {
      await envSetUp('https://www.leagueofgraphs.com/summoner/ru/huetao');
    });
    test('parse SoloqTier', () {
      Logger().d(parseSoloqTier());
    });
  });
}
