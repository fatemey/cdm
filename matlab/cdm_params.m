function cdm_params(project, grid, veg, idx)
    fid = fopen([project.directory, 'params.par'], 'w');
    fprintf(fid, '%s\n', ['NX = ', num2str(grid.nx)]);
    fprintf(fid, '%s\n', ['NY = ', num2str(grid.ny)]);
    fprintf(fid, '%s\n', ['dx = ', num2str(grid.dx)]);
    fprintf(fid, '%s\n', ['dt_max = ', num2str(project.timestep*3600)]);
    fprintf(fid, '%s\n', ['Nt = ', num2str(project.duration/project.timestep)]);
    fprintf(fid, '%s\n', ['Nt0 = 0']);
    fprintf(fid, '%s\n', ['save.every = ', num2str(project.saveinterval)]);
    fprintf(fid, '%s\n', ['save.x-line = 0']);
    fprintf(fid, '%s\n', ['save.dir = ./CDM_temp']);
    fprintf(fid, '%s\n', ['calc.x_periodic = 0']);
    fprintf(fid, '%s\n', ['calc.y_periodic = 1']);
    fprintf(fid, '%s\n', ['calc.shift_back = 0']);
    fprintf(fid, '%s\n', ['influx = const']);
    fprintf(fid, '%s\n', ['q_in = 0']); %since the new model should inherintly add in the q_in term we leave this as zero for the time being
    fprintf(fid, '%s\n', ['wind = const']);
    fprintf(fid, '%s\n', ['constwind.u = ', num2str(project.windspeed(idx))]);
   % fprintf(fid, '%s\n', ['constwind.direction = ', num2str(project.winddir(idx))]); %dont think this actually works  unless is onshore vs. offshore
    fprintf(fid, '%s\n', ['wind.fraction = 1']);
    fprintf(fid, '%s\n', ['veget.calc = 1']);
    fprintf(fid, '%s\n', ['veget.xmin = ', num2str(veg.xmin)]);
    fprintf(fid, '%s\n', ['veget.zmin = ', num2str(veg.zmin)]);
    fprintf(fid, '%s\n', ['veget.Tveg = ', num2str(veg.Tveg)]);
    fprintf(fid, '%s\n', ['veget.sigma = ', num2str(veg.sigma)]);
    fprintf(fid, '%s\n', ['veget.beta = ', num2str(veg.beta)]);
    fprintf(fid, '%s\n', ['veget.m = ', num2str(veg.m)]);
    fprintf(fid, '%s\n', ['veget.season.t = 0']);
    fprintf(fid, '%s\n', ['veget.Vlateral.factor = 0']);
    fprintf(fid, '%s\n', ['calc.shore = 1']);
    fprintf(fid, '%s\n', ['beach.tau_t_L = 0.5']);
    fprintf(fid, '%s\n', ['shore.MHWL = 0']);
    fprintf(fid, '%s\n', ['shore.sealevel = 0']);
    fprintf(fid, '%s\n', ['shore.motion = 0']);
    fprintf(fid, '%s\n', ['shore.sealevelrise = 0']);
    fprintf(fid, '%s\n', ['shore.alongshore_grad = 0']);
    fprintf(fid, '%s\n', ['calc.storm = 0']);
    fprintf(fid, '%s\n', ['shore.correct.profile = 1']);
    
    fprintf(fid, '%s\n', ['init_h.x-line = 0']);
    fprintf(fid, '%s\n', ['veget.Init-Surf = init_h']);
    fprintf(fid, '%s\n', ['veget.init_h.file = init_vx.dat']);
    fprintf(fid, '%s\n', ['veget.init_h.file_aux = init_vy.dat']);
    fprintf(fid, '%s\n', ['Init-Surf = init_h']);
    fprintf(fid, '%s\n', ['init_h.file= init_h.dat']);


    %0 = save, 1 = don't save
    fprintf(fid, '%s\n', ['dontsave.veget = 0']);
    fprintf(fid, '%s\n', ['dontsave.u = 0']);
    fprintf(fid, '%s\n', ['dontsave.flux = 1']);
    fprintf(fid, '%s\n', ['dontsave.flux_s = 1']);
    fprintf(fid, '%s\n', ['dontsave.shear = 0']);
    fprintf(fid, '%s\n', ['dontsave.shear_pert = 0']);
    fprintf(fid, '%s\n', ['dontsave.stall = 0']);
    fprintf(fid, '%s\n', ['dontsave.rho = 1']);
    fprintf(fid, '%s\n', ['dontsave.h_deposit = 1']);
    fprintf(fid, '%s\n', ['dontsave.h_nonerod = 1']);
    fprintf(fid, '%s\n', ['dontsave.h_sep = 1']);
    fprintf(fid, '%s\n', ['dontsave.dhdt = 1']);
    fclose(fid); 

end