import 'package:chopper/chopper.dart';
import 'package:portal_ckc/api/view_model/chopper_services.dart';
import 'package:portal_ckc/api/view_model/converted_chopper.dart';

class CallApi {
  static final chopper = ChopperClient(
    baseUrl: Uri.parse('https://jsonplaceholder.typicode.com'),
    services: [JsonService.create()],
    converter: JsonConverter(),
  );
  static JsonService get postServices => chopper.getService<JsonService>();
}
