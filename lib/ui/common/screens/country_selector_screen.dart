import 'package:flutter/material.dart';
import 'package:quiz_u/core/l10n/l10n.dart';
import 'package:quiz_u/core/models/country.dart';
import 'package:quiz_u/core/theme/styles.dart';
import 'package:quiz_u/core/utils/country_utils.dart';

typedef CountrySelected = void Function(Country country);

class CountrySelectorScreen extends StatefulWidget {
  const CountrySelectorScreen({super.key, required this.onSelected});

  final CountrySelected onSelected;

  @override
  State<CountrySelectorScreen> createState() => CountrySelectorScreenState();
}

class CountrySelectorScreenState extends State<CountrySelectorScreen> {
  final _controller = TextEditingController();

  String? _keyword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.selectAreaCode),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppEdges.content),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(hintText: context.l10n.search),
              onChanged: (value) => setState(() => _keyword = value),
            ),
          ),
          Expanded(
            child: CountriesList(
              keyword: _keyword,
              onSelected: widget.onSelected,
            ),
          ),
        ],
      ),
    );
  }
}

class CountriesList extends StatelessWidget {
  const CountriesList({
    super.key,
    required this.onSelected,
    this.keyword,
  });

  final CountrySelected onSelected;
  final String? keyword;

  @override
  Widget build(BuildContext context) {
    final list = keyword != null
        ? CountryUtils.countries.where(
            (region) {
              return region.code
                      .toUpperCase()
                      .contains(keyword!.toUpperCase()) ||
                  region.dialCode.toString().contains(keyword!) ||
                  region.name.toLowerCase().startsWith(keyword!.toLowerCase());
            },
          ).toList()
        : CountryUtils.countries;
    return ListView.separated(
      itemCount: list.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        final region = list[index];
        return ListTile(
          onTap: () => onSelected.call(region),
          visualDensity: VisualDensity.standard,
          title: Row(
            children: [
              Text(
                region.flag,
                style: const TextStyle(color: Colors.black, fontSize: 18),
              ),
              AppSpacers.horizontalMedium,
              Expanded(child: Text(region.name)),
              const Spacer(),
              Text(region.dialCode),
            ],
          ),
        );
      },
    );
  }
}
