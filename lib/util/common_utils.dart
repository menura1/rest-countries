String formatLanguages(Map data) {
  String res = "";
  for (var entry in data.entries) {
    res = '$res• ${entry.value} (${entry.key}) \n';
  }
  return res;
}
