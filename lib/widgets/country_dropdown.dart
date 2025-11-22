import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../generated/l10n.dart';
import '../models/countries.dart';
import '../providers/country_provider.dart';


class CountryDropdown extends StatelessWidget {
  const CountryDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CountryProvider>();
    final theme = Theme.of(context);

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.error != null) {
      return Text(
        provider.error!,
        style: const TextStyle(color: Colors.red),
      );
    }

    final countries = provider.countries;
    if (countries.isEmpty) {
      return const Text('No countries available');
    }

    return DropdownButtonFormField<Country>(
      value: provider.selectedCountry,
      isExpanded: true,
      decoration:  InputDecoration(
        labelText: S.of(context).kCountry,

      ),
      items: countries.map((c) {
        return DropdownMenuItem(
          value: c,

          child: Text('${c.nameEn} (${c.phone})',style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),),
        );
      }).toList(),
      onChanged: (country) {
        if (country != null) {
          provider.selectCountry(country);
        }
      },
    );
  }
}
