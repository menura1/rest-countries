import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_countries/data/enums/filters.dart';
import 'package:rest_countries/presentation/bloc/all_countries_screen/all_countries_screen_bloc.dart';

class SortDialog extends StatefulWidget {
  const SortDialog({super.key,required this.bloc});

  final AllCountriesScreenBloc bloc;

  @override
  State<SortDialog> createState() => _SortDialogState();
}

class _SortDialogState extends State<SortDialog> {
  @override
  Widget build(BuildContext context) {
    final bloc = widget.bloc;
    return BlocProvider.value(
      value: bloc,
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
                    Icon(Icons.tune_rounded),
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
                        bloc.add(
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
                        bloc.add(
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
                        bloc.add(
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
                        bloc.add(
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
                        bloc.add(
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
    );
  }
}
