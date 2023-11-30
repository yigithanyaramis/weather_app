import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/padding_constants.dart';
import '../../../core/constants/scale_constants.dart';
import '../../../core/constants/string_constants.dart';
import '../../../core/constants/weather_constants.dart';
import '../../../core/models/city_model.dart';
import '../../../core/models/weather_model.dart';
import '../../../core/notifier/scale_provider.dart';
import '../view_model/home_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text(StringConstants.homePage)),
      ),
      body: Padding(
        padding: PaddingConstants.instance.basePadding,
        child: Consumer<HomeViewModel>(
          builder: (context, model, child) {
            WeatherModel? currentModel;
            if (context.watch<ScaleProvider>().currentScale ==
                ScaleConstants.celsius) {
              currentModel = model.celsiusWeather;
            } else {
              currentModel = model.fahrenheitWeather;
            }
            return currentModel != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      model.cityList != null && model.cityList!.isNotEmpty
                          ? _buildDropdown(model)
                          : const SizedBox.shrink(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(StringConstants.currentTemperature),
                          context.watch<ScaleProvider>().currentScale ==
                                  ScaleConstants.celsius
                              ? Text('${currentModel.currentTemperature2m}°C')
                              : Text('${currentModel.currentTemperature2m}°F')
                        ],
                      ),
                      Padding(
                        padding: PaddingConstants.instance.lowTopPadding,
                        child: const Text(
                          StringConstants.dailyForecasts,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      _buildDailyForecasts(currentModel, model),
                      Padding(
                        padding: PaddingConstants.instance.lowTopPadding,
                        child: const Text(
                          StringConstants.hourlyToday,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      _buildHourlyForecasts(currentModel, model),
                      Padding(
                        padding: PaddingConstants.instance.lowTopPadding,
                        child: const Text(
                          StringConstants.details,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      _buildDetailsCard(currentModel)
                    ],
                  )
                : const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _buildDropdown(HomeViewModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(StringConstants.myCity),
        DropdownButton<CityModel>(
          value: model.selectedCity,
          onChanged: (CityModel? newValue) {
            model.setSelectedCity(newValue);
            model.fetchWeatherByLocation(
                latitude: (newValue?.coordinates!['latitude'].toString() ??
                    '39.92077'),
                longitude: (newValue?.coordinates!['longitude'].toString() ??
                    '32.85411'));
          },
          items: model.cityList!.map<DropdownMenuItem<CityModel>>(
            (CityModel city) {
              return DropdownMenuItem<CityModel>(
                value: city,
                child: Text(city.name),
              );
            },
          ).toList(),
        ),
      ],
    );
  }

  Widget _buildHourlyForecasts(
      WeatherModel? currentModel, HomeViewModel model) {
    return Padding(
      padding: PaddingConstants.instance.lowTopPadding,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: currentModel!.hourlyTime.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: constraints.maxWidth * 0.5,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            '${DateTime.parse(currentModel.hourlyTime[index]).hour.toString().padLeft(2, '0')}:${DateTime.parse(currentModel.hourlyTime[index]).minute.toString().padLeft(2, '0')}',
                          ),
                          context.watch<ScaleProvider>().currentScale ==
                                  ScaleConstants.celsius
                              ? Text(
                                  '${StringConstants.temperature}: ${currentModel.hourlyTemperature[index]}°C',
                                )
                              : Text(
                                  '${StringConstants.temperature}: ${currentModel.hourlyTemperature[index]}°F',
                                ),
                          Text(
                            WeatherCodes.getDescription(
                                model.celsiusWeather!.hourlyWeatherCode[index]),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildDailyForecasts(
      WeatherModel? currentModel, HomeViewModel model) {
    return Padding(
      padding: PaddingConstants.instance.lowTopPadding,
      child: LayoutBuilder(builder: (context, constraints) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.15,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: currentModel!.dailyTime.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: constraints.maxWidth * 0.5,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(DateFormat('EEEE', 'en_US').format(DateTime.parse(
                            model.celsiusWeather!.dailyTime[index]))),
                        context.watch<ScaleProvider>().currentScale ==
                                ScaleConstants.celsius
                            ? Text(
                                '${currentModel.dailyTemperatureMax[index]}°C - ${currentModel.dailyTemperatureMin[index]}°C',
                              )
                            : Text(
                                '${currentModel.dailyTemperatureMax[index]}°F - ${currentModel.dailyTemperatureMin[index]}°F',
                              ),
                        Text(
                          WeatherCodes.getDescription(
                              model.celsiusWeather!.dailyWeatherCode[index]),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }

  Widget _buildDetailsCard(WeatherModel currentModel) {
    return Padding(
      padding: PaddingConstants.instance.lowTopPadding,
      child: Card(
        child: Padding(
          padding: PaddingConstants.instance.lowAllPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Text(StringConstants.uVIndex),
                  Text((currentModel.dailyUVIndex.first).toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              Column(
                children: [
                  const Text(StringConstants.elevation),
                  Text(currentModel.elevation.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              Column(
                children: [
                  const Text(StringConstants.windSpeed),
                  Text('${currentModel.currentWindSpeed} km/h',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
