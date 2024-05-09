enum ToastEnum { success, error, info, warning }

ToastEnum toastEnumFromString(String value) {
  return ToastEnum.values.firstWhere(
    (type) => type.toString().split('.').last == value,
    orElse: () => throw ArgumentError('Invalid toast type: $value'),
  );
}
