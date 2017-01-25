% @BEGIN C3_C4_examine_pixels_for_grass
%
% @in Tair @AS Tair_Matrix @URI file:Tair_{start_year}_{end_year}.mat
% @in Rain @AS Rain_Matrix @URI file:Rain_{start_year}_{end_year}.mat
% @in Grass @AS Grass_variable @URI file:Grass_{start_year}_{end_year}.mat
% @out C3_mat @AS C3_Matrix @URI file:C3_{start_year}_{end_year}.mat
% @out C4_mat @AS C4_Matrix @URI file:C4_{start_year}_{end_year}.mat


%% Algorithm 1: method used in MstMIP
%  Examine the type of each pixel to see if it includes grass
% @BEGIN examine_pixels_for_grass
% @in Tair @AS Tair_Matrix
% @in Rain @AS Rain_Matrix
% @in Grass @AS Grass_variable @URI file:Grass_{start_year}_{end_year}.mat
% @out C3 @AS C3_Matrix @URI file:C3_{start_year}_{end_year}.mat
% @out C4 @AS C4_Matrix @URI file:C4_{start_year}_{end_year}.mat

load('workspace/Tair_2000_2010.mat');
load('workspace/Rain_2000_2010.mat');
load('workspace/Grass_2000_2010.mat');

ncols=480;
nrows=296;

threshold=2.5;
%threshold=5;

C3=ones(ncols, nrows)*(-999.0);
C4=ones(ncols, nrows)*(-999.0);
for i=1:ncols
    for j=1:nrows
        frac_c3=0.0;
        frac_c4=0.0;
        if (Grass(i,j)>0)
            ngrow=0;
            nmonth_c3=0;
            nmonth_c4=0;
            for m=1:12
                if (Tair(i,j,m)>278)
                    ngrow=ngrow+1;
                end
                if (Tair(i,j,m)<(nrows-1)) 
                    nmonth_c3=nmonth_c3+1;
                elseif (Tair(i,j,m)>=(nrows-1) & Rain(i,j,m)>=threshold)
                    nmonth_c4=nmonth_c4+1;
                elseif (Tair(i,j,m)>=(nrows-1) & Rain(i,j,m)<=threshold)
                    nmonth_c3=nmonth_c3+1;
                end
            end
            if (nmonth_c3==12)
                frac_c3=1;
                frac_c4=0.0;
            elseif (nmonth_c4>=1)
                frac_c4=nmonth_c4/ngrow;
                frac_c3=1-frac_c4;
            end
        end
            C3(i,j)=frac_c3;
            C4(i,j)=frac_c4;
    end
end

save('workspace/C3_2000_2010.mat', 'C3');
save('workspace/C4_2000_2010.mat', 'C4');

% @END examine_pixels_for_grass

% @END C3_C4_examine_pixels_for_grass
