

class Utilities {

  static T enumFromString<T>(Iterable<T> values, String value){
    return values.firstWhere((type) => type.toString().split(".").last == value,
        orElse: () => throw Exception('The provided string does not match any known values of the enum'));
  }

}
