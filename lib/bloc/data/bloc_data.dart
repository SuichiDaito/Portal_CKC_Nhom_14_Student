import 'package:chopper/chopper.dart';
import 'package:portal_ckc/api/model/comment.dart';

abstract class Data {}

class LoadingData extends Data {}

class LoadedData extends Data {
  final Response<List<Comment>> comments;
  LoadedData(this.comments);
}

class ErroData extends Data {
  final String message;
  ErroData(this.message);
}

