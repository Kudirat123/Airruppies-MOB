
class BillPaymentOtherWidget {
  String cableImageUrl(String cableType) {
    String? cableUrl;

    switch (cableType) {
      case 'dstv':
        return cableUrl =
            'assets/images/bill_payment/cable_images/dstv_logo.jpg';

      case 'gotv':
        return cableUrl = 'assets/images/bill_payment/cable_images/goTV.png';
      case 'startimes':
        return cableUrl =
            'assets/images/bill_payment/cable_images/startimes.png';

      default:
        cableUrl = 'assets/images/bill_payment/cable_images/startimes.png';
    }

    return cableUrl;
  }

  String airtelImageUrl(String airtimeType) {
    String? cableUrl;

    switch (airtimeType) {
      case 'mtn':
        return cableUrl = 'assets/images/bill_payment/airtime_provider/mtn.jpg';

      case 'airtel':
        return cableUrl =
            'assets/images/bill_payment/airtime_provider/airtel.jpg';
      case 'glo':
        return cableUrl = 'assets/images/bill_payment/airtime_provider/glo.jpg';
      case 'etisalat':
        return cableUrl =
            'assets/images/bill_payment/airtime_provider/9mobile.jpg';

      default:
        cableUrl = 'assets/images/bill_payment/airtime_provider/mtn.jpg';
    }

    return cableUrl;
  }
}
