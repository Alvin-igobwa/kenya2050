%module interface2050

%{
#include <stdlib.h>

typedef enum {ExcelEmpty, ExcelNumber, ExcelString, ExcelBoolean, ExcelError, ExcelRange} ExcelType;

struct excel_value {
	ExcelType type;

	double number; // Used for numbers and for error types
	char *string; // Used for strings

	// The following three are used for ranges
	void *array;
	int rows;
	int columns;
};
typedef struct excel_value ExcelValue;

#define EXCEL_NUMBER(numberdouble) ((ExcelValue) {.type = ExcelNumber, .number = numberdouble})
ExcelValue get_cell(ExcelValue *range, int index) {
  return ((ExcelValue *) range->array)[index];

}

void create_range(ExcelValue *range, int size) {
  range->array = malloc(sizeof(ExcelValue)*size);
}

void destroy_range(ExcelValue *range) {
  free(range->array);
}

void set_cell(ExcelValue *range, int index, double number) {
  ((ExcelValue *) range->array)[index] = EXCEL_NUMBER(number);
}

ExcelValue output_metric_emissions_reduction_twentyfifty();

ExcelValue output_metric_emissions_yrzero();

ExcelValue output_warning_l4chosen();

ExcelValue output_warning_exceedl4_rate();

ExcelValue output_warning_bio_imports();

ExcelValue output_warning_land();

ExcelValue output_warning_elec_peak();

ExcelValue output_emissions_sector();

ExcelValue output_primary_energy_consumption();

ExcelValue output_emissions_cumulative();

ExcelValue output_final_energy_consumption();

ExcelValue output_tra_emissions();

ExcelValue output_tra_energy_consumption();

ExcelValue output_tra_pass_distance();

ExcelValue output_tra_energy_consumption_vehicle();

ExcelValue output_buildings_emissions();

ExcelValue output_buildings_energy_consumption();

ExcelValue output_buildings_heat_supply();

ExcelValue output_buildings_heat_demand();

ExcelValue output_ind_emissions();

ExcelValue output_ind_energy_consumption();

ExcelValue output_emissions_removal();

ExcelValue output_emissions_stored_cumulative();

ExcelValue output_gas_grid_dist_supply();

ExcelValue output_hydrogen_production();

ExcelValue output_electricity_emissions();

ExcelValue output_electricity_generation_type();

ExcelValue output_electricity_capacity_type();

ExcelValue output_electricity_peak_demand();

ExcelValue output_land_bio_emissions();

ExcelValue output_land_area_trade_off();

ExcelValue output_land_bioenergy_production();

ExcelValue output_bioenergy_imports();

ExcelValue output_security_import_energy();

ExcelValue output_security_import_fraction();

ExcelValue output_land_map_area();

ExcelValue output_land_map_distance();

ExcelValue output_land_map_numberunits();

ExcelValue output_flows();

ExcelValue output_lever_names();


ExcelValue input_lever_ambition();
void set_input_lever_ambition(ExcelValue newValue);

ExcelValue input_lever_start();
void set_input_lever_start(ExcelValue newValue);

ExcelValue input_lever_end();
void set_input_lever_end(ExcelValue newValue);


void reset();

%}

void create_range(ExcelValue *range, int size);
void destroy_range(ExcelValue *range);
ExcelValue get_cell(ExcelValue *range, int index);
void set_cell(ExcelValue *range, int index, double number);


ExcelValue output_metric_emissions_reduction_twentyfifty();

ExcelValue output_metric_emissions_yrzero();

ExcelValue output_warning_l4chosen();

ExcelValue output_warning_exceedl4_rate();

ExcelValue output_warning_bio_imports();

ExcelValue output_warning_land();

ExcelValue output_warning_elec_peak();

ExcelValue output_emissions_sector();

ExcelValue output_primary_energy_consumption();

ExcelValue output_emissions_cumulative();

ExcelValue output_final_energy_consumption();

ExcelValue output_tra_emissions();

ExcelValue output_tra_energy_consumption();

ExcelValue output_tra_pass_distance();

ExcelValue output_tra_energy_consumption_vehicle();

ExcelValue output_buildings_emissions();

ExcelValue output_buildings_energy_consumption();

ExcelValue output_buildings_heat_supply();

ExcelValue output_buildings_heat_demand();

ExcelValue output_ind_emissions();

ExcelValue output_ind_energy_consumption();

ExcelValue output_emissions_removal();

ExcelValue output_emissions_stored_cumulative();

ExcelValue output_gas_grid_dist_supply();

ExcelValue output_hydrogen_production();

ExcelValue output_electricity_emissions();

ExcelValue output_electricity_generation_type();

ExcelValue output_electricity_capacity_type();

ExcelValue output_electricity_peak_demand();

ExcelValue output_land_bio_emissions();

ExcelValue output_land_area_trade_off();

ExcelValue output_land_bioenergy_production();

ExcelValue output_bioenergy_imports();

ExcelValue output_security_import_energy();

ExcelValue output_security_import_fraction();

ExcelValue output_land_map_area();

ExcelValue output_land_map_distance();

ExcelValue output_land_map_numberunits();

ExcelValue output_flows();

ExcelValue output_lever_names();


ExcelValue input_lever_ambition();
void set_input_lever_ambition(ExcelValue newValue);

ExcelValue input_lever_start();
void set_input_lever_start(ExcelValue newValue);

ExcelValue input_lever_end();
void set_input_lever_end(ExcelValue newValue);


void reset();

typedef enum {ExcelEmpty, ExcelNumber, ExcelString, ExcelBoolean, ExcelError, ExcelRange} ExcelType;

struct excel_value {
	ExcelType type;

	double number; // Used for numbers and for error types
	char *string; // Used for strings

	// The following three are used for ranges
	void *array;
	int rows;
	int columns;
};
typedef struct excel_value ExcelValue;
