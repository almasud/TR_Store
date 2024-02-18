/*
 * Copyright (c) 2024.
 * Created by: Abdullah Al Masud
 * Created on: 18/2/2024
 */

sealed class NetworkResult<T extends Object> {
  const NetworkResult();
}

final class Success<T extends Object> extends NetworkResult<T> {
  const Success({required this.body});

  final T body;
}

final class Error<T extends Object> extends NetworkResult<T> {
  const Error({this.code, this.message});

  final int? code;
  final String? message;
}

final class Throwable<T extends Object> extends NetworkResult<T> {
  Throwable({required this.exception});

  final Exception exception;
}
