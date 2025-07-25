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

  @GET(path: '/ket-qua-hoc-tap')
  Future<Response<Map<String, dynamic>>> getPointResult();

  @GET(path: '/hocphi')
  Future<Response<Map<String, dynamic>>> getPaymentStudentFee();

  @GET(path: '/thong-tin-giang-vien')
  Future<Response<Map<String, dynamic>>> getInfoTeacher();

  @GET(path: '/lich-thi')
  Future<Response<Map<String, dynamic>>> getExamStudent();

  @POST(path: '/dang-ky-giay')
  Future<Response<Map<String, dynamic>>> signupCertificates(
    @Body() Map<String, dynamic> body,
  );

  @GET(path: '/thoi-khoa-bieu')
  Future<Response<Map<String, dynamic>>> getTimeTable();

  @GET(path: '/khung-dao-tao')
  Future<Response<Map<String, dynamic>>> getTrainingProgram();

  @POST(path: '/vnpay_payment/{id}')
  Future<Response<Map<String, dynamic>>> paymentFeeStudy(
    @Path('id') int id,
    @Body() Map<String, dynamic> body,
  );

  @POST(path: '/bao-mat/doi-mat-khau')
  Future<Response<Map<String, dynamic>>> requestChangePassword(
    @Body() Map<String, dynamic> body,
  );

  @GET(path: '/thong-bao')
  Future<Response<Map<String, dynamic>>> getNotification();
  @GET(path: '/thong-bao/{id}')
  Future<Response<Map<String, dynamic>>> getNotificationDetail(
    @Path('id') int id,
  );

  @POST(path: '/thong-bao/binh-luan/{thongbao}')
  Future<Response<Map<String, dynamic>>> postComment(
    @Path('thongbao') int thongBaoId,
    @Body() Map<String, dynamic> data,
  );

  @DELETE(path: '/thong-bao/xoa-binh-luan/{binhLuan}')
  Future<Response<Map<String, dynamic>>> deleteComment(
    @Path('binhLuan') int commentId,
  );

  @GET(path: '/lich-thi-lan-hai')
  Future<Response<Map<String, dynamic>>> getExamsSecond();

  @POST(path: '/payment/vnpay/thi-lai/{id}')
  Future<Response> getPaymentExamSecond(@Path('id') int id);

  @GET(path: '/dang-ky-hoc-ghep/lop-hoc-ghep')
  Future<Response<Map<String, dynamic>>> requestSignupStudy();

  @GET(path: '/dang-ky-hoc-ghep/lop/{id_mon_hoc}')
  Future<Response> getListClassSubject(@Path('id_mon_hoc') int id_mon_hoc);

  @POST(path: '/payment/vnpay/hoc-ghep/{id_lop_hoc}')
  Future<Response> paymentListClassSubject(
    @Path('id_lop_hoc') int id,
    @Body() Map<String, dynamic> body,
  );

  @GET(path: '/bienbanshcn/create')
  Future<Response<Map<String, dynamic>>> getListStudent();

  @Post(path: '/bienbanshcn/store/{lop}')
  Future<Response> createBienBan(
    @Path('lop') int lopId,
    @Body() Map<String, dynamic> data,
  );

  @DELETE(path: '/bienbanshcn/{id}')
  Future<Response> deleteReport(@Path('id') int id);

  
  @POST(path: '/bienbanshcn/confirm/{id}')
  Future<Response> requestReport(@Path('id') int id);
}
