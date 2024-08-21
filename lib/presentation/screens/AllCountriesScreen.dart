import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_countries/data/enums/filters.dart';
import 'package:rest_countries/presentation/bloc/AllCountriesScreen/all_countries_screen_bloc.dart';
import 'package:rest_countries/presentation/screens/CountryInfoScreen.dart';

class AllCountriesScreen extends StatefulWidget {
  const AllCountriesScreen({super.key});

  @override
  State<AllCountriesScreen> createState() => _AllCountriesScreenState();
}

class _AllCountriesScreenState extends State<AllCountriesScreen> {
  final _bloc = AllCountriesScreenBloc();

  @override
  void initState() {
    _bloc.add(AllCountriesScreenFetchData());
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  void showFilters() {
    showModalBottomSheet(
      context: context,
      builder: (context) => BlocProvider.value(
        value: _bloc,
        child: BlocBuilder<AllCountriesScreenBloc, AllCountriesScreenState>(
          builder: (context, state) {
            return state is AllCountriesScreenSuccess
                ? Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      // vertical: 35,
                    ),
                    width: double.infinity,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Container(
                            width: 55,
                            height: 5,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onSurface,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          "Sort results",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const Row(
                          children: [
                            Icon(Icons.sort_by_alpha),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Filter by")
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            FilterChip(
                              label: const Text("Population"),
                              selected: state.filterBy == FilterName.population,
                              onSelected: (bool h) {
                                _bloc.add(
                                  AllCountriesScreenFilterUpdate(
                                    FilterName.population,
                                    state.filterOrder,
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            FilterChip(
                              label: const Text("Name"),
                              selected: state.filterBy == FilterName.name,
                              onSelected: (bool h) {
                                _bloc.add(
                                  AllCountriesScreenFilterUpdate(
                                    FilterName.name,
                                    state.filterOrder,
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            FilterChip(
                              label: const Text("Capital"),
                              selected: state.filterBy == FilterName.capital,
                              onSelected: (bool h) {
                                _bloc.add(
                                  AllCountriesScreenFilterUpdate(
                                    FilterName.capital,
                                    state.filterOrder,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 20,
                        ),
                        const Row(
                          children: [
                            Icon(Icons.sort_by_alpha),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Filter order")
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            FilterChip(
                              label: const Text("Ascending"),
                              selected: state.filterOrder == FilterOrder.asc,
                              onSelected: (bool h) {
                                _bloc.add(
                                  AllCountriesScreenFilterUpdate(
                                    state.filterBy,
                                    FilterOrder.asc,
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            FilterChip(
                              label: const Text("Descending"),
                              selected: state.filterOrder == FilterOrder.dsc,
                              onSelected: (bool h) {
                                _bloc.add(
                                  AllCountriesScreenFilterUpdate(
                                    state.filterBy,
                                    FilterOrder.dsc,
                                  ),
                                );
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                : const SizedBox();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Countries"),
        actions: [
          ActionChip(
            label: const Text("Sort"),
            avatar: const Icon(Icons.sort_by_alpha),
            side: BorderSide.none,
            onPressed: showFilters,
          ),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => _bloc,
        child: BlocBuilder<AllCountriesScreenBloc, AllCountriesScreenState>(
          builder: (context, state) {
            return state is AllCountriesScreenSuccess
                ? ListView.builder(
                    itemCount: state.countries.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(state.countries[index].name?.common ?? ""),
                      subtitle:
                          Text(state.countries[index].capital?[0] ?? ""),
                      leading: Hero(
                        tag: state.countries[index].name?.common ?? "",
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: CachedNetworkImage(
                            imageUrl: state.countries[index].flags?.png ?? "",
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.info_outline),
                            progressIndicatorBuilder:
                                (context, url, progress) =>
                                    RefreshProgressIndicator(
                              value: progress.progress,
                            ),
                          ),
                        ),
                      ),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Icon(Icons.people_alt_outlined),
                          Text(state.countries[index].population.toString()),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CountryInfoScreen(
                              country: state.countries[index],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}
