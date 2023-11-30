import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/padding_constants.dart';
import '../../../core/constants/scale_constants.dart';
import '../../../core/constants/string_constants.dart';
import '../../../core/notifier/scale_provider.dart';
import '../view_model/settings_view_model.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text(StringConstants.settings)),
      ),
      body: Padding(
        padding: PaddingConstants.instance.basePadding,
        child: ChangeNotifierProvider(
          create: (context) => SettingsViewModel(),
          child: Consumer<SettingsViewModel>(
            builder: (context, viewModel, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: PaddingConstants.instance.lowTopPadding,
                    child: const Text(
                      StringConstants.temperatureUnit,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  _buildRadio(context, viewModel),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Row _buildRadio(BuildContext context, SettingsViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Radio(
          value: ScaleConstants.celsius,
          groupValue: context.watch<ScaleProvider>().currentScale,
          onChanged: (value) {
            viewModel.setUnitPreference(context, value!);
          },
        ),
        const Text(StringConstants.celsius),
        Radio(
          value: ScaleConstants.fahrenheit,
          groupValue: context.watch<ScaleProvider>().currentScale,
          onChanged: (value) {
            viewModel.setUnitPreference(context, value!);
          },
        ),
        const Text(StringConstants.fahrenheit),
      ],
    );
  }
}
