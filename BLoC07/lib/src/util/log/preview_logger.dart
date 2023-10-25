import 'app_log.dart';

Future<void> main() async {
  AppLog.warning('The pizza is over 😥');
  AppLog.debug('Thinking about order new one 🤔');
  AppLog.error('The restaurant is closed ❌');
  AppLog.info('Ordering from other restaurant...');
  AppLog.info('Payment started...');
  AppLog.verbose('Payment completed! Waiting for pizza 🍕');
}
