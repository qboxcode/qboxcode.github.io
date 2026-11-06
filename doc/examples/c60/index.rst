C\ :sub:`60` Molecule
=====================

.. |c60| replace:: C\ :sub:`60`

This example demonstrates a number of Qbox features in calculations
of the electronic structure of a |c60| molecule

The example includes:

* Calculation of the ground state energy
* Calculation of Kohn-Sham eigenvalues and energy gap
* Maximally Localized Wannier Functions

Ground state energy calculation
-------------------------------
The Kohn-Sham energy of the |c60| molecule is computed using the Local 
Density Approximation (LDA). 

Pseudopotential
^^^^^^^^^^^^^^^
The pseudopotential used for this example is defined in the file
:download:`C_HSCV_LDA-1.0.xml`. 
This file must be present in the current directory when running the first
electronic structure calculation of the |c60| molecule.

Sample definition file
^^^^^^^^^^^^^^^^^^^^^^
The sample is defined in the file
:download:`c60.i` 
where the unit cell is first defined using the :ref:`set_cmd` command and the 
:ref:`cell_var` variable, the species 'carbon' is defined using the
:ref:`species_cmd` command, and
each atom is defined using the :ref:`atom_cmd` Qbox command.

.. code-block:: none
   :caption: c60.i
   :name: c60.i

   set cell 20 0 0  0 20 0  0 0 20
   species carbon C_HSCV_LDA-1.0.xml
   atom C1 carbon 0.0000 1.3127 6.5487
   atom C2 carbon 2.2125 2.6800 5.7037
   atom C3 carbon 1.3674 4.8925 4.3362
   atom C4 carbon -1.3674 4.8925 4.3362
   atom C5 carbon -2.2125 2.6801 5.7036
   atom C6 carbon 0.0000 -1.3124 6.5488
   atom C7 carbon -2.2125 -2.6798 5.7037
   atom C8 carbon 2.2125 -2.6798 5.7037
   atom C9 carbon -1.3674 -4.8925 4.3364
   atom C10 carbon 1.3674 -4.8925 4.3364
   atom C11 carbon 4.3363 1.3674 4.8925
   atom C12 carbon 4.3363 -1.3674 4.8925
   atom C13 carbon 5.7037 2.2126 2.6800
   atom C14 carbon 5.7037 -2.2124 2.6800
   atom C15 carbon 6.5488 0.0000 1.3126
   atom C16 carbon 2.6800 5.7037 2.2125
   atom C17 carbon 4.8925 4.3363 1.3674
   atom C18 carbon 1.3126 6.5488 -0.0000
   atom C19 carbon 4.8925 4.3362 -1.3674
   atom C20 carbon 2.6800 5.7037 -2.2125
   atom C21 carbon -2.6800 5.7037 2.2125
   atom C22 carbon -1.3126 6.5488 -0.0000
   atom C23 carbon -4.8925 4.3363 1.3673
   atom C24 carbon -2.6800 5.7036 -2.2125
   atom C25 carbon -4.8925 4.3362 -1.3675
   atom C26 carbon -4.3363 1.3675 4.8924
   atom C27 carbon -5.7037 2.2125 2.6799
   atom C28 carbon -4.3363 -1.3673 4.8925
   atom C29 carbon -6.5488 0.0000 1.3126
   atom C30 carbon -5.7037 -2.2125 2.6800
   atom C31 carbon 1.3674 -4.8926 -4.3362
   atom C32 carbon 2.2125 -2.6801 -5.7036
   atom C33 carbon 0.0000 -1.3127 -6.5487
   atom C34 carbon -2.2125 -2.6801 -5.7036
   atom C35 carbon -1.3674 -4.8926 -4.3362
   atom C36 carbon 2.6800 -5.7037 -2.2125
   atom C37 carbon 1.3126 -6.5488 0.0001
   atom C38 carbon 4.8925 -4.3363 -1.3674
   atom C39 carbon 2.6800 -5.7036 2.2126
   atom C40 carbon 4.8925 -4.3362 1.3674
   atom C41 carbon 4.3363 -1.3675 -4.8924
   atom C42 carbon 5.7037 -2.2125 -2.6800
   atom C43 carbon 4.3363 1.3673 -4.8925
   atom C44 carbon 6.5488 0.0000 -1.3126
   atom C45 carbon 5.7037 2.2125 -2.6800
   atom C46 carbon 0.0000 1.3124 -6.5488
   atom C47 carbon 2.2125 2.6798 -5.7037
   atom C48 carbon -2.2125 2.6798 -5.7037
   atom C49 carbon 1.3674 4.8923 -4.3364
   atom C50 carbon -1.3674 4.8923 -4.3364
   atom C51 carbon -4.3363 -1.3674 -4.8925
   atom C52 carbon -4.3363 1.3674 -4.8925
   atom C53 carbon -5.7037 -2.2125 -2.6800
   atom C54 carbon -5.7037 2.2125 -2.6800
   atom C55 carbon -6.5488 0.0000 -1.3126
   atom C56 carbon -2.6800 -5.7037 -2.2125
   atom C57 carbon -4.8925 -4.3363 -1.3674
   atom C58 carbon -1.3126 -6.5488 0.0000
   atom C59 carbon -4.8925 -4.3362 1.3674
   atom C60 carbon -2.6800 -5.7036 2.2125

The calculation of the electronic ground state is done using the
Qbox script :download:`c60gs.i`

.. code-block:: none
   :linenos:
   :caption: c60gs.i
   :name: c60gs.i

   c60.i
   set ecut 35
   set wf_dyn PSDA
   set scf_tol 1.e-8
   randomize_wf 0.01
   run -atomic_density 0 40 10
   set wf_diag T
   run 0
   save c60gs.xml

* In line 1, the script ``c60.i`` is invoked and the contents of the 
  script are executed, defining the unit cell, the species ``carbon``
  and the position of all atoms.
* Line 2 defines the plane wave energy cutoff :ref:`ecut_var` to be 35 Ry.
  This resizes the plane wave basis set accordingly.
  Note that the unit used for the plane wave energy cutoff (Rydberg) is
  an exception to the convention used otherwise in Qbox to use 
  atomic units (Hartree and bohr).
* Line 3 defines the algorithm used to update wave functions by setting
  the variable :ref:`wf_dyn_var` to ``PSDA`` (Preconditioned Steepest
  Descent with Anderson acceleration).
* Line 4 defines the tolerance used to determine convergence in 
  self-consistent iterations (variable :ref:`scf_tol_var`).
  Iterations are considered
  converged when the energy changes by less than 10\ :sup:`-8` (hartree).
* Line 5 uses the :ref:`randomize_wf_cmd` command to add random numbers to the
  electronic wave function coefficients before starting the calculation. This
  is necessary to avoid spurious stationary points in the optimization for
  systems of high symmetry (such as |c60|). The argument is the amplitude
  of the random perturbation used.
* Line 6 invokes the :ref:`run_cmd` command to perform the calculation.
  The option ``-atomic_density`` specifies that the initial charge density
  should be approximated by a sum of atomic charge densities. This is
  recommended in calculations of the electronic structure of molecules placed
  in large, empty unit cells.
  The first argument (0) refers to the number of ionic steps (during which the
  atoms are moved). This is zero for the present calculation since we are only
  optimizing the electronic wave functions with fixed atoms. The second argument
  (40) is the maximum number of self-consistent iterations performed. 
  The actual number of iterations may be smaller if the convergence
  criterion :ref:`scf_tol_var` is reached before 40 iterations.
  The third argument (10) is the number of iterations used to update wave
  functions between updates of the charge density.
* Line 7 sets the :ref:`wf_diag_var` variable to T (True) to request the 
  calculation of the Kohn-Sham eigenvalues and eigenvectors in the next
  command.
* Line 8 invokes the :ref:`run_cmd` with a single parameter of ``0``. This
  computes the energy (and in this case, Kohn-Sham eigenvalues and eigenvectors)
  but does not update the electronic wave functions.
* Line 9 uses the :ref:`save_cmd` command to save a full description of the
  system (atomic species, atomic positions and wave functions) on file
  ``c60gs.xml`` for later use in other calculations.

The calculation can be run by invoking Qbox as::

$ mpirun -np 2 qb c60gs.i > c60gs.r

The Kohn-Sham eigenvalues can be extracted from the output file using the
following ``xml_grep`` command::

$ xml_grep eigenset c60gs.r

This produces the following output

.. code-block:: xml

   <?xml version="1.0" ?>
   <xml_grep version="0.9" date="Wed Sep 19 14:50:27 2018">
   <file filename="c60gs.r">
   <eigenset>
   <eigenvalues kpoint="0.00000000 0.00000000 0.00000000" n="120" spin="0" weight="1.00000000">
   -25.40100   -24.88202   -24.88199   -24.88182   -23.89485
   -23.89475   -23.89231   -23.89221   -23.89211   -22.85343
   -22.85333   -22.85327   -22.00744   -22.00434   -22.00424
   -22.00412   -20.70444   -20.70438   -20.69686   -20.69681
   -20.69677   -20.23972   -20.22780   -20.22758   -20.22739
   -18.70004   -18.69993   -18.69752   -18.69739   -18.69726
   -18.49738   -18.49730   -18.49725   -17.44521   -17.44517
   -17.44512   -16.39258   -16.39250   -16.38423   -16.38405
   -16.38380   -16.22562   -16.22550   -16.22547   -15.86992
   -14.67072   -14.66484   -14.66479   -14.66466   -13.90474
   -13.90467   -13.90461   -13.89639   -13.89635   -13.60521
   -13.60518   -13.60505   -13.06592   -12.98945   -12.98941
   -12.98936   -12.38356   -12.38353   -12.38341   -12.28592
   -12.28587   -12.28570   -12.27684   -11.73226   -11.73223
   -11.72320   -11.72310   -11.72300   -11.37361   -11.37354
   -11.36955   -11.35558   -11.35541   -11.35520   -11.26133
   -11.26126   -11.26116   -11.08084   -11.08072   -11.08067
   -10.52467   -10.52403   -10.52394   -10.52382    -9.95413
    -9.95405    -9.95401    -9.52843    -9.52834    -9.52233
    -9.52224    -9.52218    -9.39338    -9.36151    -9.36141
    -9.36134    -9.19187    -9.19175    -9.19172    -9.18587
    -9.18577    -7.88591    -7.88583    -7.86100    -7.77139
    -7.77133    -7.77128    -7.65305    -7.65290    -7.65281
    -6.44126    -6.44120    -6.43436    -6.43429    -6.43423
   </eigenvalues>
   </eigenset>
   </file>
   </xml_grep>

Kohn-Sham eigenvalues are printed in units of electron-volt (eV). 
The results show
that the five topmost eigenvalues belonging to the 
:math:`H_g` irreducible representation of the :math:`I_h` group are close
to the value 6.44 eV. A slight symmetry breaking due to the lower (cubic)
symmetry of the unit cell separates the five eigenvalues into two groups, 
centered at approximately 6.441 and 6.434 eV. 

Structure optimization
----------------------
The initial positions used in the file ``c60.i`` are close but not 
exactly equal to the equilibrium positions. 
A small residual force on all atoms can be seen in the output of the
ground state calculation. This can be shown using e.g. the 
command::

$ xml_grep atom/force c60gs.r

If we are only interested in knowing the *largest* force acting on any atom,
we can use the ``qbox_maxforce.py`` python script (in the ``util`` 
directory) as follows::

$ qbox_maxforce.py c60gs.r

which produces the following output::

  3.628e-03 C38       3.649e-03 C50      -3.632e-03 C41     
 -3.621e-03 C57       3.648e-03 C49      -3.636e-03 C41     

This indicates that the largest force in the *x* direction is acting on 
atom ``C57``, while the largest forces in the *y* and *z* directions
are acting on atoms ``C49`` and ``C41`` respectively. The residual force
is small (of the order of ``3.0e-3`` (hartree/bohr), but it can be 
further reduced by running a structure optmization. 

The structure optimization starts from the previously saved file ``c60gs.xml``
that contains the results from the above 
electronic ground state calculation.

The optimization is described in the Qbox script
:download:`c60cg.i` .

.. code-block:: none
   :linenos:
   :caption: c60cg.i
   :name: c60cg.i

   load c60gs.xml
   set wf_dyn PSDA
   set scf_tol 1.e-8
   set atoms_dyn CG
   run 20 20

Note that the tolerance ``scf_tol`` has been reduced to :math:`10^{-8}`
to get more accuracy in the calculations of forces.

The structure optimization can be run using e.g. the command::

$ mpirun -np 2 qb c60cg.i > c60cg.r

At the end of the optimization, the residual forces are reduced::

$ qbox_maxforce.py c60cg.r

::

  -3.621e-03 C57       3.648e-03 C49      -3.636e-03 C41     
   3.011e-03 C44       3.005e-03 C18       3.019e-03 C1      
   3.070e-03 C41       3.076e-03 C23      -3.087e-03 C50     
  -1.877e-03 C55      -1.877e-03 C37      -1.881e-03 C33     
   1.390e-03 C44       1.392e-03 C22       1.393e-03 C6      
   2.097e-03 C11      -2.118e-03 C40      -2.111e-03 C50     
  -2.670e-03 C41       2.684e-03 C40       2.708e-03 C50     
  -4.443e-04 C57       4.544e-04 C50      -4.475e-04 C41     
   1.939e-04 C44       1.946e-04 C22      -1.959e-04 C33     
  -2.542e-04 C22      -2.494e-04 C33      -2.366e-04 C44     
  -9.379e-05 C54      -9.332e-05 C36      -9.183e-05 C47     
   9.303e-05 C44      -9.345e-05 C58      -9.396e-05 C33     
   6.163e-05 C44      -6.229e-05 C58      -6.284e-05 C33     
  -4.909e-05 C57       5.004e-05 C49       4.981e-05 C12     
   2.976e-05 C44       3.006e-05 C18      -3.039e-05 C46     
   2.287e-05 C37       2.348e-05 C46       2.298e-05 C15     
   1.143e-05 C22       1.173e-05 C33      -1.151e-05 C15     
   8.290e-06 C18      -8.480e-06 C33      -8.220e-06 C44     
   2.831e-05 C44      -2.895e-05 C58      -2.912e-05 C46     
   1.131e-05 C18      -1.148e-05 C33      -1.122e-05 C44     

The residual forces are now of the order of :math:`10^{-5}` (hartree/bohr).

Maximally Localized Wannier Functions (MLWF)
--------------------------------------------
Maximally Localized Wannier Functions (MLWF) can me computed using the 
:download:`c60mlwf.i` script

.. code-block:: none
   :linenos:
   :caption: c60mlwf.i
   :name: c60mlwf.i

   load c60gs.xml
   compute_mlwf

The position of each MLWF center and its spread is printed, together with
the total dipole moment. The total dipole moment is the sum of the 
ionic dipole moment (defined by the sum of valence charges located at the
atomic positions) and the electronic dipole moment (approximated by point 
charges located at the MLWF centers). Dipole moments are printed in 
units of electron*bohr.

The total dipole moment is zero (to a good approximation), as expected for
the |c60| molecule::

  <ionic_dipole> -0.000000 -0.001600 0.000000 </ionic_dipole>
  <total_dipole> 0.000036 -0.000505 0.000155 </total_dipole>
  <total_dipole_length> 0.000530 </total_dipole_length>

