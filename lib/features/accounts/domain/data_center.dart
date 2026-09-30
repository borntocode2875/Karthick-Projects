/// Zoho Desk data-center regions.
enum DataCenter {
  india,
  us,
  eu,
  au,
  jp,
  ca,
  sa;

  /// The default API domain for this data center.
  String get apiDomain {
    switch (this) {
      case DataCenter.india:
        return 'desk.zoho.in';
      case DataCenter.us:
        return 'desk.zoho.com';
      case DataCenter.eu:
        return 'desk.zoho.eu';
      case DataCenter.au:
        return 'desk.zoho.com.au';
      case DataCenter.jp:
        return 'desk.zoho.jp';
      case DataCenter.ca:
        return 'desk.zohocloud.ca';
      case DataCenter.sa:
        return 'desk.zoho.sa';
    }
  }

  String get displayName {
    switch (this) {
      case DataCenter.india:
        return 'India';
      case DataCenter.us:
        return 'United States';
      case DataCenter.eu:
        return 'Europe';
      case DataCenter.au:
        return 'Australia';
      case DataCenter.jp:
        return 'Japan';
      case DataCenter.ca:
        return 'Canada';
      case DataCenter.sa:
        return 'Saudi Arabia';
    }
  }
}
