si64.i
set ecut 12
set wf_dyn PSDA
randomize_wf
set scf_tol 1.e-6
run 0 30 5
save si64gs.xml
