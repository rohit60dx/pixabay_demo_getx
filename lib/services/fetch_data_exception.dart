class FetchDataException implements Exception {
  final String? message;

  FetchDataException([this.message]);

  @override
  String toString() {
    if (message == null) return "Exception";
    return message!;
  }
}