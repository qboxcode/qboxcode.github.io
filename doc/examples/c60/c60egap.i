load gs.xml
set wf_dyn JD
set nempty 50
run 0 10 5 
plot -density c60density.cube
plot -wf 120 homo.cube
