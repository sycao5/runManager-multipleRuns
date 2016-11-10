% @BEGIN C3_C4_prepare_step
%
% @in SYNMAP_land_cover_map_data @URI inputs/land_cover/SYNMAP_NA_QD.nc
% @in mean_airtemp @URI file:inputs/narr_air.2m_monthly/air.2m_monthly_{start_year}_{end_year}_mean.{month}.nc
% @in mean_precip @URI file:inputs/narr_apcp_rescaled_monthly/apcp_monthly_{start_year}_{end_year}_mean.{month}.nc

% @out Tair @AS Tair_Matrix @URI file:Tair_{start_year}_{end_year}.mat
% @out Rain @AS Rain_Matrix @URI file:Rain_{start_year}_{end_year}.mat
% @out Grass @AS Grass_variable @URI file:Grass_{start_year}_{end_year}.mat
% @out land_cover_map_mat @URI file:land_cover_map_{start_year}_{end_year}.mat

ncols=480;
nrows=296;
nodatavalue = -999.0;

%% Load input: SYNMAP land cover classification map; also read coordinate variables to re-use them later
% @BEGIN fetch_SYNMAP_land_cover_map_variable
% @in SYNMAP_land_cover_map_data @URI inputs/land_cover/SYNMAP_NA_QD.nc
% @out lon @AS lon_variable
% @out lat @AS lat_variable
% @out lon_bnds @AS lon_bnds_variable
% @out lat_bnds @AS lat_bnds_variable
grass_type=[19,20,21,22,23,24,25,26,27,38,41,42,43];
sncid=netcdf.open('inputs/land_cover/SYNMAP_NA_QD.nc', 'NC_NOWRITE');
fvid=netcdf.inqVarID(sncid, 'biome_frac');
frac=netcdf.getVar(sncid,fvid);
tvid=netcdf.inqVarID(sncid, 'biome_type');
type=netcdf.getVar(sncid,tvid);

lon_vid=netcdf.inqVarID(sncid, 'lon');
lon=netcdf.getVar(sncid,lon_vid);
lat_vid=netcdf.inqVarID(sncid, 'lat');
lat=netcdf.getVar(sncid,lat_vid);
lon_bnds_vid=netcdf.inqVarID(sncid, 'lon_bnds');
lon_bnds=netcdf.getVar(sncid,lon_bnds_vid);
lat_bnds_vid=netcdf.inqVarID(sncid, 'lat_bnds');
lat_bnds=netcdf.getVar(sncid,lat_bnds_vid);

netcdf.close(sncid)

% @END fetch_SYNMAP_land_cover_map_variable

% @BEGIN save_SYNMAP_land_cover_map_variable
% @in lon @AS lon_variable
% @in lat @AS lat_variable
% @in lon_bnds @AS lon_bnds_variable
% @in lat_bnds @AS lat_bnds_variable
% @out land_cover_map_mat @URI file:land_cover_map_{start_year}_{end_year}.mat
save('workspace/land_cover_map_2000_2010.mat', 'lon', 'lat', 'lon_bnds', 'lat_bnds');

% @END save_SYNMAP_land_cover_map_variable


%% Load input: long-term monthly mean air temperature data
% @BEGIN fetch_monthly_mean_air_temperature_data
% @in mean_airtemp @URI file:inputs/narr_air.2m_monthly/air.2m_monthly_{start_year}_{end_year}_mean.{month}.nc
% @out Tair @AS Tair_Matrix @URI file:Tair_{start_year}_{end_year}.mat
Tair=zeros(ncols,nrows,12);
for m=1:12
    tncid=netcdf.open(strcat('inputs/narr_air.2m_monthly/air.2m_monthly_2000_2010_mean.',num2str(m),'.nc'), 'NC_NOWRITE');
    tvid=netcdf.inqVarID(tncid, 'Tair_monthly_mean');
    Tair(:,:,m)=netcdf.getVar(tncid,tvid);
    netcdf.close(tncid)
end
save('workspace/Tair_2000_2010.mat', 'Tair');
% @END fetch_monthly_mean_air_temperature_data


%% Load input: long-term monthly mean precipitation data
% @BEGIN fetch_monthly_mean_precipitation_data
% @in mean_precip @URI file:inputs/narr_apcp_rescaled_monthly/apcp_monthly_{start_year}_{end_year}_mean.{month}.nc
% @out Rain @AS Rain_Matrix @URI file:Rain_{start_year}_{end_year}.mat
Rain=zeros(ncols,nrows,12);
for m=1:12
    rncid=netcdf.open(strcat('inputs/narr_apcp_rescaled_monthly/apcp_monthly_2000_2010_mean.',num2str(m),'.nc'), 'NC_NOWRITE');
    rvid=netcdf.inqVarID(rncid, 'apcp_monthly_mean');
    Rain(:,:,m)=netcdf.getVar(rncid,rvid);
    netcdf.close(rncid)
end
save('workspace/Rain_2000_2010.mat', 'Rain');
% @END fetch_monthly_mean_precipitation_data


%% Initialize Grass Matrix
% @BEGIN initialize_Grass_Matrix
% @out Grass @AS Grass_variable @URI file:Grass_{start_year}_{end_year}.mat
Grass=zeros(ncols,nrows);
for i=1:ncols
    for j=1:nrows
            Grass(i,j)=sum(frac(i,j,20:28))*0.5+sum(frac(i,j,43:44))*0.5+frac(i,j,39)*0.5+frac(i,j,42);
    end
end
save('workspace/Grass_2000_2010.mat', 'Grass');
% @END initialize_Grass_Matrix

% @END C3_C4_prepare_step
