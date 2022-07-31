import 'package:discord_parser_bot/discord_parser_bot.dart' as lib;
import 'package:discord_parser_bot/token.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commander/nyxx_commander.dart';
import "dart:async";

final prefixes = <Snowflake, String>{};
const defaultPrefix = "!";

FutureOr<String?> prefixHandler(IMessage message) {
  if (message.guild == null) {
    return defaultPrefix;
  }

  final prefixForGuild = prefixes[message.guild!.id];
  return prefixForGuild ?? defaultPrefix;
}

Future<void> setUp(List<String> message) async{
  String userName = message[1];
  if (message.length > 3){
  for(int i = 2; i < message.length - 1; i++){
    userName += '+${message[i]}';
  }
  }
  String? server = message.last;
  await lib.envSetUp('https://www.leagueofgraphs.com/summoner/$server/$userName');
}

void main(List<String> arguments) {
  final bot = NyxxFactory.createNyxxWebsocket(token, GatewayIntents.allUnprivileged)
    ..registerPlugin(Logging()) 
    ..registerPlugin(CliIntegration()) 
    ..registerPlugin(IgnoreExceptions()) 
    ..connect();
  
  ICommander.create(bot, prefixHandler)
    .registerCommand("elo", (context, message) async{
      await setUp(message.split(' '));
      context.reply(MessageBuilder.content('```SoloQ: ${lib.parseSoloqTier().toString()}\nFlex: ${lib.parseFlexTier().toString()}```'));
    });
  
  ICommander.create(bot, prefixHandler)
    .registerCommand("SoloQ", (context, message) async{
      await setUp(message.split(' '));
      context.reply(MessageBuilder.content('```${lib.parseSoloqStats().toString()}```'));
    });
}
