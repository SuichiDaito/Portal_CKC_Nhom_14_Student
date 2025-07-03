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

  @POST(path: '/logout')
  Future<Response<Map<String, dynamic>>> logout();

  @POST(path: 'sinh-vien-yeu-cau-cap-mat-khau')
  Future<Response<Map<String, dynamic>>> requestPasswordReset(
    @Body() Map<String, dynamic> body,
  );

  @GET(path: '/danh-sach-giay-da-dang-ky')
  Future<Response<Map<String, dynamic>>> getRegisteredCertificates();

  @GET(path: '/diem-ren-luyen')
  Future<Response<Map<String, dynamic>>> getTrainingPoints();

  @GET(path: '/bienbanshcn')
  Future<Response<Map<String, dynamic>>> getReportResponse();

  @GET(path: '/giay-xac-nhan')
  Future<Response<Map<String, dynamic>>> getPaperCertificates();
}
