load si64gs.xml
# print Si57-Si58 distance
distance Si57 Si58
# displace atoms
move Si57 by  0.1  0.1  0.1
move Si58 by -0.1 -0.1 -0.1
distance Si57 Si58
# recompute the ground state
set wf_dyn PSDA
set scf_tol 1.e-6
run 0 20
# optimize the geometry again
set atoms_dyn CG
run 20 20
