% @BEGIN C3_C4_prepare_step
%
% @in SYNMAP_land_cover_map_data @URI inputs/land_cover/SYNMAP_NA_QD.nc
% @in mean_airtemp @URI file:inputs/narr_air.2m_monthly/air.2m_monthly_{start_year}_{end_year}_mean.{month}.nc
% @in mean_precip @URI file:inputs/narr_apcp_rescaled_monthly/apcp_monthly_{start_year}_{end_year}_mean.{month}.nc

% @out step1.mat @URI file:outputs/step1.mat

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

%% Load input: long-term monthly mean air temperature data
% @BEGIN fetch_monthly_mean_air_temperature_data
% @in mean_airtemp @URI file:inputs/narr_air.2m_monthly/air.2m_monthly_{start_year}_{end_year}_mean.{month}.nc
% @out Tair @AS Tair_Matrix
Tair=zeros(ncols,nrows,12);
for m=1:12
    tncid=netcdf.open(strcat('inputs/narr_air.2m_monthly/air.2m_monthly_2000_2010_mean.',num2str(m),'.nc'), 'NC_NOWRITE');
    tvid=netcdf.inqVarID(tncid, 'Tair_monthly_mean');
    Tair(:,:,m)=netcdf.getVar(tncid,tvid);
    netcdf.close(tncid)
end
% @END fetch_monthly_mean_air_temperature_data


%% Load input: long-term monthly mean precipitation data
% @BEGIN fetch_monthly_mean_precipitation_data
% @in mean_precip @URI file:inputs/narr_apcp_rescaled_monthly/apcp_monthly_{start_year}_{end_year}_mean.{month}.nc
% @out Rain @AS Rain_Matrix
Rain=zeros(ncols,nrows,12);
for m=1:12
    rncid=netcdf.open(strcat('inputs/narr_apcp_rescaled_monthly/apcp_monthly_2000_2010_mean.',num2str(m),'.nc'), 'NC_NOWRITE');
    rvid=netcdf.inqVarID(rncid, 'apcp_monthly_mean');
    Rain(:,:,m)=netcdf.getVar(rncid,rvid);
    netcdf.close(rncid)
end
% @END fetch_monthly_mean_precipitation_data


%% Initialize Grass Matrix
% @BEGIN initialize_Grass_Matrix
% @out Grass @AS Grass_variable
Grass=zeros(ncols,nrows);
for i=1:ncols
    for j=1:nrows
            Grass(i,j)=sum(frac(i,j,20:28))*0.5+sum(frac(i,j,43:44))*0.5+frac(i,j,39)*0.5+frac(i,j,42);
    end
end
% @END initialize_Grass_Matrix

save('step1.mat', 'Rain', 'Tair', 'Grass', 'lon', 'lat', 'lon_bnds', 'lat_bnds');

% @END C3_C4_prepare_step
