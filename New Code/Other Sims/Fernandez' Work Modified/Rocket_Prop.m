function rocket_prop = Rocket_Prop()
%Returns the static properties of the rocket (engine) to be simulated
Profile = 'WRT';% Use this variable to determine which of the profiles
                % will be used for the simulation
if 1 == strcmp(Profile, 'MMF') 
%N2O Tank Properties
    N2O_Tank_V = 0.0354; % total tank volume [m^3]
    N2O_Ti = 286.5;             % initial temperature [K]: Test 1 
    % N20_Ti = 278.5;             % Test 2
    % N20_Ti = 271.5;             % Test 3
    % N20_Ti = 291.3              % Test 4
    % Given constants
    N2O_m_loaded = 19.32933;    % N2O mass initially loaded into tank [kg]: Test 1
    % N2O_m_loaded = 16.23298;    % Test 2
    % N2O_m_loaded = 14.10076;    % Test 3
    % N2O_m_loaded = 23.62427;    % Test 4
    N2O_Tank_mass = 6.4882;     % tank mass [kg]
%Injector Parameters
    C_D = 0.425;                % discharge coefficient: Test 1
    % C_D = 0.365;                % Test 2 and 3
    % C_D = 0.9;                  % Test 4
    A_inj = 0.0001219352;       % injector hole area [m^2]
    Inj_Loss_Coeff = C_D*A_inj;
elseif 1 == strcmp(Profile, 'WRT')
%    N2O_Tank_V = 4.6/1000;    % volume in m^3
    N2O_Tank_V = 0.004493;
    N2O_Ti = 271.5;
    % Ti = 286.5;             % initial temperature [K]: Test 1 
    % Ti = 278.5;             % Test 2
    % Ti = 271.5;             % Test 3
    % Ti = 291.3              % Test 4
    initial_ullage = 1.0;  %(Value is a percentage)
    % get initial nitrous properties
    tank_liquid_density = nox_Lrho(N2O_Ti, 'kg_m3');
    tank_vapour_density = nox_Vrho(N2O_Ti);
    % base the nitrous vapour volume on the tank percentage ullage 
    %(gas head-space) 
    tank_vapour_volume = (initial_ullage/100.0)*N2O_Tank_V;
    tank_liquid_volume = N2O_Tank_V - tank_vapour_volume;
    tank_liquid_mass = tank_liquid_density * tank_liquid_volume;
    tank_vapour_mass = tank_vapour_density * tank_vapour_volume;
    % total mass within tank
    N2O_m_loaded = tank_liquid_mass + tank_vapour_mass; 
    N2O_Tank_mass = 1.5;
%Injector Paramters
    %orifice_diameter =  0.0015; % 0.25*0.0254/1; %
    orifice_diameter =  0.0016;
    %individual injector orifice total loss coefficent K2
    K2_Coeff = 2;   
    orifice_number = 7;
    A_inj = orifice_number*pi * ((orifice_diameter/2.0))^2;
    Inj_Loss_Coeff = A_inj/sqrt(K2_Coeff);
%Combustion Chamber Parameters
%    Fuel_Grain_Length = 0.60;   % Fuel Grain Length in metres
    Fuel_Grain_Length = 24*.0254;    
%    Fuel_Port_Diam_i = 0.055;   % Initial Fuel Port Diameter: Complicated, because of the geometry. 50-60 mm.
    Fuel_Port_Diam_i = 1.25*0.0254;
%   Fuel_Port_OD = 0.1;         % Outer D of fuel m
    Fuel_Port_OD = 3.5*0.0254;    
    Fuel_Port_Num = 1;
    Fuel_Density = 1190;        % Fuel density in kg/m^3
    Nozzle_TDiam = 0.02;        % Throat Diameter
    Nozzle_EDiam = 0.04;        % Exit Diameter
    Nozzle_TArea = pi*(Nozzle_TDiam/2)^2;
    Nozzle_EArea = pi*(Nozzle_EDiam/2)^2;
elseif 1 == strcmp(Profile, 'HRT')
    N2O_Tank_V = 4.6/1000;
    N2O_Ti = 278.5;
    % Ti = 286.5;             % initial temperature [K]: Test 1 
    % Ti = 278.5;             % Test 2
    % Ti = 271.5;             % Test 3
    % Ti = 291.3              % Test 4
    initial_ullage = 1.0;  %(Value is a percentage)
    % get initial nitrous properties
    tank_liquid_density = nox_Lrho(N2O_Ti, 'kg_m3');
    tank_vapour_density = nox_Vrho(N2O_Ti);
    % base the nitrous vapour volume on the tank percentage ullage 
    %(gas head-space) 
    tank_vapour_volume = (initial_ullage/100.0)*N2O_Tank_V;
    tank_liquid_volume = N2O_Tank_V - tank_vapour_volume;
    tank_liquid_mass = tank_liquid_density * tank_liquid_volume;
    tank_vapour_mass = tank_vapour_density * tank_vapour_volume;
    % total mass within tank
    N2O_m_loaded = tank_liquid_mass + tank_vapour_mass; 
    N2O_Tank_mass = 1.5;
%Injector Paramters
    %orifice_diameter =  0.0015; % 0.25*0.0254/1; %
    orifice_diameter =  0.0016;
    %individual injector orifice total loss coefficent K2
    K2_Coeff = 2;   
    orifice_number = 7;
    A_inj = orifice_number*pi * ((orifice_diameter/2.0))^2;
    Inj_Loss_Coeff = A_inj/sqrt(K2_Coeff);
%Combustion Chamber Parameters
    Fuel_Grain_Length = 0.127;      % Fuel Grain Length in metres
    Fuel_Port_Diam_i = 0.00889*2;   % Initial Fuel Port Diameter: Complicated, because of the geometry. 50-60 mm.
    Fuel_Port_OD = 0.0145*2;        % Outer D of fuel m
    Fuel_Port_Num = 1;
    Fuel_Density = 900;         % Fuel density in kg/m^3
    Nozzle_TDiam = 0.02;        % Throat Diameter
    Nozzle_EDiam = 0.055;        % Exit Diameter
    Nozzle_TArea = pi*(Nozzle_TDiam/2)^2;
    Nozzle_EArea = pi*(Nozzle_EDiam/2)^2;
end    
rocket_prop = [
    N2O_Tank_V,...
    N2O_Ti,...
    N2O_m_loaded,...
    N2O_Tank_mass,...
    0,0,0,0,0,0,...
    Inj_Loss_Coeff,...
    Fuel_Grain_Length,...
    Fuel_Port_Diam_i,...
    Fuel_Port_Num,...
    Fuel_Density,...
    Nozzle_TArea,...
    Nozzle_EArea,...
    Fuel_Port_OD
    ];
end