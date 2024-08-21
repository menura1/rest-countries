import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:rest_countries/data/api/RestClient.dart';
import 'package:rest_countries/data/enums/filters.dart';
import 'package:rest_countries/data/models/Country.dart';

part 'all_countries_screen_event.dart';

part 'all_countries_screen_state.dart';

class AllCountriesScreenBloc
    extends Bloc<AllCountriesScreenEvent, AllCountriesScreenState> {
  AllCountriesScreenBloc() : super(AllCountriesScreenInitial()) {
    on<AllCountriesScreenEvent>((event, emit) async {
      if (event is AllCountriesScreenFetchData) {
        emit(AllCountriesScreenLoading());
        RestClient client = RestClient(Dio());
        final res = await client.getAllCountries();
        emit(AllCountriesScreenSuccess(
          res,
          FilterName.population,
          FilterOrder.asc,
        ));
      } else if (event is AllCountriesScreenFilterUpdate) {
        if (state is AllCountriesScreenSuccess) {
          /// handling sort by population
          if (event.filterBy == FilterName.population) {
            if (event.filterOrder == FilterOrder.asc) {
              (state as AllCountriesScreenSuccess).countries.sort((a, b) {
                int intComparison =
                    (a.population ?? -1).compareTo(b.population ?? -1);
                if (intComparison != 0) return intComparison;
                return -1;
              });
            } else {
              (state as AllCountriesScreenSuccess).countries.sort((b, a) {
                int intComparison =
                    (a.population ?? -1).compareTo(b.population ?? -1);
                if (intComparison != 0) return intComparison;
                return -1;
              });
            }
            emit(AllCountriesScreenSuccess(
                (state as AllCountriesScreenSuccess).countries,
                event.filterBy,
                event.filterOrder));
          } else if (event.filterBy == FilterName.name) {
            if (event.filterOrder == FilterOrder.asc) {
              (state as AllCountriesScreenSuccess).countries.sort((a, b) {
                return (a.name?.common ?? '').compareTo(b.name?.common ?? '');
              });
            } else if (event.filterOrder == FilterOrder.dsc) {
              (state as AllCountriesScreenSuccess).countries.sort((b, a) {
                return (a.name?.common ?? '').compareTo(b.name?.common ?? '');
              });
            }
            emit(AllCountriesScreenSuccess(
                (state as AllCountriesScreenSuccess).countries,
                event.filterBy,
                event.filterOrder));
          }else if (event.filterBy == FilterName.capital) {
            if (event.filterOrder == FilterOrder.asc) {
              (state as AllCountriesScreenSuccess).countries.sort((a, b) {
                return (a.capital?[0] ?? '').compareTo(b.capital?[0] ?? '');
              });
            } else if (event.filterOrder == FilterOrder.dsc) {
              (state as AllCountriesScreenSuccess).countries.sort((b, a) {
                return (a.capital?[0] ?? '').compareTo(b.capital?[0] ?? '');
              });
            }
            emit(AllCountriesScreenSuccess(
                (state as AllCountriesScreenSuccess).countries,
                event.filterBy,
                event.filterOrder));
          }
        }
      }
    });
  }
}
