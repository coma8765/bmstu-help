import 'dart:io';

import 'package:bmstu_help/src/services/http/http.dart';
import 'package:bmstu_help/src/services/logging/logging.dart';
import 'package:bmstu_help/src/services/service_locator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class DioHTTP implements HTTP {
  DioHTTP(this.dio);

  final Dio dio;

  @override
  Future<bool> downloadFile({
    required String url,
    required String filename,
    String? saveFolder,
    bool open = false,
    FailureCallback? failureCallback,
    SuccessCallback? successCallback,
  }) async {
    final logging = getIt.get<Logging>(param1: 'http-dio');
    final actionId = const Uuid().v1();

    if (kIsWeb || !(Platform.isAndroid || Platform.isIOS || Platform.isLinux)) {
      logging.error('unsupported platform for download');
      return false;
    }

    String? filePath;

    if (saveFolder != null) {
      filePath = '$saveFolder/$filename';
    } else {
      // TODO(coma8765): move to other method
      late String defaultSaveFolder;

      if (Platform.isAndroid || Platform.isIOS) {
        final appDocumentFolder = await getApplicationDocumentsDirectory();

        defaultSaveFolder = '${appDocumentFolder.path}/downloads';
        await Directory(defaultSaveFolder).create(recursive: true);
      } else if (Platform.isLinux) {
        defaultSaveFolder = (await getDownloadsDirectory())!.path;
      } else {
        // impossible
      }

      filePath = '$defaultSaveFolder/$filename';
    }

    logging.debug("action $actionId: downloading url: '$url'");

    try {
      await dio.download(
        url,
        filePath,
        options: Options(
          validateStatus: (int? status) => status! < 400,
          followRedirects: true,
        ),
      );
    } on DioException catch (e) {
      // TODO(coma8765): add UI message for failure
      // TODO(coma8765): move to handle error function
      if (e.response != null) {
        final status = e.response!.statusCode!;

        if (status >= 500) {
          logging.warning(
            'server error, params: ${e.requestOptions.uri} '
            'method ${e.requestOptions.method}, '
            'status $status',
          );
        } else if (status >= 400) {
          logging.warning(
            'incorrect request, params: ${e.requestOptions.uri} '
            'method ${e.requestOptions.method}, '
            'status $status',
          );
        } else {
          /* impossible case */
        }
      } else {
        logging.error('unexpected error', error: e);
      }

      if (failureCallback != null) failureCallback();
      return false;
    }

    logging.debug('action $actionId: success downloaded');
    if (open) {
      await OpenFile.open(filePath);
      logging.debug('action $actionId: success saved at $filePath');
    }

    if (successCallback != null) successCallback();

    return true;
  }
}
