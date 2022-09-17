import 'failure.dart';

abstract class HttpFailure extends Failure {
  HttpFailure(String message) : super(message);
}

/// for handle no connection error
class InternetConnectionFailure extends HttpFailure {
  InternetConnectionFailure()
      : super(
          "Tidak ada koneksi internet, mohon periksa dan coba kembali",
        );
}

/// for handle server error
class InternalServerErrorFailure extends HttpFailure {
  InternalServerErrorFailure(int code)
      : super("Terjadi kesalahan pada server dengan status code $code");
}

/// for handle client error
class ClientErrorFailure extends HttpFailure {
  ClientErrorFailure(int code)
      : super("Terjadi kesalahan pada sisi klien dengan status code $code");
}
