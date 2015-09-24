%% cdm_master.m
%%
%% Code to set up a simple Coastal Dune Model model and 
%% pull out shear stress and vegetation information

%% INPUTS
project.directory = pwd;
project.windspeed = [sin(0:1:100)*0.25+0.25]; %currently in bed shear stress, m/s; can have multiple values each of length project.duration; 0.2 = around threhold, 0.5 = storm type winds
project.duration = 24; %in hours of each individual simulation
project.timestep = 1; %time step in hours within each simulation, should be evenly divisable in project.duration
project.saveinterval = 24; %save every x number of time steps
project.exeDir = '../../Dune'; %%in linux or macos terms (should be where the model exe is actually being run from)
project.plot_data = 1; %put if you want to plot output

grid.z_file = 'init_h.dat';
grid.dx = 2; %dx = dy in CDM, in meters

veg.veg_file_x = 'init_vx.dat';
veg.veg_file_y = 'init_vy.dat';
veg.zmin = 5; %threshold elevation for veg growth
veg.sigma = 0.75; %ratio of plant basal to frontal area
veg.beta = 150; %ratio of plant drag coefficient to bare sand
veg.m =0.16; %reduction parameter
veg.xmin = 15; %horizontal vegetation limit
veg.Tveg = 3; %characteristic vegetation growth time


%% OUPUTS
grid.z = load(grid.z_file); %load input morphology file
grid.nx = numel(grid.z(:,1)); %determine the number of x grid cells
grid.ny = numel(grid.z(1,:)); %determine number of y cells
project.totaltime = numel(project.windspeed)*project.duration*60*60; %total time in seconds

mkdir(project.directory) %set up project directory if does not exist
mkdir([project.directory, 'CDM_temp']) %create temporary folder for model output
cd(project.directory) %for exectuable need to operate out of primary directory

if project.plot_data == 1
    h1 = figure; title('shear_x'); hold on;
    h2 = figure; title('veget_x'); hold on;
    h3 = figure; title('h'); hold on;
end

for idx = 1:numel(project.windspeed) %loop through all times/environmental conditions
    if idx == 1 %copy executable and input files into right directory
        [~,~,~] = copyfile(grid.z_file, [project.directory, 'init_h.dat']);
        [~,~,~] = copyfile(veg.veg_file_x, [project.directory, 'init_vx.dat']);
        [~,~,~] = copyfile(veg.veg_file_y, [project.directory, 'init_vy.dat']);
        [~,~,~] = copyfile(project.exeDir, [project.directory, 'Dune']);
    else
      [~,~,~] = copyfile([project.directory, 'CDM_temp/h.',sprintf('%05d',project.duration/project.timestep),'.dat'], [project.directory, 'init_h.dat']);
      [~,~,~] = copyfile([project.directory, 'CDM_temp/veget_x.',sprintf('%05d',project.duration/project.timestep),'.dat'], [project.directory, 'init_vx.dat']);
      [~,~,~] = copyfile([project.directory, 'CDM_temp/veget_y.',sprintf('%05d',project.duration/project.timestep),'.dat'], [project.directory, 'init_vy.dat']);                  
    end
    delete([project.directory, 'CDM_temp/*.dat']) %delete all old output files    
    cdm_params(project, grid, veg, idx); %set up parameter file for model
    output = cdm_run(project, idx); %run model through matlab and temporarily store output

    if project.plot_data == 1 %plot data
        figure(h1); plot(0:grid.dx:(grid.nx-1)*grid.dx, output.shear_x(:, round(grid.ny/2)));
        figure(h2); plot(0:grid.dx:(grid.nx-1)*grid.dx, output.veget_x(:, round(grid.ny/2)));
        figure(h3); plot(0:grid.dx:(grid.nx-1)*grid.dx, output.h(:, round(grid.ny/2)));
    end
   
end