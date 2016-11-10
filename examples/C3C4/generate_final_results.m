% @BEGIN C3_C4_generate_results_step
%
% @in Grass @AS Grass_Matrix @URI file:Grass_{start_year}_{end_year}.mat
% @in land_cover_map_mat @URI file:land_cover_map_{start_year}_{end_year}.mat
% @in C3_mat @AS C3_Matrix @URI file:C3_{start_year}_{end_year}.mat
% @in C4_mat @AS C4_Matrix @URI file:C4_{start_year}_{end_year}.mat

% @out C3_fraction_data @URI file:outputs/SYNMAP_PRESENTVEG_C3Grass_RelaFrac_NA_v2.0.nc
% @out C4_fraction_data @URI file:outputs/SYNMAP_PRESENTVEG_C4Grass_RelaFrac_NA_v2.0.nc
% @out Grass_fraction_data @URI file:outputs/SYNMAP_PRESENTVEG_Grass_Fraction_NA_v2.0.nc

load('workspace/Grass_2000_2010.mat');
load('workspace/land_cover_map_2000_2010.mat');
load('workspace/C3_2000_2010.mat');
load('workspace/C4_2000_2010.mat');

ncols=480;
nrows=296;
nodatavalue = -999.0;

%% Output the netcdf file for C3 fraction
%  Reuse longitude, latitude, and boundary variables from land cover input file
% @BEGIN generate_netcdf_file_for_C3_fraction
% @in land_cover_map_mat
% @in C3_Matrix
% @out C3_fraction_data @URI file:outputs/SYNMAP_PRESENTVEG_C3Grass_RelaFrac_NA_v2.0.nc
moncid=netcdf.create('outputs/SYNMAP_PRESENTVEG_C3Grass_RelaFrac_NA_v2.0.nc', 'NC_CLOBBER');% create netCDF dataset (filename,mode)

mdid_lon = netcdf.defDim(moncid, 'lon', ncols);
mdid_lat = netcdf.defDim(moncid, 'lat', nrows);
mdid_nv = netcdf.defDim(moncid, 'nv', 2);

mvid_crs = netcdf.defVar(moncid, 'crs', 'char', []);
netcdf.putAtt(moncid, mvid_crs, 'grid_mapping_name', 'latitude_longitude');
netcdf.putAtt(moncid, mvid_crs, 'semi_major_axis', 6370997.0);
netcdf.putAtt(moncid, mvid_crs, 'inverse_flattening', 0.0);

mvid_lon = netcdf.defVar(moncid, 'lon', 'double', mdid_lon);
netcdf.putAtt(moncid, mvid_lon, 'standard_name', 'longitude');
netcdf.putAtt(moncid, mvid_lon, 'long_name', 'longitude coordinate');
netcdf.putAtt(moncid, mvid_lon, 'units', 'degrees_east');
netcdf.putAtt(moncid, mvid_lon, 'bounds', 'lon_bnds');

mvid_lat = netcdf.defVar(moncid, 'lat', 'double', mdid_lat);
netcdf.putAtt(moncid, mvid_lat, 'standard_name', 'latitude');
netcdf.putAtt(moncid, mvid_lat, 'long_name', 'latitude coordinate');
netcdf.putAtt(moncid, mvid_lat, 'units', 'degrees_north');
netcdf.putAtt(moncid, mvid_lat, 'bounds', 'lat_bnds');

mvid_lon_bnds = netcdf.defVar(moncid, 'lon_bnds', 'double', [mdid_nv, mdid_lon]);
mvid_lat_bnds = netcdf.defVar(moncid, 'lat_bnds', 'double', [mdid_nv, mdid_lat]);

mvid_data = netcdf.defVar(moncid, 'C3_frac', 'double', [mdid_lon, mdid_lat]);
netcdf.putAtt(moncid, mvid_data, 'long_name', 'relative fraction of C3 grass based on potential SYNMAP');
%netcdf.putAtt(moncid, mvid_data, 'units', ovunits);
%netcdf.putAtt(moncid, mvid_data, 'cell_methods', ocell_methods);
%netcdf.putAtt(moncid, mvid_data, '_FillValue', nodatavalue);
netcdf.putAtt(moncid, mvid_data, 'missing_value', nodatavalue);
netcdf.putAtt(moncid, mvid_data, 'grid_mapping', 'crs');

% put global attributes
netcdf.putAtt(moncid, netcdf.getConstant('GLOBAL'), 'Conventions', 'CF-1.4');
netcdf.putAtt(moncid, netcdf.getConstant('GLOBAL'), 'version', '2.0');

% Enter into data mode to write data
netcdf.endDef(moncid);

% Put aux data in long term mean data
netcdf.putVar(moncid, mvid_lon, lon);
netcdf.putVar(moncid, mvid_lat, lat);
netcdf.putVar(moncid, mvid_lon_bnds, lon_bnds);
netcdf.putVar(moncid, mvid_lat_bnds, lat_bnds);
netcdf.putVar(moncid, mvid_data, C3);

netcdf.close(moncid)
% @END generate_netcdf_file_for_C3_fraction

%% Output the netcdf file for C4 fraction
% Reuse longitude, latitude, and boundary variables from land cover input file
% @BEGIN generate_netcdf_file_for_C4_fraction
% @in land_cover_map_mat
% @in C4_Matrix
% @out C4_fraction_data @URI file:outputs/SYNMAP_PRESENTVEG_C4Grass_RelaFrac_NA_v2.0.nc
moncid=netcdf.create('outputs/SYNMAP_PRESENTVEG_C4Grass_RelaFrac_NA_v2.0.nc', 'NC_CLOBBER');% create netCDF dataset (filename,mode)

mdid_lon = netcdf.defDim(moncid, 'lon', ncols);
mdid_lat = netcdf.defDim(moncid, 'lat', nrows);
mdid_nv = netcdf.defDim(moncid, 'nv', 2);

mvid_crs = netcdf.defVar(moncid, 'crs', 'char', []);
netcdf.putAtt(moncid, mvid_crs, 'grid_mapping_name', 'latitude_longitude');
netcdf.putAtt(moncid, mvid_crs, 'semi_major_axis', 6370997.0);
netcdf.putAtt(moncid, mvid_crs, 'inverse_flattening', 0.0);

mvid_lon = netcdf.defVar(moncid, 'lon', 'double', mdid_lon);
netcdf.putAtt(moncid, mvid_lon, 'standard_name', 'longitude');
netcdf.putAtt(moncid, mvid_lon, 'long_name', 'longitude coordinate');
netcdf.putAtt(moncid, mvid_lon, 'units', 'degrees_east');
netcdf.putAtt(moncid, mvid_lon, 'bounds', 'lon_bnds');

mvid_lat = netcdf.defVar(moncid, 'lat', 'double', mdid_lat);
netcdf.putAtt(moncid, mvid_lat, 'standard_name', 'latitude');
netcdf.putAtt(moncid, mvid_lat, 'long_name', 'latitude coordinate');
netcdf.putAtt(moncid, mvid_lat, 'units', 'degrees_north');
netcdf.putAtt(moncid, mvid_lat, 'bounds', 'lat_bnds');

mvid_lon_bnds = netcdf.defVar(moncid, 'lon_bnds', 'double', [mdid_nv, mdid_lon]);
mvid_lat_bnds = netcdf.defVar(moncid, 'lat_bnds', 'double', [mdid_nv, mdid_lat]);

mvid_data = netcdf.defVar(moncid, 'C4_frac', 'double', [mdid_lon, mdid_lat]);
netcdf.putAtt(moncid, mvid_data, 'long_name', 'relative fraction of C4 grass based on potential SYNMAP');
%netcdf.putAtt(moncid, mvid_data, 'units', ovunits);
%netcdf.putAtt(moncid, mvid_data, 'cell_methods', ocell_methods);
%netcdf.putAtt(moncid, mvid_data, '_FillValue', nodatavalue);
netcdf.putAtt(moncid, mvid_data, 'missing_value', nodatavalue);
netcdf.putAtt(moncid, mvid_data, 'grid_mapping', 'crs');

% put global attributes
netcdf.putAtt(moncid, netcdf.getConstant('GLOBAL'), 'Conventions', 'CF-1.4');
netcdf.putAtt(moncid, netcdf.getConstant('GLOBAL'), 'version', '2.0');

% Enter into data mode to write data
netcdf.endDef(moncid);

% Put aux data in long term mean data
netcdf.putVar(moncid, mvid_lon, lon);
netcdf.putVar(moncid, mvid_lat, lat);
netcdf.putVar(moncid, mvid_lon_bnds, lon_bnds);
netcdf.putVar(moncid, mvid_lat_bnds, lat_bnds);
netcdf.putVar(moncid, mvid_data, C4);

netcdf.close(moncid)
% @END generate_netcdf_file_for_C4_fraction


%% Output the netcdf file for Grass fraction
% Reuse longitude, latitude, and boundary variables from land cover input file
% @BEGIN generate_netcdf_file_for_Grass_fraction
% @in land_cover_map_mat
% @in Grass_Matrix
% @out Grass_fraction_data @URI file:outputs/SYNMAP_PRESENTVEG_Grass_Fraction_NA_v2.0.nc
moncid=netcdf.create('outputs/SYNMAP_PRESENTVEG_Grass_Fraction_NA_v2.0.nc', 'NC_CLOBBER');% create netCDF dataset (filename,mode)

mdid_lon = netcdf.defDim(moncid, 'lon', ncols);
mdid_lat = netcdf.defDim(moncid, 'lat', nrows);
mdid_nv = netcdf.defDim(moncid, 'nv', 2);

mvid_crs = netcdf.defVar(moncid, 'crs', 'char', []);%variable name is 'crs'? type 'char'
netcdf.putAtt(moncid, mvid_crs, 'grid_mapping_name', 'latitude_longitude');
netcdf.putAtt(moncid, mvid_crs, 'semi_major_axis', 6370997.0);
netcdf.putAtt(moncid, mvid_crs, 'inverse_flattening', 0.0);

mvid_lon = netcdf.defVar(moncid, 'lon', 'double', mdid_lon);
netcdf.putAtt(moncid, mvid_lon, 'standard_name', 'longitude');
netcdf.putAtt(moncid, mvid_lon, 'long_name', 'longitude coordinate');
netcdf.putAtt(moncid, mvid_lon, 'units', 'degrees_east');
netcdf.putAtt(moncid, mvid_lon, 'bounds', 'lon_bnds');

mvid_lat = netcdf.defVar(moncid, 'lat', 'double', mdid_lat);
netcdf.putAtt(moncid, mvid_lat, 'standard_name', 'latitude');
netcdf.putAtt(moncid, mvid_lat, 'long_name', 'latitude coordinate');
netcdf.putAtt(moncid, mvid_lat, 'units', 'degrees_north');
netcdf.putAtt(moncid, mvid_lat, 'bounds', 'lat_bnds');

mvid_lon_bnds = netcdf.defVar(moncid, 'lon_bnds', 'double', [mdid_nv, mdid_lon]);
mvid_lat_bnds = netcdf.defVar(moncid, 'lat_bnds', 'double', [mdid_nv, mdid_lat]);

mvid_data = netcdf.defVar(moncid, 'grass', 'double', [mdid_lon, mdid_lat]);
netcdf.putAtt(moncid, mvid_data, 'long_name', 'grass fraction based on potential SYNMAP');
%netcdf.putAtt(moncid, mvid_data, 'units', ovunits);
%netcdf.putAtt(moncid, mvid_data, 'cell_methods', ocell_methods);
%netcdf.putAtt(moncid, mvid_data, '_FillValue', nodatavalue);
netcdf.putAtt(moncid, mvid_data, 'missing_value', nodatavalue);
netcdf.putAtt(moncid, mvid_data, 'grid_mapping', 'crs');

% put global attributes
netcdf.putAtt(moncid, netcdf.getConstant('GLOBAL'), 'Conventions', 'CF-1.4');
netcdf.putAtt(moncid, netcdf.getConstant('GLOBAL'), 'version', '1.0');

% Enter into data mode to write data
netcdf.endDef(moncid);

% Put aux data in long term mean data
netcdf.putVar(moncid, mvid_lon, lon);
netcdf.putVar(moncid, mvid_lat, lat);
netcdf.putVar(moncid, mvid_lon_bnds, lon_bnds);
netcdf.putVar(moncid, mvid_lat_bnds, lat_bnds);
netcdf.putVar(moncid, mvid_data, Grass);

netcdf.close(moncid)
% @END generate_netcdf_file_for_Grass_fraction

% @END C3_C4_generate_results_step
