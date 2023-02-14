class RingSize {
  final String sizeInMM;
  final String size;

  RingSize(this.sizeInMM, this.size);

  factory RingSize.fromJson(Map<String, dynamic> json) => RingSize(
        json['mm'],
        json['size'],
      );

  Map<String, dynamic> toJson() => {
        "mm": sizeInMM,
        "size": size,
      };
}
