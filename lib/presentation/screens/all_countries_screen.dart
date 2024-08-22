import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_countries/presentation/bloc/all_countries_screen/all_countries_screen_bloc.dart';
import 'package:rest_countries/presentation/screens/country_info_screen.dart';
import 'package:rest_countries/presentation/widgets/sort_dialog.dart';

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
      builder: (context) => SortDialog(
        bloc: _bloc,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocBuilder<AllCountriesScreenBloc, AllCountriesScreenState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("All Countries"),
              actions: [
                ActionChip(
                  label: const Text("Sort"),
                  avatar: const Icon(Icons.sort_by_alpha),
                  side: BorderSide.none,
                  onPressed:
                      state is AllCountriesScreenSuccess ? showFilters : null,
                ),
                const SizedBox(
                  width: 5,
                ),
              ],
            ),
            body: state is AllCountriesScreenSuccess
                ? ListView.separated(
                    separatorBuilder: (context, index) => const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 3.0,
                      ),
                      child: Divider(),
                    ),
                    itemCount: state.countries.length,
                    itemBuilder: (context, index) => ListTile(
                      key: Key('$index'),
                      title: Text(state.countries[index].name?.common ?? ""),
                      subtitle: Text(state.countries[index].capital?[0] ?? ""),
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
                : state is AllCountriesScreenError
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: Theme.of(context).colorScheme.error,
                            ),
                            Text(
                              state.error,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                              ),
                            ),
                            ActionChip(
                              label: const Text("Retry"),
                              avatar: const Icon(
                                Icons.restart_alt_rounded,
                              ),
                              onPressed: () {
                                _bloc.add(AllCountriesScreenFetchData());
                              },
                            )
                          ],
                        ),
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
          );
        },
      ),
    );
  }
}
