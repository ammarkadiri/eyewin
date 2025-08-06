class Settings {
  final String? rewardSystem;
  final bool? showSuggestedPriceLabel;
  final bool? showWatchout;

  Settings({
    this.rewardSystem,
    this.showSuggestedPriceLabel,
    this.showWatchout,
  });

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      rewardSystem: json['RewardSystem'] as String?,
      showSuggestedPriceLabel: json['ShowSuggestedPriceLabel'] as bool?,
      showWatchout: json['ShowWatchout'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
        'RewardSystem': rewardSystem,
        'ShowSuggestedPriceLabel': showSuggestedPriceLabel,
        'ShowWatchout': showWatchout,
      };
}
