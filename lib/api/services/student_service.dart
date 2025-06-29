import 'package:chopper/chopper.dart';

part 'student_service.chopper.dart';

@ChopperApi(baseUrl: '/sinhvien')
abstract class StudentService extends ChopperService {
  static StudentService create([ChopperClient? client]) =>
      _$StudentService(client);
  @Post(path: '/login')
  Future<Response<Map<String, dynamic>>> login(
    @Body() Map<String, dynamic> body,
  );

  @POST(path: 'logout')
  Future<Response<Map<String, dynamic>>> logout();
}
