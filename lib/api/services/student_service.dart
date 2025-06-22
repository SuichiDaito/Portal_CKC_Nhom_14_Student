import 'package:chopper/chopper.dart';

part 'student_service.chopper.dart';

@ChopperApi(baseUrl: '/student')
abstract class StudentService extends ChopperService {
  static StudentService create([ChopperClient? client]) =>
      _$StudentService(client);
  @Post(path: '/login')
  Future<Response<Map<String, dynamic>>> login(
    @Body() Map<String, dynamic> body,
  );

  // @Get(path: '/show/{id}')
  // Future<Response> getUserDetail(@Path('id') int id);
}
