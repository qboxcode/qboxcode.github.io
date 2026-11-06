load si64gs.xml
# randomize velocities
randomize_v 300
set scf_tol 1.e-6
# run 100 MD steps
set dt 40
set atoms_dyn MD
run 100 20
