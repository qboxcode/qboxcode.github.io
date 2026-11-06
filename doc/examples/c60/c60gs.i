c60.i
set ecut 35
set wf_dyn PSDA
randomize_wf 0.01
set scf_tol 1.e-8
run -atomic_density 0 40 10
set wf_diag T
run 0
save gs.xml
