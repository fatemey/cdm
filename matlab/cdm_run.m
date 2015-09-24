function output = cdm_run(project, idx)

system('./Dune params.par > output &'); %stores model info to output file
%system('./Dune params.par'); %run this line instead if want to plot everything to matlab command line

display(['Simulation ', num2str(idx), ' complete!'])

try
    output.h = load([project.directory, 'CDM_temp/h.', sprintf('%05d',project.duration/project.timestep),'.dat']);
    output.veget_x = load([project.directory, 'CDM_temp/veget_x.', sprintf('%05d',project.duration/project.timestep),'.dat']);
    output.veget_y = load([project.directory, 'CDM_temp/veget_y.', sprintf('%05d',project.duration/project.timestep),'.dat']);
    output.shear_pert_x = load([project.directory, 'CDM_temp/shear_pert_x.', sprintf('%05d',project.duration/project.timestep),'.dat']);
    output.shear_pert_y = load([project.directory, 'CDM_temp/shear_pert_y.', sprintf('%05d',project.duration/project.timestep),'.dat']);
    output.shear_x = load([project.directory, 'CDM_temp/shear_x.', sprintf('%05d',project.duration/project.timestep),'.dat']);
    output.shear_y = load([project.directory, 'CDM_temp/shear_y.', sprintf('%05d',project.duration/project.timestep),'.dat']);
    output.stall = load([project.directory, 'CDM_temp/stall.', sprintf('%05d',project.duration/project.timestep),'.dat']);
    output.u_x = load([project.directory, 'CDM_temp/u_x.', sprintf('%05d',project.duration/project.timestep),'.dat']);
    output.u_y = load([project.directory, 'CDM_temp/u_y.', sprintf('%05d',project.duration/project.timestep),'.dat']);
catch err
    pause(1) %need to add in a short pause between runs b/c model needs time to write out, 1 s seems to be plenty  
    output.h = load([project.directory, 'CDM_temp/h.', sprintf('%05d',project.duration/project.timestep),'.dat']);
    output.veget_x = load([project.directory, 'CDM_temp/veget_x.', sprintf('%05d',project.duration/project.timestep),'.dat']);
    output.veget_y = load([project.directory, 'CDM_temp/veget_y.', sprintf('%05d',project.duration/project.timestep),'.dat']);
    output.shear_pert_x = load([project.directory, 'CDM_temp/shear_pert_x.', sprintf('%05d',project.duration/project.timestep),'.dat']);
    output.shear_pert_y = load([project.directory, 'CDM_temp/shear_pert_y.', sprintf('%05d',project.duration/project.timestep),'.dat']);
    output.shear_x = load([project.directory, 'CDM_temp/shear_x.', sprintf('%05d',project.duration/project.timestep),'.dat']);
    output.shear_y = load([project.directory, 'CDM_temp/shear_y.', sprintf('%05d',project.duration/project.timestep),'.dat']);
    output.stall = load([project.directory, 'CDM_temp/stall.', sprintf('%05d',project.duration/project.timestep),'.dat']);
    output.u_x = load([project.directory, 'CDM_temp/u_x.', sprintf('%05d',project.duration/project.timestep),'.dat']);
    output.u_y = load([project.directory, 'CDM_temp/u_y.', sprintf('%05d',project.duration/project.timestep),'.dat']);
end

end