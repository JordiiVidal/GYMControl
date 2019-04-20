
String weightNumber(double n) {
  return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
}

