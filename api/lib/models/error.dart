enum ErrorType {
  notFound(404),
  serverError(500),
  unauthorized(401),
  invalidApiVersion(400);

  final int httpCode;

  const ErrorType(this.httpCode);
}
