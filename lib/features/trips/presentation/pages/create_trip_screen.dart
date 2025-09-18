import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../config/style/app_text_styles.dart';
import '../../../../core/utils/app_utils/app_strings.dart';
import '../../../../db_injection.dart';
import '../../repositories/model/city_model.dart';
import '../manager/cities/cubit.dart';
import '../manager/cities/state.dart';
import '../manager/create_trip/cubit.dart';
import '../manager/create_trip/state.dart';
import '../widgets/trip_date_field.dart';
import '../widgets/trip_time_field.dart';

class CreateTripScreen extends StatelessWidget {
  const CreateTripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateTripCubit(sl()),
      child: BlocConsumer<CreateTripCubit, CreateTripState>(
          builder: (context, state) {
            final cubit = context.read<CreateTripCubit>();
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(AppStrings.createNewTrip),
            ),
            body: ListView(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 24.h),
                  children: [
                    _buildTripLine(cubit, state),
                    30.verticalSpace,
                    _buildTripDate(cubit, state)
                  ],
                ),
            bottomNavigationBar: Padding(
              padding:
                  EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h, bottom: 30.h),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: cubit.creatTrip,
                    child:state.loading?const Center(child: CircularProgressIndicator(
                      color: Colors.white,
                    )): const Text(AppStrings.createTrip)),
              ),
            ),
          );
        }, listener: (BuildContext context, CreateTripState state) {
        if (state.success) {
          Navigator.pop(context);
        }
          },
      ),
    );
  }

  Widget _buildTripLine(CreateTripCubit cubit, CreateTripState state) =>
      BlocBuilder<CitiesCubit, CitiesState>(
        builder: (context, citiesState) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.chooseTripLine,
                  style: AppTextStyle.font14black600,
                ),
                15.verticalSpace,
                DropdownButtonFormField<CityModel>(
                  hint: const Text(AppStrings.startCity),
                  items: citiesState.cities
                      .map<DropdownMenuItem<CityModel>>(
                          (e) => DropdownMenuItem<CityModel>(
                                value: e,
                                child: Text(e.name??""),
                              ))
                      .toList(),
                  onChanged: (city) {
                    cubit.selectCities(startCity: city);
                  },
                  value: state.startCity,
                ),
                15.verticalSpace,
                DropdownButtonFormField<CityModel>(
                  hint: const Text(AppStrings.destenationCity),
                  items: citiesState.cities
                      .map<DropdownMenuItem<CityModel>>(
                          (e) => DropdownMenuItem<CityModel>(
                                value: e,
                                child: Text(e.name??""),
                              ))
                      .toList(),
                  onChanged: (city) {
                    cubit.selectCities(destenationCity: city);
                  },
                  value: state.destinationCity,
                )
              ]);
        },
      );
  Widget _buildTripDate(CreateTripCubit cubit, CreateTripState state) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          AppStrings.chooseTripTime,
          style: AppTextStyle.font14black600,
        ),
        15.verticalSpace,
        TripDateField(controller: state.dateController),
        15.verticalSpace,
        TripTimeField(controller: state.timeController),
      ]);
}
