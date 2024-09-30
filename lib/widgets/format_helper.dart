class FormatHelper {
  

  static String viewsAndLikesFormat(int amount) {
    if (amount < 100000) {
      return formatWithCommas(amount);
    } else if (amount < 10000000) {
      return '${(amount / 100000).toStringAsFixed(1)} Lakh';
    } else {
      return '${(amount / 10000000).toStringAsFixed(1)} Cr';
    }
  }

  static String formatWithCommas(int amount) {
    return amount.toString().replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }
}