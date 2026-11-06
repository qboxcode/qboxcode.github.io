.. _cmd_index:

=============
Qbox commands
=============

* :ref:`angle_cmd` - compute the angle formed by three atoms
* :ref:`atom_cmd` - define an atom
* :ref:`bisection_cmd` - apply recursive bisection to wave functions
* :ref:`compute_mlwf_cmd` - compute maximally localized Wannier functions
* :ref:`constraint_cmd` - manage constraints on atomic positions
* :ref:`distance_cmd` - compute the distance between two atoms
* :ref:`extforce_cmd` - add external forces on atoms
* :ref:`fold_in_ws_cmd` - fold atoms into the Wigner-Seitz cell
* :ref:`help_cmd` - print a short message about the use of a command
* :ref:`kpoint_cmd` - manage the set of k-points
* :ref:`list_atoms_cmd` - print a list of currently defined atoms
* :ref:`list_species_cmd` - print a list of currently defined atomic species
* :ref:`load_cmd` - load a sample from a previously saved restart file
* :ref:`move_cmd` - move atoms
* :ref:`partial_charge_cmd` - compute the electronic charge in atom-centered spheres
* :ref:`plot_cmd` - generate a plot file with atoms and/or charge density
* :ref:`print_cmd` - print the value of a Qbox variable
* :ref:`quit_cmd` - exit Qbox
* :ref:`randomize_r_cmd` - add random noise to the atomic positions
* :ref:`randomize_v_cmd` - add random noise to the atomic velocities
* :ref:`randomize_wf_cmd` - add random noise to the wave function coefficients
* :ref:`rescale_v_cmd` - rescale all atomic velocities
* :ref:`reset_rotation_cmd` - reset atomic velocities to cancel global rotations
* :ref:`reset_vcm_cmd` - set the velocity of the center of mass to zero
* :ref:`response_cmd` - compute the polarizability or response to a potential
* :ref:`rseed_cmd` - initialize the random number generator
* :ref:`run_cmd` - run MD or electronic optimization steps
* :ref:`save_cmd` - save a sample on a restart file for later use
* :ref:`set_cmd` - assign a value to a Qbox variable
* :ref:`set_velocity_cmd` - set the velocity of an atom
* :ref:`species_cmd` - define a new atomic species
* :ref:`spectrum_cmd` - compute the optical absorption spectrum
* :ref:`status_cmd` - print a summary of the current state
* :ref:`strain_cmd` - impose a strain on the sample
* :ref:`torsion_cmd` - compute the dihedral angle defined by four atoms
* :ref:`!(shell escape)_cmd` - execute a shell command

.. _angle_cmd:

angle
-----

 NAME

  **angle** -- compute the angle defined by three atoms

 SYNOPSIS

  **angle [-pbc]** *atom1* *atom2* *atom3*

 DESCRIPTION

  The **angle** command prints the value of the angle formed by the three atoms
  given as arguments. The names *atom1*, *atom2* and *atom3*  must refer to the
  names of atoms currently defined in the sample. If the **-pbc** option is
  used, the positions of the atoms are interpreted as those of the nearest atom
  replica, taking into account periodic boundary conditions.

.. _atom_cmd:

atom
----

 NAME

  **atom** -- add an atom to the current sample

 SYNOPSIS

  **atom** *name*  *species* *x* *y* *z* [*vx* *vy* *vz*]

 DESCRIPTION

  The **atom** command adds an atom to the current sample.
  The *name* argument can
  be any character string but must differ from all the other names of atoms in
  the current sample. The *species* argument must refer to an atomic species
  previously defined using the :ref:`species_cmd` command. The position of the
  atom is specified by its coordinates *x*, *y*, *z* in atomic units (bohr).
  Optionally, the velocity of the atom can be specified by its components *vx*,
  *vy*, *vz* in atomic units (bohr/atomic-unit-of-time).
  (One atomic-unit-of-time is 0.02418885 fs).

 RELATED INFORMATION

  :ref:`list_atoms_cmd`, :ref:`species_cmd`

.. _bisection_cmd:

bisection
---------

 NAME

  **bisection** -- perform recursive subspace bisection of the wave functions

 SYNOPSIS

  **bisection** *lx ly lz threshold*

 DESCRIPTION

  The **bisection** command transforms electronic wave functions according to
  the recursive subspace bisection algorithm, as described in
  [F. Gygi, Phys. Rev. Lett. 102, 166406 (2009)].
  The resulting wave functions are maximally localized in
  rectangular domains defined by recursively subdividing the unit cell lx, ly,
  and lz times in the x, y, and z directions respectively. The lx, ly, lz
  arguments define the level of recursion used in the x, y, z directions. The
  threshold argument is used to print information about the bisected wave
  functions. For each wave function, the bisection command prints the value of
  the localization vector, the size of the wave function and the number of
  non-zero overlaps with other functions (for the given value of the threshold).
  The localization vector is a binary vector in which a pair of bits is
  associated with each of the bisecting planes of the recursive bisection
  process, starting at the least significant bit. Within each pair of bits, a
  value of 1 signifies that the wave function has significant amplitude on one
  side of the corresponding bisecting plane. Thus the bit pattern “11” signifies
  that the wave function is extended across the corresponding bisecting plane,
  while the bit patterns “01” and “10” signify that the wave function is
  localized on one side only of the bisecting plane. The bit values are defined
  by the amount of electronic charge located on either side of the bisecting
  plane. The value is 1 if the amount of charge is larger than the threshold. At
  the end of the bisection command, wave functions are transformed so as to be
  maximally localized in the subdomains defined by the bisection planes. The
  effect of recursive bisection can then be inspected using the plot command.

.. _compute_mlwf_cmd:

compute_mlwf
------------

 NAME

  **compute_mlwf** –- compute maximally localized Wannier functions

 SYNOPSIS

  **compute_mlwf**

 DESCRIPTION

  The **compute_mlwf** command transforms the current wave functions
  into maximally localized Wannier functions following the algorithm described
  in Computer
  Physics Communications 155 , p. 1 (2003), using a one-sided iterative Jacobi
  algorithm for simultaneous diagonalization.
  The position of Wannier centers and
  the corresponding spreads are printed on output. The value of the electronic,
  ionic and total dipole are printed. The iterative method stops when the
  decrease of the spread is sufficiently small between two iterations, or when a
  maximum number of iterations is reached. In the latter case,
  the **compute_mlwf**
  command can be issued again to try to improve the convergence of the spread
  minimization. After execution of the compute_mlwf command, the wave functions
  are maximally localized (i.e. have minimum spread).

.. _constraint_cmd:

constraint
----------

 NAME

  **constraint** -- manage constraints on atomic positions

 SYNOPSIS

  | **constraint define position** *constraint_name atom1*
  | **constraint define plane** *constraint_name atom1 px py pz dist [velocity]*
  | **constraint define distance**
    *constraint_name atom1 atom2 dist [velocity]*
  | **constraint define angle** *constraint_name atom1 atom2 atom3 angle
    [velocity]*
  | **constraint define torsion** *constraint_name atom1 atom2 atom3 atom4
    angle [velocity]*
  | **constraint list**
  | **constraint delete** *constraint_name*
  | **constraint enforce**
  | **constraint set** *constraint_name value [velocity]*

 DESCRIPTION

  The **constraint** command is used to manage the constraint set.
  Constraints can be of the following types: **position**, **plane**,
  **distance**, **angle** or **torsion**.
  Constraints are added to the constraint set using the **constraint
  define** command. They can be removed from the set using the
  **constraint delete** command.
  The list of currently defined constraints can be printed using the
  **constraint list** command.
  Some constraints have an associated value that can be modified using
  the **constraint set** command. The atom names used in the constraint command
  must refer to atoms previously defined using the :ref:`atom_cmd` command.
  All constraints
  have a name, which allows for selective removal of constraints and for
  individual modification of the constraint value.

  **constraint define position** *constraint_name atom1*

   Define a position constraint on atom *atom1*. This locks
   the atom *atom1* into its current position.

  **constraint define plane** *constraint_name atom1 px py pz dist [velocity]*

   Define a plane constraint on atom *atom1*. This confines 
   the atom *atom1* in a plane defined by the equation
   :math:`x e_x + y e_y + z e_z = d` where *d* is the *dist* parameter
   and :math:`(e_x, e_y, e_z)` is a unit vector in the direction of the 
   vector :math:`(p_x, p_y, p_z)`. The optional *velocity* argument sets
   the rate of change of the distance in (bohr/(a.u. time)).

  **constraint define distance** *constraint_name atom1 atom2 dist [velocity]*

   Define a distance constraint between atoms *atom1* and *atom2*.
   If the optional  *velocity* argument is given, the value of the distance
   will change at each time step of the simulation at a rate specified by the
   *velocity* argument. The argument *distance* must be given in (bohr).
   The *velocity* must be given in (bohr/(a.u. time)).

  **constraint define angle** *constraint_name atom1 atom2 atom3 angle [velocity]*

   Define an angle constraint on atoms *atom1*, *atom2* and *atom3*.
   If the optional *velocity* argument is given,
   the value of the angle will change at each time step of the simulation at
   a rate specified by the velocity argument.
   The argument *angle* must be given in (degree).
   The *velocity* must be given in (degree/(a.u. time)).

  **constraint define torsion** *constraint_name atom1 atom2 atom3 atom4 angle [velocity]*

   Define a torsion (or dihedral) constraint on atoms
   *atom1*, *atom2*, *atom3* and *atom4*.  If the optional *velocity* argument
   is given, the value of the angle will change at each time step of the
   simulation at a rate specified by the  velocity argument.
   The argument *angle* must be given in (degree).
   The *velocity* must be given in (degree/(a.u. time)).

  **constraint list**

   Print a list of all currently defined constraints.

  **constraint delete** *constraint_name*

   Remove the constraint named *constraint_name* from the
   constraint set.

  **constraint enforce**

   Modify atomic positions so as to enforce all constraints using the SHAKE
   algorithm.

  **constraint set** *constraint_name value [velocity]*

   Modify the value of a constraint and, optionally, its velocity.
   This command only applies to the **plane**, **distance**, **angle** and
   **torsion** constraints.

 .. note::
   Defining constraints does not move atoms. Atomic positions are only modified
   when running ionic steps (i.e. with atoms_dyn not equal to LOCKED), or
   if the **constraint enforce** command is used explicitly.

 .. note::
   If multiple constraints are defined, it may not be possible to enforce
   all constraints simultaneously.

 .. note::
   The set of constraints is not saved in a restart file.

 RELATED INFORMATION

  :ref:`list_atoms_cmd`, :ref:`angle_cmd`, :ref:`distance_cmd`,
  :ref:`torsion_cmd`

.. _distance_cmd:

distance
--------

 NAME

  **distance** - print the distance between two atoms

 SYNOPSIS

  **distance [-pbc]** *atom1 atom2*

 DESCRIPTION

  The **distance** command prints the value of the distance separating
  two atoms. If the **-pbc** option is used, the positions of the atoms are
  interpreted as those of the nearest atom replica, taking into account
  periodic boundary conditions.

 RELATED INFORMATION

  :ref:`angle_cmd`, :ref:`torsion_cmd`

.. _extforce_cmd:

extforce
--------

 NAME

  **extforce** - manage external forces on atoms

 SYNOPSIS

  | **extforce define atomic** *extforce_name atom1 fx fy fz*
  | **extforce define pair** *extforce_name atom1 atom2 f*
  | **extforce define global** *extforce_name fx fy fz*
  | **extforce set** *extforce_name fx fy fz*
  | **extforce set** *extforce_name f*
  | **extforce list**
  | **extforce delete** *extforce_name*

 DESCRIPTION

  The **extforce** command is used to define, modify or delete external
  forces acting on specific atoms. The **define**, **set**, **list** and
  **delete** subcommands modiy the set of external forces as detailed below
  for each choice of parameters.

  **extforce define atomic** *extforce_name atom1 fx fy fz*

   This command defines an external force named *extforce_name* acting on atom
   *atom1*. The force has components *fx, fy, fz*.
   The force components must be given in atomic units (hartree/bohr).
   [ 1 (hartree/bohr) = 82.3886 nN ]

  **extforce define pair** *extforce_name atom1 atom2 f*

   This command defines a pair force named *extforce_name* acting only on
   the atoms *atom1* and *atom2*.
   The magnitude of the pair force is *f* and must be given in
   atomic units (hartree/bohr). A positive value of *f* defines a repulsive
   force between *atom1* and *atom2*.

  **extforce define global** *extforce_name  fx fy fz*

   This command defines a global external force named *extforce_name* acting on
   all atoms. The force has components *fx,fy,fz*. The force components must be
   given in atomic units (hartree/bohr).

  **extforce set** *extforce_name fx fy fz*

   This command modifies the components of the force associated with the
   external force *extforce_name*. This syntax applies to the “atomic” and
   “global” forces only.

  **extforce set** *extforce_name  f*

   This command modifies the magnitude of the force associated with the
   external force *extforce_name*. This syntax applies to the “pair” force only.

  **extforce list**

   This command prints the list of currently defined external forces.

  **extforce delete** *extforce_name*

   This command removes the external force *extforce_name* from the set
   of external forces.

 .. note::
  The set of external forces is not saved in a restart file.

 .. note::
  1 (hartree/bohr) = 82.3886 nN

.. _fold_in_ws_cmd:

fold_in_ws
----------

 NAME

  **fold_in_ws** – fold all atoms within the Wigner-Seitz cell

 SYNOPSIS

  **fold_in_ws**

 DESCRIPTION

  The **fold_in_ws** command moves atoms by multiples of the unit cell lattice
  vectors so that all atoms are located within the Wigner-Seitz cell.

.. _help_cmd:

help
----

 NAME

  **help** - print a brief help message about a command

 SYNOPSIS

  **help** *[command]*

 DESCRIPTION

  The help command prints a short description of the command given as an
  argument. When used without arguments, prints a list of valid commands.

.. _kpoint_cmd:

kpoint
------

 NAME

  **kpoint** – manage the set of k-points used in the electronic
  structure calculation

 SYNOPSIS

  | **kpoint add** *kx ky kz weight*
  | **kpoint move** *kx ky kz kx' ky' kz'*
  | **kpoint delete** *kx ky kz*
  | **kpoint list**

 DESCRIPTION

  The **kpoint** command is used to manage the set of k-points
  used in the electronic structure calculation.
  k-points can be added, moved and deleted.

  **kpoint add** *kx ky kz weight*

   This command adds a k-point to the k-point set. The *weight* of the
   k-point must be in [0,1] and is used to weigh the contribution of the
   k-point to the charge density.

  **kpoint move** *kx ky kz kx' ky' kz'*

   This command moves a k-point located at *kx ky kz* to
   *kx' ky' kz'* while preserving
   wave functions amplitudes. This command can be used to
   explore details of the band structure using small displacements in k-space.

  **kpoint list**

   This command lists all currently defined k-points.

  **kpoint delete** *kx ky kz*

   This command deletes the k-point located at *kx ky kz*.

 A k-point is defined by its coefficients *kx ky kz*
 on the basis of the reciprocal lattice vectors. If reciprocal lattice vectors
 are :math:`\vec{b_1},\, \vec{b_2},\, \vec{b_3}`, the k-point defined by the
 numbers *kx, ky, kz* is
 :math:`\vec{k} = kx\, \vec{b_1} + ky\, \vec{b_2} + kz\, \vec{b_3}`.
 For example, the X point of the Brillouin
 Zone for an FCC lattice is specified as kx=0.5, ky=0.5, kz=0.0.
 The sum of the weights of all k-points must add up to 1.0.
 This is currently not checked by Qbox.

 A k-point can be defined with zero weight, in which case the
 wave functions and eigenvalues are computed at that k-point, but they are not
 included in the calculation of the charge density.

 .. |Gamma_pt| replace:: :math:`\Gamma`

 By default, Qbox starts with a k-point set containing a single k-point:
 :math:`\vec k =(0,0,0)` (the |Gamma_pt| point) with a weight of 1.0.
 When defining a k-point set, it is necessary to first delete the |Gamma_pt|
 point before defining other k-points. This is due to two possible reasons:

  1) The desired k-point set does not contain the |Gamma_pt| point.
  2) The desired k-point set contains the |Gamma_pt| point, but with a
     weight different from 1.0. In this case, the |Gamma_pt| point must be
     first deleted and then added again with the appropriate weight.
     The only way to change the weight of a k-point is to delete it and define
     it again.

 Qbox does not perform any symmetrization of the charge density to reduce the
 number of k-points to the irreducible wedge of the Brillouin Zone. The full set
 of k-points must be defined (except for the k, -k symmetry, i.e. If k is
 included in the set, then -k need not be included).

 Adding or removing k-points erases all wave functions. It is not possible to
 modify the k-point set after running a calculation or after loading a sample
 without resetting the wave functions.

 When deleting a kpoint, the arguments *kx, ky, kz* are compared to the
 coordinates of the k-points currently defined. Since comparisons of floating
 point numbers are unreliable, the **kpoint delete** command will delete any
 k-point
 located within a radius of 10\ :sup:`-6` of the vector *(kx, ky, kz)*.
 Similarly, when adding a new k-point, the **kpoint add** command will
 exit without defining the new k-point and print a warning message if
 a previously defined k-point is located
 within a radius of 10\ :sup:`-6` of the new k-point.

 EXAMPLE

  Define a set of 8 k-points for a simple cubic or orthorhombic cell.
  This k-point set is equivalent to doubling the cell in all three directions::

   kpoint delete 0 0 0
   # Gamma point
   kpoint add  0.0  0.0  0.0   0.125
   # X point
   kpoint add  0.5  0.0  0.0   0.125
   kpoint add  0.0  0.5  0.0   0.125
   kpoint add  0.0  0.0  0.5   0.125
   # R point
   kpoint add  0.5  0.5  0.5   0.125
   # M point
   kpoint add  0.5  0.5  0.0   0.125
   kpoint add  0.5  0.0  0.5   0.125
   kpoint add  0.0  0.5  0.5   0.125

 EXAMPLE

  Define the X and L points in the Brillouin Zone of an FCC lattice,
  with zero weight::

   # a1 = (a/2, a/2, 0)
   # a2 = (0, a/2, a/2)
   # a3 = (a/2, 0, a/2)
   # b1 = (2*pi/a) ( 1.0,  1.0, -1.0)
   # b2 = (2*pi/a) (-1.0,  1.0,  1.0)
   # b3 = (2*pi/a) ( 1.0, -1.0,  1.0)
   # X point
   # X = (2*pi/a) ( 1.0, 0.0, 0.0 ) = 0.5 * ( b1 + b3 )
   kpoint 0.5 0.0 0.5   0.0000
   # L point
   # L = (2*pi/a) ( 0.5, 0.5, 0.5 ) = 0.5 * ( b1 + b2 + b3 )
   kpoint add 0.5 0.5 0.5   0.0000

.. _list_atoms_cmd:

list_atoms
----------

 NAME

  **list_atoms** - print a list of all atoms defined in the sample

 SYNOPSIS

  **list_atoms**

 DESCRIPTION

  The **list_atoms** command prints a list of all atoms currently defined.

 RELATED INFORMATION

  :ref:`list_species_cmd`, :ref:`atom_cmd`

.. _list_species_cmd:

list_species
------------

 NAME

  **list_species** - print a list of all species currently defined

 SYNOPSIS

  **list_species**

 DESCRIPTION

  The **list_species** command prints a list of all species currently defined.
  For each species, the parameters of the corresponding pseudopotential
  are printed.

 RELATED INFORMATION

  :ref:`list_atoms_cmd`, :ref:`species_cmd`

.. _load_cmd:

load
----

 NAME

  **load** - load a sample from a restart file

 SYNOPSIS

  **load** *URI*

 DESCRIPTION

  The **load** command loads a simulation sample defined in an XML document
  previously generated using the :ref:`save_cmd` command.

  The *URI* argument can be a local file, in which case
  Qbox will open and read the file. If *URI* is a URL  (e.g.
  http://www.quantum-simulation.org/examples/samples/ch4.xml) Qbox will download
  the document from the corresponding web site. Note that loading a URL remotely
  only works if the nodes on which Qbox is running have web access. This may not
  be the case on some parallel computers in which compute nodes do not have web
  access.  Qbox sample documents must conform to the XML Schema definition
  provided at http://www.quantum-simulation.org

 RELATED INFORMATION

  :ref:`save_cmd`

.. _move_cmd:

move
----

 NAME

  **move** - change the position of an atom and optionally its velocity

 SYNOPSIS

  | **move** *atom_name* **to** *x y z [vx vy vz]*
  | **move** *atom_name* **by** *dx dy dz*

 DESCRIPTION

  The **move** command moves an atom to a new position and optionally sets
  its velocity. The new position is defined by absolute coordinates 
  *x, y, z* or by a relative displacement *dx, dy, dz*. 
  When using 'to', if one or more of the arguments is '*', the
  corresponding component of the position is unchanged.
  Positions or displacements must be given in atomic units (bohr).

.. _plot_cmd:

plot
----

 NAME

  **plot** – generate a plot file with atoms and/or charge density, orbitals
  or local potential

 SYNOPSIS

  | **plot** *filename*
  | **plot -density** *filename*
  | **plot -wf** *n filename*
  | **plot -wfs** *nmin nmax* **[-spin {1|2}]** *filename*
  | **plot -vlocal** *filename*

 DESCRIPTION

  The **plot** command creates a plot file to be viewed with another
  rendering program such as VMD (http://www.ks.uiuc.edu/Research/vmd/) or
  XCrySDen (http://www.xcrysden.org/). The type of output file generated
  depends on the arguments given to the plot command.

  **plot** *filename*

   This command generates an xyz file containing atomic positions only.

  **plot -density [-spin {1|2}]** *filename*

   This command generates a file in "cube" format containing the atomic
   positions and the total charge density. If the **-spin** option is used,
   the density of the first (1) or second (2) spin is used.
   The "cube" file can be visualized using the VMD program.

  **plot -wf** *n* **[-spin {1|2}]** *filename*

   This command generates a file in "cube" format containing the n-th wave
   function. If the **-spin** option is used, the wave function of the first (1)
   or second (2) spin is used.

  **plot -wfs** *nmin nmax* **[-spin {1|2}]** *filename*

   This command generates a file in "cube" format containing the sum of the
   squares of the amplitudes of the wave functions *nmin* to *nmax* inclusive.
   If the **-spin** option is used, the wave functions of the first (1) or
   second (2) spin are used.

  **plot -vlocal** *filename*

   This command generates a file in "cube" format containing the
   potential :math:`V_{\rm local}+V_{\rm Hartree}`.

 .. note::

  The **-wf** and **-wfs** options currently only work for wave
  functions at the |Gamma_pt| point.

.. _partial_charge_cmd:

partial_charge
--------------

 NAME

  **partial_charge** – compute the amount of electronic charge
  in a sphere centered on an atom

 SYNOPSIS

  **partial_charge [-spin {1|2}]** *atom_name r*

 DESCRIPTION

  The **partial_charge** command computes the amount of electronic charge
  contained in a sphere of radius *r* centered on atom *atom_name*.
  The radius *r* must be specified in atomic units (bohr).
  When using the **-spin** option, the charge density of the given spin
  is computed. If nspin=2 and the **-spin** option is not used,
  the total charge is computed.

.. _print_cmd:

print
-----

 NAME

  **print** - print the current value of a Qbox variable

 SYNOPSIS

  **print** *variable*

 DESCRIPTION

  The **print** command prints the current value a Qbox variable.
  For a list of variables, see the Qbox commands page.

 RELATED INFORMATION

  :ref:`set_cmd`

.. _quit_cmd:

quit
----

 NAME

  **quit** - exit Qbox

 SYNOPSIS

  **quit**

 DESCRIPTION

  The **quit** command exits Qbox without saving any information about the
  sample. To save the current sample to a restart file, see the
  :ref:`save_cmd` command.

 RELATED INFORMATION

  :ref:`save_cmd`

.. _randomize_r_cmd:

randomize_r
-----------

 NAME

  **randomize_r** - add a random perturbation to atomic positions

 SYNOPSIS

  **randomize_r** *amplitude*

 DESCRIPTION

  The **randomize_r** command adds random numbers to the coordinates of all
  atomic positions. The random displacements are drawn from a normal
  distribution scaled by the *amplitude* argument.

 RELATED INFORMATION

  :ref:`randomize_v_cmd`

.. _randomize_v_cmd:

randomize_v
-----------

 NAME

  **randomize_v** – initialize atomic velocities with random values
  from a Maxwell-Boltzmann distribution

 SYNOPSIS

  **randomize_v** *temperature*

 DESCRIPTION

  The **randomize_v** command initializes atomic velocities with random
  numbers drawn from a Maxwell-Boltzmann distribution. The *temperature*
  argument determines the temperature of the distribution.

 RELATED INFORMATION

  :ref:`randomize_r_cmd`

.. _randomize_wf_cmd:

randomize_wf
------------

 NAME

  **randomize_wf** - add a random perturbation to electronic wave functions

 SYNOPSIS

  **randomize_wf** *[amplitude]*

 DESCRIPTION

  The **randomize_wf** command adds random numbers to the Fourier coefficients
  of the electronic wave function. The amplitude argument can be used to
  change the intensity of the perturbation.
  The **randomize_wf** command is used at the
  beginning of an electronic structure calculation when the symmetry of the
  atomic coordinates is high. In such situations, the iterative algorithms used
  to compute the electronic ground state may converge to saddle points of the
  energy functional instead of true minima. Using **randomize_wf** introduces a
  slight symmetry breaking which is sufficient to avoid high-symmetry saddle
  points.

.. _rescale_v_cmd:

rescale_v
---------

 NAME

  **rescale_v** – rescale atomic velocities

 SYNOPSIS

  **rescale_v** *f*

 DESCRIPTION

  The **rescale_v** command rescales the velocity of all atoms by a
  factor *f*.

.. _reset_rotation_cmd:

reset_rotation
--------------

 NAME

  **reset_rotation** - reset atomic velocities so as to cancel global rotations.

 SYNOPSIS

  **reset_rotation**

 DESCRIPTION

  The **reset_rotation** command modifies the velocity of all atoms so as
  to ensure that the total angular momentum of the system is zero.
  This command is used periodically during molecular dynamics simulations of
  isolated molecules to prevent a global rotation.

.. _reset_vcm_cmd:

reset_vcm
---------

 NAME

  **reset_vcm** - reset the velocity of the center of mass to zero

 SYNOPSIS

  **reset_vcm**

 DESCRIPTION

  The **reset_vcm** command modifies the velocity of all atoms so as to
  ensure that the velocity of the center of mass is zero. The current value of
  the velocity of the center of mass is printed by the status command.

.. _response_cmd:

response
--------

 NAME

  **response** - compute the polarizability or the response to an external
  potential

 SYNOPSIS

  | **response** *amplitude* **[-RPA|-IPA]** *nitscf* *[nite]*
  | **response -vext** *filename* **[-cube]** **[-RPA|-IPA]** **[-amplitude** *a* **]** *nitscf* *[nite]*

 DESCRIPTION

  The **response** command computes the polarizability of the system, or
  the density response to a specific external potential.
  The **response** command uses a series of self-consistent calculations
  in finite electric field (or finite potential). The *nitscf* and *nite*
  values are used to control the number of iterations performed in each
  of the finite field calculations. Finite-field calculations are performed
  in three possible ways depending on the use of the options **-RPA** and
  **-IPA**. By default, the Hartree and exchange-correlation potentials
  are updated self-consistently during the finite-field calculations. If
  the **-RPA** option is used, only the Hartree potential is updated
  (Random Phase Approximation). If the **-IPA** option is used, neither the
  Hartree potential nor the exchange-correlation potential are updated
  (Independent Particle Approximation).

  **response** *amplitude* *nitscf* *[nite]*

   This command computes the response of the system to a constant
   electric field in the x, y, and z directions. The resulting polarizability
   tensor is printed. The unit of polarizability is (bohr) :math:`^3`

  **response -vext** *filename* **[-cube]** **[-RPA|-IPA]** **[-amplitude**
  *a* **]** *nitscf* *[nite]*

   This command computes the density response to an external potential
   defined in the file *filename*. The default format of the external
   potential file is XML, as described for the :ref:`vext_var` variable.
   If the **-cube** option is used, the format of the external potential
   file is the cube format.
   If the **-amplitude** option is used, the external potential is multiplied
   by the given value, and the density response is then divided by the same
   value. The density response if written to a file having the
   same format as the external potential file (XML or cube). The density
   response file name is formed by appending ".response" to the name of the
   external potential file.

 .. note::
   The :ref:`polarization_var` variable must be set before using the
   **response** command.

 .. note::
   The **response** command can only be used for wave functions
   defined at the :math:`\Gamma` point of the Brillouin zone, for systems
   having no spin polarization.

 RELATED INFORMATION

  :ref:`polarization_var`

.. _rseed_cmd:

rseed
-----

 NAME

  **rseed** – initialize the random number generator

 SYNOPSIS

  **rseed** *[seed]*

 DESCRIPTION

  The **rseed** command initializes the random number generator. Qbox uses
  random numbers in the implementation of the **randomize_wf** command and in
  stochastic thermostats (LOWE, ANDERSON, BDP). If an integer  *seed* argument
  is provided, it is used
  to initialize the random number generator. If no seed is provided the Unix
  ``time()``
  function is used to generate a seed. Note: when running multiple instances of
  Qbox in client-server mode, and if the rseed command is not used, all
  instances
  may be initialized with the same seed if they are started at the same time.
  This problem can be avoided by using the **rseed** command for each
  instance with a
  different argument, or by starting all instances in a staggered way using a
  delay of a few seconds.

.. _run_cmd:

run
---

 NAME

  **run** - update electronic wave functions and/or atomic positions
  and/or unit cell

 SYNOPSIS

  | **run [-atomic_density]** *niter*
  | **run [-atomic_density]** *niter nitscf*
  | **run [-atomic_density]** *niter nitscf nite*

 DESCRIPTION

  The **run** command starts a simulation in which atomic positions,
  electronic wave functions, and/or unit cell are updated.
  The algorithms used to update the atomic positions,
  electronic states and/or unit cell are determined by the variables
  :ref:`atoms_dyn_var`, :ref:`wf_dyn_var` and :ref:`cell_dyn_var`.

  If the **-atomic_density** option is used, the first self-consistent
  iteration is started using a charge density made of a superposition
  of atomic charge densities.

  The parameters are defined as follows

  *niter*

   The number of ionic steps to be performed, i.e. steps during
   which atomic positions are updated. This number can be zero
   if only electronic wave function updates are desired.

  *nitscf*

   The maximum number of self-consistent iterations.
   The charge density is updated at the beginning of each
   self-consistent iteration. Iterations are skipped if the
   energy has reached convergence within the
   :ref:`scf_tol_var` tolerance criterion.

  *nite*

   The number of electronic iterations performed between updates of
   the charge density. These iterations are needed in metallic systems,
   in systems exhibiting a small HOMO-LUMO gap, or if empty states are
   included in the calculation (see :ref:`nempty_var`).

 TYPICAL USES

  **run** *0 nitscf*

   Perform *nitscf* self-consistent iterations without moving ions. This is the
   most common way to compute the electronic ground state in insulators.

  **run** *0 nitscf nite*

   Perform *nitscf* self-consistent iterations with *nite* updates of the
   wave functions between charge density updates, without
   moving ions. This is the
   most common way to compute the electronic ground state in metals and
   small band gap semiconductors.

  **run** *niter* *nitscf*

   Perform *niter* ionic steps with *nitscf*
   updates of the charge density between ionic steps. This is the most common
   way to perform geometry optimization or first-principles molecular dynamics
   (FPMD) in insulators.

  **run** *niter* *nitscf* *nite*

   Perform *niter* ionic steps, with *nitscf* updates of the charge
   density between ionic steps, and *nite* updates of the
   wave functions between charge density updates. This is the most common
   way to perform geometry optimization or FPMD in metals.

 EXAMPLE

  Electronic ground state calculation::

   set wf_dyn JD
   run 0 100

  Perform 100 scf
  iterations with atoms locked, using the Jacobi-Davidson algorithm to
  update wave functions.

 EXAMPLE

  Geometry optimization in insulators::

   set wf_dyn JD
   set atoms_dyn CG
   run 50 10

  Perform 50 steps of geometry optimization using the conjugate gradient
  algorithm to update atomic positions. Use 10 scf iterations before each
  ionic step.  Wave functions are updated using the Jacobi-Davidson algorithm.

 EXAMPLE

  Molecular dynamics in insulators::

   set wf_dyn JD
   set atoms_dyn MD
   run 50 10

  Perform 50 steps molecular dynamics (MD) using the Verlet
  algorithm to update atomic positions. Use 10 scf iterations before each
  ionic step. Wave functions are updated using the Jacobi-Davidson algorithm.

 EXAMPLE

  Geometry optimization in metals::

   set wf_dyn JD
   set atoms_dyn CG
   run 50 10 10

  Perform 50 steps of geometry optmization.
  The charge density is updated 5 times
  before each ionic step. The wave functions are updated 10 times before each
  charge density update.

 EXAMPLE

  Optimization of geometry and cell parameters::

   set wf_dyn JD
   set stress ON
   set cell_dyn CG
   run 50 10 10

  Perform 50 steps of joint optimization of atomic positions and
  cell parameters.
  Note: see also the :ref:`ecuts_var` and :ref:`ref_cell_var` variables
  for more details on cell parameter optimization.

 RELATED INFORMATION

  :ref:`atoms_dyn_var`, :ref:`wf_dyn_var`, :ref:`scf_tol_var`

.. _save_cmd:

save
----

 NAME

  **save** - save the current sample into a restart file for later use

 SYNOPSIS

  **save [-serial] [-text] [-atomsonly] [-no_wfv]** *filename*

 DESCRIPTION

  The **save** command saves the current sample into a file in XML format.
  The format
  used conforms to the XML Schema defined at http://www.quantum-simulation.org.
  The information saved includes the dimensions of the unit cell, atomic
  positions and velocities, the electronic wave functions, and optionally
  the time
  derivative of the wave functions. If the **-serial** option is used,
  the data is
  saved from task 0 only and no attempt is made to use optimized parallel I/O
  functionality. If the **-text** option is used, the wave function
  values are
  written in formatted text form rather than encoded in base64 format in the
  sample file. If the **-atomsonly** option is used, only
  the <atomset> element is written and wave functions are not included.
  If the **-no_wfv** option is used, wave function velocities are not saved.

 RELATED INFORMATION

  :ref:`load_cmd`

.. _set_cmd:

set
---

 NAME

  **set** - assign a value to a Qbox variable

 SYNOPSIS

  **set** *variable value [value ...]*

 DESCRIPTION

  The **set** command assigns value(s) to a Qbox variable. Some
  variables (e.g. :ref:`cell_var`) are multivalued, in which case the
  set command requires multiple arguments.

 RELATED INFORMATION

  :ref:`print_cmd`

.. _set_velocity_cmd:

set_velocity
------------

 NAME

  **set_velocity** - set the velocity of an atom

 SYNOPSIS

  **set_velocity** *atom_name {vx|*|-} {vy|*|-} {vz|*|-}*

 DESCRIPTION

  The **set_velocity** command sets the velocity of atom *atom_name*
  to *(vx,vy,vz)*. If one or
  more of the arguments is '*', the corresponding component of the velocity is
  unchanged. If an argument is '-', the corresponding component of the velocity
  changes sign.

 EXAMPLE

  Set the component x of the velocity of atom C18 to 0.01, leave
  the component y unchanged and change the sign of the component z.

  ::

   set_velocity C18 0.01 * -

 RELATED INFORMATION

  :ref:`move_cmd`, :ref:`list_atoms_cmd`

.. _species_cmd:

species
-------

 NAME

  **species** - define a new atomic species and add it to the list of
  currently defined species

 SYNOPSIS

  **species** *species_name URI*

 DESCRIPTION

  The **species** command defines a new atomic species under the name
  *species_name*. The newly
  defined species is added to the list of currently known species.
  The definition
  is read from the given URI. If the URI is a local file, Qbox opens and reads
  it. If the URI is a URL (e.g.
  http://www.quantum-simulation.org/examples/species/hydrogen_pbe.xml) Qbox
  downloads the species definition from the corresponding web site. The species
  definition document must conform to the species XML Schema definition given at
  http://www.quantum-simulation.org. If the species name is already defined, the
  definition is replaced with that of the URI argument.

 RELATED INFORMATION

  :ref:`list_species_cmd`, :ref:`atom_cmd`

.. _spectrum_cmd:

spectrum
--------

 NAME

  **spectrum** - compute the optical absorption spectrum

 SYNOPSIS

  | **spectrum** *filename*
  | **spectrum** *width filename*
  | **spectrum** *emin emax width filename*

 DESCRIPTION

  The **spectrum** command computes the dipole transition strengths
  between occupied and empty orbitals. It computes Kohn-Sham eigenvalues
  and eigenfunctions of the current wave function using the the current
  value of the :ref:`xc_var` variable. The corresponding absorption
  spectrum is written on an output file after convolution with a
  gaussian function of width *width*.

  The parameters are defined as follows

   *emin*, *emax*

    energy range of plot (optional)

   *width*

    width of the gaussian used in the convolution (optional) (default 0.05 eV)

   *filename*

    output file name

  If *emin* and *emax* are not given, the energy range includes
  all possible transitions between occupied and empty orbitals.
  All energy parameters must be given in eV.

 RELATED INFORMATION

  :ref:`xc_var`

.. _status_cmd:

status
------

 NAME

  **status** - print status of the current sample

 SYNOPSIS

  **status**

 DESCRIPTION

  The **status** command prints a brief summary of the characteristics
  of the current sample.

.. _strain_cmd:

strain
------

 NAME

  **strain** – apply strain on the system

 SYNOPSIS

  **strain [-atomsonly] [-inverse]** *uxx uyy uzz uxy uyz uxz*

 DESCRIPTION

  The **strain** command modifies the shape of the unit cell and modifies the
  atomic positions to impose a strain defined by the components of the symmetric
  strain tensor *u*. Using the **-inverse** flag causes the inverse
  transformation to be applied. Using **-atomsonly** changes the postitions
  of atoms without affecting the unit cell.

 RELATED INFORMATION

  :ref:`ext_stress_var`

.. _torsion_cmd:

torsion
-------

 NAME

  **torsion** -print the value of the torsion angle (dihedral) defined by
  the positions of four atoms

 SYNOPSIS

  **torsion [-pbc]** *atom1 atom2 atom3 atom4*

 DESCRIPTION

  The **torsion** command prints the value of the angle (dihedral) defined
  by the
  four atoms given as arguments. The names *atom1, atom2, atom3, atom4* must
  refer to the names of atoms currently defined in the sample.
  If the **-pbc** option
  is used, the positions of the atoms are interpreted as those of the nearest
  atom replica, taking into account periodic boundary conditions.

 RELATED INFORMATION

  :ref:`list_atoms_cmd`, :ref:`angle_cmd`, :ref:`distance_cmd`

.. _shell_escape_cmd:

! (shell escape)
----------------

 NAME

  **! (shell escape)** - execute a Unix command from within Qbox

 SYNOPSIS

  **!** *[cmd]*

 DESCRIPTION

  The **!** command executes the *cmd* command in a Unix shell.
