class ProviderConfig {
  String provider;
  String apiKey;
  String baseUrl;
  int maxTokens;
  double temperature;

  ProviderConfig({
    this.provider = 'openrouter',
    this.apiKey = '',
    this.baseUrl = 'https://openrouter.ai/api/v1',
    this.maxTokens = 1000,
    this.temperature = 0.7,
  });
}