EXTRA_DIST = \
	include \
	autogen.sh

bin_PROGRAMS = Dune
Dune_SOURCES= \
	evolution.cc \
	dune_evolution.cc \
	flux_stationary.cc \
	globals.cc \
	main.cc \
	initsurf.cc \
	rotatematrix.cc \
	initsurfwaves.cc \
	initsurfgauss.cc \
	initsurfcone.cc \
	initsurfmatlab.cc \
	initsurfbeach.cc \
	initsurfparabol.cc \
	initsurfalea.cc \
	analyze_new.cc \
	shear.cc \
	rfftw12d.cc \
	sepbubble.cc \
	avalanche.cc \
	shear_hlr.cc \
	save.cc \
	func.cc \
	PTG_Func2dScalar.cc \
	PTG_Func2dVec.cc \
	wind.cc \
	influx.cc \
	shore.cc \
	vegetation.cc
Dune_CXXFLAGS=\
	-I/opt/local/include -L/opt/local/lib -lfftw3

lib_LTLIBRARIES=libcdm.la
libcdm_la_SOURCES= \
	evolution.cc \
	dune_evolution.cc \
	flux_stationary.cc \
	globals.cc \
	initsurf.cc \
	rotatematrix.cc \
	initsurfwaves.cc \
	initsurfgauss.cc \
	initsurfcone.cc \
	initsurfmatlab.cc \
	initsurfbeach.cc \
	initsurfparabol.cc \
	initsurfalea.cc \
	analyze_new.cc \
	shear.cc \
	rfftw12d.cc \
	sepbubble.cc \
	avalanche.cc \
	shear_hlr.cc \
	save.cc \
	func.cc \
	PTG_Func2dScalar.cc \
	PTG_Func2dVec.cc \
	wind.cc \
	influx.cc \
	shore.cc \
	vegetation.cc \
	bmi.cc
libcdm_la_INCLUDES=\
	bmi.h
libcdm_la_CXXFLAGS=\
	-I$(top_srcdir)/include -I/opt/local/include -L/opt/local/lib -lfftw3
