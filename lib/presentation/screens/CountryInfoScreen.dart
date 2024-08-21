import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rest_countries/data/models/Country.dart';
import 'package:rest_countries/util/common_utils.dart';

class CountryInfoScreen extends StatefulWidget {
  const CountryInfoScreen({super.key, required this.country});

  final Country country;

  @override
  State<CountryInfoScreen> createState() => _CountryInfoScreenState();
}

class _CountryInfoScreenState extends State<CountryInfoScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.country.name?.common ?? ""),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: widget.country.name?.common ?? "",
              child: CachedNetworkImage(
                imageUrl: widget.country.flags?.png ?? "",
                width: size.width,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.country.name?.common ?? "",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    widget.country.name?.official ?? "",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.public),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Region :" ?? "",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const Spacer(),
                      Text(
                        widget.country.region?? "",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Capital :" ?? "",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const Spacer(),
                      Text(
                        widget.country.capital?[0] ?? "",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.people_alt_outlined),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Population :" ?? "",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const Spacer(),
                      Text(
                        widget.country.population.toString() ?? "",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.text_format),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Languages",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Text(
                    formatLanguages(widget.country.languages ?? {}),
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
