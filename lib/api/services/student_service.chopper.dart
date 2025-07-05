// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$StudentService extends StudentService {
  _$StudentService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = StudentService;

  @override
  Future<Response<Map<String, dynamic>>> login(Map<String, dynamic> body) {
    final Uri $url = Uri.parse('/sinhvien/login');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> logout() {
    final Uri $url = Uri.parse('/sinhvien/logout');
    final Request $request = Request('POST', $url, client.baseUrl);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> requestPasswordReset(
    Map<String, dynamic> body,
  ) {
    final Uri $url = Uri.parse('/sinhvien/sinh-vien-yeu-cau-cap-mat-khau');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> getRegisteredCertificates() {
    final Uri $url = Uri.parse('/sinhvien/danh-sach-giay-da-dang-ky');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> getTrainingPoints() {
    final Uri $url = Uri.parse('/sinhvien/diem-ren-luyen');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> getReportResponse() {
    final Uri $url = Uri.parse('/sinhvien/bienbanshcn');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> getPaperCertificates() {
    final Uri $url = Uri.parse('/sinhvien/giay-xac-nhan');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> getPointResult() {
    final Uri $url = Uri.parse('/sinhvien/ket-qua-hoc-tap');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> getPaymentStudentFee(
    Map<String, dynamic> body,
  ) {
    final Uri $url = Uri.parse('/sinhvien/hocphi');
    final $body = body;
    final Request $request = Request('GET', $url, client.baseUrl, body: $body);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> getInfoTeacher() {
    final Uri $url = Uri.parse('/sinhvien/thong-tin-giang-vien');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> getExamStudent() {
    final Uri $url = Uri.parse('/sinhvien/lich-thi');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> signupCertificates(
    Map<String, dynamic> body,
  ) {
    final Uri $url = Uri.parse('/sinhvien/dang-ky-giay');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> getTimeTable() {
    final Uri $url = Uri.parse('/sinhvien/thoi-khoa-bieu');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> getTrainingProgram() {
    final Uri $url = Uri.parse('/sinhvien/khung-dao-tao');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }
}
