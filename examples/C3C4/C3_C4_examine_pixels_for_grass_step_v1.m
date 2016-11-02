% @BEGIN C3_C4_examine_pixels_for_grass
%
% @in step1.mat @URI outputs/step1.mat
% @out step2.mat @URI file:outputs/step2.mat

%% Algorithm 1: method used in MstMIP
%  Examine the type of each pixel to see if it includes grass
% @BEGIN examine_pixels_for_grass
% @in Tair @AS Tair_Matrix
% @in Rain @AS Rain_Matrix
% @out C3 @AS C3_Data
% @out C4 @AS C4_Data

load('step1.mat');

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
                if (Tair(i,j,m)<295)
                    nmonth_c3=nmonth_c3+1;
                elseif (Tair(i,j,m)>=295 & Rain(i,j,m)>=2.5)
                    nmonth_c4=nmonth_c4+1;
                elseif (Tair(i,j,m)>=295 & Rain(i,j,m)<=2.5)
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

save('step2.mat', 'C3', 'C4');

% @END examine_pixels_for_grass

% @END C3_C4_examine_pixels_for_grass
