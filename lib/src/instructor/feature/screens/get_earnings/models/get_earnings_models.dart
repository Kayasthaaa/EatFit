class EarningsModels {
  final double lifetimeEarning;
  final double currentEarning;

  EarningsModels({
    required this.lifetimeEarning,
    required this.currentEarning,
  });

  factory EarningsModels.fromJson(Map<String, dynamic> json) {
    return EarningsModels(
      lifetimeEarning: json['Life Time Earning'] ?? 0.0,
      currentEarning: json['Current Earning'] ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Life Time Earning': lifetimeEarning,
      'Current Earning': currentEarning,
    };
  }
}
