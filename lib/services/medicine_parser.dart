class MedicineParser {

  static String extractMedicineName(String text) {

    List<String> lines = text.split('\n');

    for (String line in lines) {

      line = line.trim();

      if (line.isEmpty) {
        continue;
      }

      // Ignore common unwanted OCR lines
      if (line.toLowerCase().contains("batch") ||
          line.toLowerCase().contains("expiry") ||
          line.toLowerCase().contains("mg") ||
          line.toLowerCase().contains("tablet")) {
        continue;
      }

      return line;
    }

    return "Unknown Medicine";
  }
}