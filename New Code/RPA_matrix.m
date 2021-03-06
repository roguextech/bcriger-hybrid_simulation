function surf_datum = RPA_matrix(big_data_table, z_column, of, pres)
%This function returns a cell array {X,Y,Z} from the nested analysis tables
%produced by RPA Lite. Inputs are:
% - The giant table produced by importing a nested analysis text file from
%RPA.
% - Which column you want to make a surface (possibly temperature, Isp)
% - Vector of O/F ratios
% - Vector of chamber pressures

three_col=[big_data_table(:,1),big_data_table(:,2),...
    big_data_table(:,z_column)]
[rows,~]=size(three_col);

%RPA puts 0 values for temperature when it errors out. We eliminate them.
three_cols=[];
for row_idx = 1:rows
    if three_col(row_idx,3)~=0
        three_cols=[three_cols;three_col(row_idx,:)];
    end
end

[X,Y]=meshgrid(of,pres);
Z=griddata(three_cols(:,1),three_cols(:,2),three_cols(:,3),X,Y);
surf_datum={X,Y,Z};