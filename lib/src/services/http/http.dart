typedef SuccessCallback = void Function();
typedef FailureCallback = void Function();

mixin HTTP {
  Future<bool> downloadFile({
    required String url,
    required String filename,
    String? saveFolder,
    bool open = false,
    FailureCallback? failureCallback,
    SuccessCallback? successCallback,
  });
}
