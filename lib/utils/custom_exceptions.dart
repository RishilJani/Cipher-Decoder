class ControllerTypeException implements Exception{
  String? message ;

  ControllerTypeException({required this.message});

  @override
  String toString() {
    return message!;
  }
}