/// Enum to represent the status of a transaction regarding fraud detection.
enum Fraud {
  /// Indicates that the transaction is identified as fraud.
  yes, // True
  
  /// Indicates that the transaction is identified as not fraud.
  no, // False
  
  /// Indicates that the transaction is currently being searched or the result is unknown.
  unknown, // Searching
}
