.. _var_index:

===============
Qbox variables
===============

* :ref:`alpha_PBE0_var` - coefficient of Hartree-Fock exchange in PBE0 DFT
* :ref:`alpha_RSH_var` - parameter of the RSH hybrid density functional
* :ref:`atoms_dyn_var` - atom dynamics control variable
* :ref:`beta_RSH_var`  parameter of the RSH hybrid density functional
* :ref:`blHF_var` bisection levels in Hartree-Fock exchange
* :ref:`btHF_var` bisection threshold in Hartree-Fock exchange
* :ref:`cell_var` dimensions of the unit cell
* :ref:`cell_dyn_var` unit cell dynamics control variable
* :ref:`cell_lock_var` control of allowed unit cell motions
* :ref:`cell_mass_var` fictitious mass of the unit cell
* :ref:`charge_mix_coeff_var` mixing coefficient for charge density updates
* :ref:`charge_mix_ndim_var` Anderson dimension for charge density updates
* :ref:`charge_mix_rcut_var` Kerker screening length for charge density updates
* :ref:`debug_var` debug parameters (not for normal use)
* :ref:`delta_spin_var` number of spin excitations
* :ref:`dt_var` time step (a.u.)
* :ref:`ecut_var` plane wave energy cutoff (Ry)
* :ref:`ecutprec_var` energy cutoff of the preconditioner (Ry)
* :ref:`ecuts_var` energy cutoff of the confinement potential for variable cell
  calculations
* :ref:`e_field_var` total electric field
* :ref:`emass_var` fictitious electronic mass (for Car-Parrinello dynamics)
* :ref:`ext_stress_var` externally applied stress (GPa)
* :ref:`fermi_temp_var` Fermi temperature (K)
* :ref:`force_tol_var` tolerance criterion on forces (hartree/bohr)
* :ref:`iter_cmd_var` script or command executed every iter_cmd_period steps
* :ref:`iter_cmd_period_var` number of steps between iter_cmd executions
* :ref:`lock_cm_var` center of mass lock control variable
* :ref:`mu_RSH_var` parameter of the RSH hybrid density functional
* :ref:`nempty_var` number of empty states
* :ref:`net_charge_var` net charge of the system
* :ref:`nrowmax_var` (deprecated) maximum size of process grid columns
* :ref:`nspin_var` number of spin degrees of freedom
* :ref:`occ_var` electronic occupation numbers
* :ref:`polarization_var` algorithm used to compute dipole and quadrupole
  moments
* :ref:`ref_cell_var` dimensions of the reference unit cell for variable cell
  calculations
* :ref:`scf_tol_var` tolerance criterion for convergence of SCF iterations
* :ref:`stress_var` stress control variable
* :ref:`stress_tol_var` tolerance criterion on stress (GPa)
* :ref:`thermostat_var` thermostat control variable
* :ref:`th_temp_var` thermostat temperature (K)
* :ref:`th_time_var` thermostat time constant (a.u.)
* :ref:`th_width_var` thermostat width (K)
* :ref:`vext_var` external potential file name
* :ref:`wf_diag_var` wave function diagonalization control variable
* :ref:`wf_dyn_var` wave function dynamics control variable
* :ref:`xc_var` exchange-correlation functional control variable

.. _alpha_PBE0_var:

alpha_PBE0
----------

 NAME

  **alpha_PBE0** -- coefficient of Hartree-Fock exchange in PBE0 DFT

 DESCRIPTION

  The **alpha_PBE0** variable defines the coefficient multiplying
  the Hartree-Fock exchange energy in the PBE0 exchange-correlation functional.
  The default value is 0.25.

 ALLOWED VALUES

  non-negative real numbers

 RELATED INFORMATION

  :ref:`xc_var`

.. _alpha_RSH_var:

alpha_RSH
---------

 NAME

  **alpha_RSH** – parameter of the range-separated hybrid functional

 DESCRIPTION

  See the definition of the RSH functional in the description of the
  :ref:`xc_var` variable.

 ALLOWED VALUES

  non-negative real numbers

 RELATED INFORMATION

  :ref:`xc_var`

.. _atoms_dyn_var:

atoms_dyn
---------

 NAME

  **atoms_dyn** -- atom dynamics control variable

 DESCRIPTION

  The **atoms_dyn** variable determines the algorithm used to update
  atomic positions during a simulation. The following values are allowed:

  * LOCKED: Ionic forces are not computed and atomic positions are not updated.
    This is the default.
  * SD: Steepest Descent. Ionic forces are computed and atomic positions are
    updated using the steepest descent algorithm

    .. math::

       R(t+dt) = R(t) + \frac{dt^2}{m} F(t)

    where :math:`F` is the force, :math:`m` is the ionic mass and
    :math:`dt` is the time step (see variable :ref:`dt_var` ).

  * SDA: Steepest Descent with Acceleration. A line minimization algorithm is
    used to find a minimum satisfying the Wolfe conditions before changing the
    descent direction. Using this algorithm requires a full calculation of the
    electronic ground state at each ionic step, i.e. nitscf > 1 in the run
    command.

  * CG: Conjugate Gradient. A line minimization algorithm is used to find a
    minimum satisfying the Wolfe conditions before changing the descent
    direction. The Polak-Ribiere formula is used to update descent directions.
    Using this algorithm requires a full calculation of the electronic ground
    state at each ionic step, i.e. using nitscf > 1 in the :ref:`run_cmd`
    command.

  * MD: Molecular dynamics. Ionic forces are computed and ionic positions are
    updated using the Verlet algorithm

    .. math::

       R(t+dt) = 2 R(t) -R(t-dt) + \frac{dt^2}{m} F(t)

    This algorithm can be used to perform
    Born-Oppenheimer molecular dynamics (using nitscf > 1 in the
    :ref:`run_cmd` command) or Car-Parrinello molecular dynamics
    (nitscf not used).  See also the :ref:`wf_dyn_var` variable.

  * BMD: Blocked Molecular dynamics. This algorithm updates ionic positions
    according to the MD algorithm (Verlet), but velocities are reset to zero
    whenever the total energy increases. This algorithm can be used for
    geometry optimization.
    It requires a full calculation of the electronic ground state at
    each ionic step, i.e. using nitscf > 1 in the :ref:`run_cmd` command.

  * AND: Anderson acceleration. This algorithm updates positions using
    forces computed in previous steps according to D.G. Anderson's method.

 ALLOWED VALUES

  LOCKED, SD, SDA, CG, MD, BMD, AND

 RELATED INFORMATION

  :ref:`dt_var`

.. _beta_RSH_var:

beta_RSH
--------

 NAME

  **beta_RSH** – parameter of the range-separated hybrid functional

 DESCRIPTION

  See the definition of the RSH functional in the description of the
  :ref:`xc_var` variable.

 ALLOWED VALUES

  non-negative real numbers

 RELATED INFORMATION

  :ref:`xc_var`

.. _blHF_var:

blHF
----

 NAME

  **blHF** – bisection levels for Hartree-Fock exchange computation

 DESCRIPTION

  The **blHF** variable consists of three integer values *lx ly lz* that
  specify the number of recursive levels of bisection that must be perfomed on
  wave functions in the x, y, and z directions when computing the Hartree-Fock
  exchange energy. The values of blHF are only used if the variable
  :ref:`btHF_var` is non-zero.

 ALLOWED VALUES

  positive integers

 RELATED INFORMATION

  :ref:`btHF_var`, :ref:`bisection_cmd`

.. _btHF_var:

btHF
----

 NAME

  **btHF** – bisection threshold for Hartree-Fock exchange computation

 DESCRIPTION

  The **btHF** variable defines the threshold used in the recursive bisection
  perfomed on wave functions when computing the Hartree-Fock exchange energy. If
  btHF is zero, no bisection is performed during Hartree-Fock exchange
  calculations. The default value of btHF is zero.

 ALLOWED VALUES

  floating point numbers in [0,1]

 RELATED INFORMATION

  :ref:`blHF_var`, :ref:`bisection_cmd`

.. _cell_var:

cell
----

 NAME

  **cell** - unit cell parameters

 DESCRIPTION

  The **cell** variable contains the coordinates of the three lattice vectors
  defining the unit cell. The unit cell is defined using the **set** command
  with the following arguments

   **set cell** *a1x a1y a1z a2x a2y a2z a3x a3y a3z*

  The lattice vectors are

   .. math::
    \vec{a}_1 = ( a_{1x}, a_{1y}, a_{1z} )^T

    \vec{a}_2 = ( a_{2x}, a_{2y}, a_{2z} )^T

    \vec{a}_3 = ( a_{3x}, a_{3y}, a_{3z} )^T

  and form the columns of the 3x3 lattice parameter matrix
  :math:`A`

  .. math::
    A = [ \vec{a}_1, \vec{a}_2, \vec{a}_3 ]

  The default value of all cell parameters is zero.

 ALLOWED VALUES

  positive real numbers

 RELATED INFORMATION

  :ref:`ref_cell_var`

.. _cell_dyn_var:

cell_dyn
--------

 NAME

  **cell_dyn** - cell dynamics control variable

 DESCRIPTION

  The **cell_dyn** variable determines the algorithm used to update the
  unit cell during a simulation. The following values are allowed:

  * LOCKED: The unit cell is not updated. This is the default.

  * SD: Steepest Descent. The unit cell is updated using the computed
    tress tensor and the steepest descent algorithm

    .. math::
     a_{ij}(t+dt)=a_{ij}(t) + \frac{dt^2}{m_\Omega}
     \left( \sigma(t)-\sigma^{\rm ext}(t) \right) A(t)

    where :math:`\sigma` is the stress tensor, :math:`\sigma^{\rm ext}`
    is the externally applied stress (variable :ref:`ext_stress_var`),
    :math:`\Omega` is the volume of the unit cell, :math:`m_\Omega` is the
    mass of the unit cell (variable :ref:`cell_mass_var`), :math:`A` is
    the 3x3 lattice parameter matrix (see :ref:`cell_var` variable) and
    :math:`dt` is the time step (variable :ref:`dt_var`).

  * CG: Conjugate Gradient. The unit cell and the atomic positions are updated
    using the computed stress tensor and the atomic forces using a conjugate
    gradient algorithm. Note that both the unit cell and atomic positions are
    optmized simultaneously independently of the value of atoms_dyn.

 ALLOWED VALUES

  LOCKED, SD, CG

 RELATED INFORMATION

  :ref:`cell_var`, :ref:`ref_cell_var`, :ref:`cell_lock_var`

.. _cell_lock_var:

cell_lock
---------

 NAME

  **cell_lock** - cell dynamics constraints control variable

 DESCRIPTION

  The **cell_lock** variable is used to restrict the possible changes of the
  unit cell parameters. The allowed values are

  * OFF:	No restrictions on the unit cell parameters are enforced.
    This is the default.
  * A: 	The lattice vector :math:`\vec{a}_1` is fixed.
  * B: 	The lattice vector :math:`\vec{a}_2` is fixed.
  * C: 	The lattice vector :math:`\vec{a}_3` is fixed.
  * AB: The lattice vectors :math:`\vec{a}_1` and :math:`\vec{a}_2` are fixed.
  * AC:	The lattice vectors :math:`\vec{a}_1` and :math:`\vec{a}_3` are fixed.
  * BC:	The lattice vectors :math:`\vec{a}_2` and :math:`\vec{a}_3` are fixed.
  * ABC: All lattice vectors are fixed.
    This is equivalent to **cell_dyn** = LOCKED.
  * S:	The shape of the unit cell is preserved. Lattice vectors can change
    length but not direction.
  * AS:	The lattice vector :math:`\vec{a}_1` is fixed and the shape of the
    unit cell is preserved.
  * BS:	The lattice vector :math:`\vec{a}_2` is fixed and the shape of the
    unit cell is preserved.
  * CS:	The lattice vector :math:`\vec{a}_3` is fixed and the shape of the
    unit cell is preserved.
  * ABS: The lattice vectors :math:`\vec{a}_1` and :math:`\vec{a}_2` are fixed
    and the shape of the unit cell is preserved.
  * ACS: The lattice vectors :math:`\vec{a}_1` and :math:`\vec{a}_3` are fixed
    and the shape of the unit cell is preserved.
  * BCS: The lattice vectors :math:`\vec{a}_2` and :math:`\vec{a}_1` are fixed
    and the shape of the unit cell is preserved.
  * R:	The aspect ratio of the unit cell is preserved. All lattice vectors
    are rescaled by the same constant.

 ALLOWED VALUES

  OFF, A, B, C, AB, AC, BC, ABC, S, AS, BS, CS, ABS, ACS, BCS, R

 RELATED INFORMATION

  :ref:`cell_var`, :ref:`cell_dyn_var`, :ref:`cell_mass_var`

.. _cell_mass_var:

cell_mass
---------

 NAME

  **cell_mass** - mass of the unit cell

 DESCRIPTION

  The cell_mass variable is the mass of the unit cell in atomic units
  (in which the mass of a carbon atom is 12.0). The default value is 10000.

 ALLOWED VALUES

  positive real values

 RELATED INFORMATION

  :ref:`cell_var`, :ref:`cell_dyn_var`

.. _charge_mix_coeff_var:

charge_mix_coeff	
----------------

 NAME

  **charge_mix_coeff** - charge density mixing coefficient

 DESCRIPTION

  The charge density mixing coefficient is used to update the electronic charge
  density during self-consistent iterations (see :ref:`charge_mix_ndim_var`).
  The default
  value is 0.5. Smaller values may be needed to ensure the convergence of
  self-consistent iterations in metallic systems.

 ALLOWED VALUES

  real values in the interval [0,1]

 RELATED INFORMATION

  :ref:`charge_mix_rcut_var`, :ref:`charge_mix_ndim_var`

.. _charge_mix_ndim_var:

charge_mix_ndim	
---------------

 NAME

  **charge_mix_ndim** – dimension of Anderson acceleration of charge mixing

 DESCRIPTION

  The **charge_mix_ndim** parameter determines how many previous charge density
  corrections are used in the Anderson acceleration of the charge mixing scheme.
  The new input charge density is computed according to

  .. math::

    \rho^{(k+1)}_{\rm in} = \bar{\rho} + \alpha \bar{f}

  where :math:`\alpha` is the charge mixing coefficient (variable
  :ref:`charge_mix_coeff_var`) and :math:`\bar f` is the
  least-squares residual in the subspace of dimension charge_mix_ndim
  spanned by the previous charge density corrections

  .. math::

    \bar{f} = \delta \rho^{(k)} +
    \sum_{i=1}^n \theta_i (\delta\rho^{(k-i)}_{\rm in}
    - \delta\rho^{(k)}_{\rm in} )

  where :math:`\delta\rho^{(k)}=\rho^{(k)}_{\rm out} - \rho^{(k)}_{\rm in}` is
  the difference between the output and input charge density of the
  self-consistent iteration k, and

  .. math::

    \bar{\rho}=\rho^{(k)}_{\rm in} +
    \sum_{i=1}^n \theta_i (\rho^{(k-i)}_{\rm in}
    - \rho^{(k)}_{\rm in} )

  The coefficients are chosen so as to minimize :math:`||\bar f ||^2_2`
  in a row-weighted least squares
  sense. The weight used in the LS calculation is the Kerker screening function

  .. math::

    w(G) = \frac{G^2+q_0^2}{G^2}

  where :math:`q_0=2\pi/r_c` and :math:`r_c` is the charge mixing cutoff
  radius (variable :ref:`charge_mix_rcut_var`).
  The default value of charge_mix_ndim is 3.

 SPECIAL VALUES

  Using charge_mix_ndim=0 leads to simple mixing

  .. math::

    \rho^{(k+1)}_{\rm in} = \rho^{(k)}_{\rm in} + \alpha (
    \rho^{(k)}_{\rm out} - \rho^{(k)}_{\rm in} )

 ALLOWED VALUES

  non-negative integers

 RELATED INFORMATION

  :ref:`charge_mix_rcut_var`, :ref:`charge_mix_coeff_var`

.. _charge_mix_rcut_var:

charge_mix_rcut
---------------

 NAME

  **charge_mix_rcut** - charge mixing cutoff radius

 DESCRIPTION

  The **charge_mix_rcut** variable is used to define the range of the Coulomb
  interaction in the Kerker screening function used in the charge density mixing
  scheme (see :ref:`charge_mix_ndim_var`). The default value of charge_mix_rcut
  is 10 a.u. If charge_mix_rcut is set to zero, no screening is used.

 ALLOWED VALUES

  positive real numbers

 RELATED INFORMATION

  :ref:`charge_mix_ndim_var`, :ref:`charge_mix_ndim_var`

.. _debug_var:

debug
-----

 NAME

  **debug** - debug parameters

 DESCRIPTION

  The **debug** variable is used to pass debug parameters to Qbox. It is
  not intended for normal use.

 ALLOWED VALUES

  character strings

.. _delta_spin_var:

delta_spin
----------

 NAME

  **delta_spin** – number of spin excitations

 DESCRIPTION

  The **delta_spin** variable is used to modify the total spin of the system by
  promoting electrons from the minority spin determinant to the majority spin
  determinant in spin-polarized calculations. The value of delta_spin is the
  number of electrons promoted. Depending on the total number of electrons
  :math:`N_e` and the value of delta_spin, the total spin takes values
  according to the following table :

  +----------+------------+------------+
  |    Ne    | delta_spin | total_spin |
  +==========+============+============+
  |   even   |      0     |  singlet   |
  +----------+------------+------------+
  |   odd    |      0     |  doublet   |
  +----------+------------+------------+
  |   even   |      1     |  triplet   |
  +----------+------------+------------+
  |   odd    |      1     |  quartet   |
  +----------+------------+------------+

  Higher total spin is obtained following the same pattern for larger values
  of delta_spin.

  Note: the variable :ref:`nspin_var` must be set to 2 before delta_spin can
  be modified. The value of delta_spin cannot be larger than
  :math:`\lfloor N_e / 2 \rfloor`.

 ALLOWED VALUES

  non-negative integers

 RELATED INFORMATION

  :ref:`nspin_var`

.. _dt_var:

dt
--

 NAME

  **dt** - simulation time step

 DESCRIPTION

  The **dt** variable is the simulation time step in atomic units of time
  (1 a.u. of time = 0.02418885 fs). The default value is 3 a.u.

 ALLOWED VALUES

  non-negative real numbers

 RELATED INFORMATION

  :ref:`atoms_dyn_var`, :ref:`wf_dyn_var`, :ref:`cell_dyn_var`

.. _ecut_var:

ecut
----

 NAME

  **ecut** - plane wave basis energy cutoff

 DESCRIPTION

  The **ecut** variable determines the size of the plane wave basis used to
  define the electronic wave functions. It must given in Rydberg units. The
  wave function plane wave basis consists of all plane waves having a kinetic
  energy smaller than :math:`E_{\rm cut}`. The charge density and the total
  potential are described
  using a larger basis set that includes all plane waves with a kinetic energy
  smaller than :math:`4 E_{\rm cut}`. The default value of ecut is zero,
  in which case the plane wave
  basis contains one basis function: the plane wave of wave vector
  :math:`G=0`.

 ALLOWED VALUES

  non-negative real numbers

.. _ecutprec_var:

ecutprec
--------

 NAME

  **ecutprec** - preconditioning energy cutoff

 DESCRIPTION

  The **ecutprec** variable defines the energy cutoff used in the
  preconditioner for electronic structure optimization. Corrections to the
  electronic wave functions are preconditioned in Fourier space using a diagonal
  preconditioning matrix K whose elements are defined by

  .. math::
   k(G) = \left\{
   \begin{array}{ll}
   \frac{1}{2 E_{\rm cut}^{\rm prec}} &
   \frac{1}{2}G^2 < E_{\rm cut}^{\rm prec}\\
   \frac{1}{G^2} & \frac{1}{2}G^2 \ge E_{\rm cut}^{\rm prec}\\
   \end{array}
   \right.

  The value of ecutprec must be given in Rydberg units. Preconditioning is only
  used if the :ref:`wf_dyn_var` variable is set to either PSD, PSDA or JD.
  If ecutprec = 0, an automatic preconditioner is used. The default value of
  ecutprec is zero (automatic preconditioning).

 ALLOWED VALUES

  non-negative real numbers smaller than or equal to :ref:`ecut_var`.

 RELATED INFORMATION

  :ref:`ecut_var`, :ref:`wf_dyn_var`

.. _ecuts_var:

ecuts
-----

 NAME

  **ecuts** - energy cutoff for stress confinement potential

 DESCRIPTION

  The ecuts variable defines the energy cutoff used in a confinement
  potential in Fourier space. The confinement potential is used when computing
  the stress tensor with variable cell size in order to ensure constant
  resolution as the unit cell changes size. The confinement energy is

  .. math::

    E_{\rm conf} = \frac{1}{2} \sum_{n,G} |c_{n,G}|^2 G^2 f(G)

  where the :math:`c_{n,G}` are wave function Fourier coefficients, and

  .. math::

   f(G) = f_s \left( 1 - \frac{1}{1+{\rm exp}((G^2/2-E_{\rm cut}^s)/\sigma_s)}
   \right)

  and :math:`f_s=2, \sigma_s=1/2`.
  The default value of **ecuts** is zero, in which case the confinement
  potential is not used.

  For a detailed description of the use of confinement potentials in
  constant pressure simulations, see

  1. P. Focher, G. L. Chiarotti, M. Bernasconi, et al. Structural
     Phase-Transformations Via 1St-Principles Simulation,
     Europhys. Lett. 26 (5): 345-351 (1994).
  2. M. Bernasconi, G. L. Chiarotti, P. Focher, et al. First-Principle
     Constant-Pressure Molecular-Dynamics, Journal of Physics and Chemistry
     of Solids 56 (3-4): 501-505 (1995).

 ALLOWED VALUES

  positive real numbers smaller than or equal to ecut

 RELATED INFORMATION

  :ref:`stress_var`, :ref:`cell_dyn_var`

.. _e_field_var:

e_field
-------

 NAME

  **e_field** – total electric field

 DESCRIPTION

  The **e_field** variable defines the three components of the total electric
  field :math:`\vec{E}=(E_x,E_y,E_z)`. The field must be given in atomic
  units (1 Hartree/(electron Bohr) = :math:`5.1422\times 10^{11}` V/m. The
  :ref:`polarization_var` variable must also be set in order to define the
  algorithm used to
  compute the electric dipole and quadrupole in the presence of the total
  electric field.  The default value of **e_field** is zero.

 ALLOWED VALUES

  three real numbers

 RELATED INFORMATION

  :ref:`polarization_var`

.. _emass_var:

emass
-----

 NAME

  **emass** - fictitious electronic mass for Car-Parrinello simulations

 DESCRIPTION

  The **emass** variable defines the fictitious electronic mass used in
  Car-Parrinello simulations. The default value is zero, in which case the
  fictitious electronic mass used in the calculation is
  :math:`m_e=2 E_{\rm cut} dt^2`. The value of emass is
  only relevant if the variable :ref:`wf_dyn_var` is set to MD
  (i.e. if the wave function dynamics is Car-Parrinello).
  It is ignored otherwise.

 ALLOWED VALUES

  positive real values

 RELATED INFORMATION

  :ref:`wf_dyn_var`

.. _ext_stress_var:

ext_stress
----------

 NAME

  **ext_stress** - external stress

 DESCRIPTION

  The **ext_stress** variable determines the value of the externally applied
  stress. The ext_stress variable must be set using the following syntax:

  **set ext_stress** *s_xx s_yy s_zz s_xy s_yz s_xz*

  where the values of the elements of the stress tensor must be given
  in GPa units. The external stress can be positive or negative.
  The default value is zero.

 ALLOWED VALUES

  real numbers

 RELATED INFORMATION

  :ref:`stress_var`

.. _fermi_temp_var:

fermi_temp
----------

 NAME

  **fermi_temp** - Fermi temperature for fractionally occupied states

 DESCRIPTION

  The **fermi_temp** variable determines the value of the Fermi temperature
  used to compute occupation factors for fractionally occupied states. The
  value must be given in degrees Kelvin. The default value is zero.

 ALLOWED VALUES

  non-negative real numbers

 RELATED INFORMATION

  :ref:`nempty_var`

.. _force_tol_var:

force_tol
----------

 NAME

  **force_tol** - force tolerance variable

 DESCRIPTION

  The **force_tol** variable determines the force tolerance criterion for
  convergence of geometry optimizations. The unit is (hartree/bohr).
  The default value is zero.
  The maximum number of ionic iterations is determined by the first
  argument *niter* of the :ref:`run_cmd` command:

  **run** *niter nitscf nite*.

  If force_tol is set to a
  non-zero value and if all components of all forces are smaller than
  force_tol in absolute value, the remaining ionic iterations are skipped.
  If force_tol is zero, the number of ionic iterations is *niter*.

 ALLOWED VALUES

  non-negative real numbers

 RELATED INFORMATION

  :ref:`atoms_dyn_var`

.. _iter_cmd_var:

iter_cmd
--------

 NAME

  **iter_cmd** - command or script to be executed every iter_cmd_period
  ionic steps

 DESCRIPTION

  The **iter_cmd** variable defines a command or script that is executed
  every :ref:`iter_cmd_period_var` ionic steps.  If a single command must
  be executed, the full command (with arguments) can be used as the value
  of iter_cmd. If multiple commands are used, they must be written in a
  local script file, and the name of
  the script is used as the value of iter_cmd.

 ALLOWED VALUES

  string

 RELATED INFORMATION

  :ref:`iter_cmd_period_var`

.. _iter_cmd_period_var:

iter_cmd_period
---------------

 NAME

  **iter_cmd_period** --number of ionic steps between executions of iter_cmd

 DESCRIPTION

  The **iter_cmd_period** variable defines the number of ionic steps that
  separate successive executions of the command (or script) defined by iter_cmd.
  The default value is 1.

 ALLOWED VALUES

  positive integers

 RELATED INFORMATION

  :ref:`iter_cmd_var`

.. _lock_cm_var:

lock_cm
-------

 NAME

  **lock_cm** - center of mass lock control variable

 DESCRIPTION

  The **lock_cm** variable determines whether the center of mass
  of the system is kept fixed during a simulation.
  The possible values are ON and OFF. The default is OFF.

 ALLOWED VALUES

  ON, OFF

 RELATED INFORMATION

  :ref:`status_cmd`

.. _mu_RSH_var:

mu_RSH
------

 NAME

  **mu_RSH** – parameter of the range-separated hybrid functional

 DESCRIPTION

  See the definition of the RSH functional in the description of
  the :ref:`xc_var` variable.

 ALLOWED VALUES

  non-negative real numbers

 RELATED INFORMATION

  :ref:`xc_var`

.. _nempty_var:

nempty
------

 NAME

  **nempty** - number of empty electronic states

 DESCRIPTION

  The **nempty** variable determines the number of electronic states that
  are included in the calculation in addition to the number of states needed to
  accommodate the total number of electrons. If nempty is non-zero, the
  eigenvalues and eigenvectors of the Kohn-Sham hamiltonian are computed at each
  electronic iteration and the charge density is recomputed from the
  eigenvectors using a Fermi distribution. The default value of nempty is zero.

 ALLOWED VALUES

  non-negative integers

 RELATED INFORMATION

  :ref:`fermi_temp_var`

.. _net_charge_var:

net_charge
----------

 NAME

  **net_charge** - net charge of the system

 DESCRIPTION

  The **net_charge** variable is used to control the total amount of
  electronic charge in the calculation. If net_charge = 0, the total number of
  electrons is determined from the sum of the valence charges given in the
  species definition files and the system is neutral. If net_charge = -1, an
  extra electron is added to the system. If net_charge = 1, an electron is
  removed from the system. The default value is zero.

 ALLOWED VALUES

  integers

.. _nrowmax_var:

nrowmax
-------

 NAME

  **nrowmax** - (deprecated) maximum number of process grid rows

 DESCRIPTION

  As of release 1.72.0 the **nrowmax** variable is deprecated.
  The process grid geometry is determined by the
  ``-nstb``, ``-nkpb`` and ``-nspb`` command line options used
  when invoking Qbox. These command line options are
  described in the :ref:`cmd_line_options` Section.

.. _nspin_var:

nspin
-----

 NAME

  **nspin** - number of spin degrees of freedom

 DESCRIPTION

  The **nspin** variable is used to determine the number of spin components
  of the wave function. The default value is 1 (no spin polarization).

 ALLOWED VALUES

  1 or 2

.. _occ_var:

occ
---

 NAME

  **occ** - electronic occupation numbers

 DESCRIPTION

  The **occ** variable is used to set the electronic occupation numbers.
  In a spin-unpolarized system (i.e. if **nspin** =1) the occupation number
  of state *n* can be set to the value *f* using the
  command: “ **set occ** *n f* ”.
  In a spin-polarized system, the command is: " **set occ** *ispin n f* "
  where *ispin* can take the value 1 or 2. The current value of all occupation
  numbers can be printed using the command " **print occ** ". The occupation
  numbers are reset to their default values when modifying the variables
  **nspin** , **delta_spin** , **nempty** and **net_charge**, and when using
  commands that change the total number of states (e.g. **atom**).
  The **occ** variable can be used to perform :math:`\Delta` SCF calculations
  in which the sequence of occupation numbers is e.g. 2,2,2,0,2.

 ALLOWED VALUES

  The value of *f* must be in [0,2] for spin-unpolarized systems, and
  in [0,1] for spin-polarized systems.

.. _polarization_var:

polarization
------------

 NAME

  **polarization** - algorithm used to compute the dipole and quadrupole moments

 DESCRIPTION

  The **polarization** variable determines the algorithm used
  to compute the electric dipole and quadrupole. The allowed values are

  * OFF: The dipole and quadrupole are not computed. This is the default.
  * MLWF: The electronic dipole is defined as the center of charge of maximally
    localized Wannier functions (MLWF).
  * MLWF_REF: The electronic dipole is defined as the center of charge of
    maximally localized Wannier functions (MLWF) with the refinement
    correction proposed by M. Stengel and N. Spaldin,
    Phys. Rev. B73, 075121 (2006).
  * MLWF_REF_Q: The electronic dipole is defined as for MLWF_REF and the
    quadrupole moment is computed.
  * BERRY: The electronic dipole is computed using the definition based on
    the Berry phase as defined by I. Souza et al, Phys. Rev. Lett.
    89, 117602 (2002).

  The ionic, electronic and total dipole :math:`\vec d` are computed and
  printed in units of
  (electron bohr). Note that the total dipole is only defined modulo an additive
  constant multiple of the lattice vectors in a periodic system. A dipole
  expressed in (electron bohr) can be converted to (Debye) using the relation 1
  (electron Bohr) = 2.5417462 (Debye). Conversely, dipoles expressed in (Debye)
  can be converted to (electron bohr) using the relation 1 (Debye) = 0.39343031
  (electron bohr).

  If the total electric field (defined by the :ref:`e_field_var` variable)
  is non-zero, the calculation of the electronic ground state is performed
  using the electric enthalpy as defined by Souza et al., in order to
  impose a constant value of the total field. Note that :math:`\vec E` is
  the total field, not the applied field.

  The polarizability tensor of the system is defined as

  .. math::
   \alpha_{ij} = \frac{\delta d_i}{\delta E_j}

  and is defined in units of (bohr\ :sup:`3`), :math:`\delta d_i` in
  (electron bohr), and :math:`E_j` in (hartree/(electron bohr)).
  The polarizability tensor :math:`\alpha_{ij}` can be computed using
  calculations of the total dipole induced by small changes
  :math:`\delta E_j` around :math:`\vec E = 0`.

  The change in dipole :math:`\delta d_i` due to a small change in total
  field :math:`\delta E_j` is computed using the
  centered finite difference expression

  .. math::
   \delta d_i = \frac{1}{2} \left[ d_i(+\delta E_j)-d_i(-\delta E_j)\right]

  The polarizability tensor can then be expressed as

  .. math::
   \alpha_{ij} = \frac{d_i(+\delta E_j)-d_i(-\delta E_j)}{2 \delta E_j}

  The full polarization tensor can be obtained using 6 calculations of the
  dipole (2 evaluations in 3 directions). Note that since the polarization due
  to a finite field includes linear and higher order terms, this calculation
  must
  be repeated with decreasing values of :math:`\delta E_j` in order to obtain
  an accurate value of the linear polarizability.

  In solids, the average polarization (dipole per unit volume) is defined as

  .. math::
   \vec{P}=\frac{\vec d}{\Omega}

  where :math:`\Omega` is the unit cell volume.
  The susceptibility tensor :math:`\chi` and the dielectric tensor
  :math:`\epsilon`
  (relative dielectric permittivity) are related by
  :math:`\epsilon = I + \chi`.

  Using the SI unit convention,

  .. math::
   \vec{D} = \epsilon_0 \vec{E} + \vec{P}

  and using atomic units, we have
  :math:`4 \pi \epsilon_0 = 1` and the polarization can be expressed as

  .. math::
   \vec{P}=\chi\epsilon_0\vec{E} = \frac{\chi}{4 \pi} \vec{E}

  A small change in total field :math:`\delta\vec{E}` corresponds to a change
  of polarization

  .. math::
   \delta\vec{P} = \frac{\chi}{4\pi} \, \delta\vec{E}

  If a sufficiently large unit cell is used, an estimate of the dielectric
  tensor can be computed using the finite-difference expression

  .. math::
   \epsilon_{ij} = \delta_{ij} + 4\pi
   \frac{\delta P_i(+\delta E_j) - \delta P_i(-\delta E_j)}{2\delta E_j}
   = \delta_{ij} + \frac{4\pi}{\Omega}
   \frac{\delta d_i(+\delta E_j) - \delta d_i(-\delta E_j)}{2\delta E_j}

  or, in terms of the polarizability tensor,

  .. math::
   \epsilon_{ij} = \delta_{ij} + \frac{4\pi}{\Omega} \alpha_{ij}

  **Molecular polarizability**

  The polarizability computed from

  .. math::
   \alpha_{ij} = \frac{\delta d_i}{\delta E_j}

  is the polarizability of an inifinite crystal that consists of the repeated
  unit cell. When computing the electronic properties of a molecule
  placed in a large, empty unit cell, the isotropic polarizability of a
  single isolated molecule can be evaluated using the Clausius-Mossotti relation

  .. math::
   \alpha_{\rm CM} = \frac{3 \epsilon_0}{N} \frac{\epsilon - 1}{\epsilon + 2}

  where :math:`N = 1/\Omega` is the number of molecules per unit volume. Using
  the above definitions of the dielectric tensor, we get

  .. math::
   \alpha_{\rm CM} = \frac{\alpha}{1 + \frac{4 \pi}{3\Omega} \alpha}

  where :math:`\alpha` is the isotropic polarizability

  .. math::
   \alpha = \frac{1}{3}(\alpha_{11} + \alpha_{22} + \alpha_{33})

  **Quadrupole moment**

  The quadrupole moment tensor is computed if the MLWF_REF_Q value is used.
  It is defined as

  .. math::
   Q_{ij} = e \int_\Omega x_i x_j \rho(x) \, d^3 x

  in units of (electron bohr\ :sup:`2`).
  Note that this may differ from other definitions used in the literature, which
  may include a factor 1/2 in the above definition. The traceless quadrupole
  tensor defined as :math:`Q-({\rm tr} Q/3) I` is also computed and printed.
  Some definitions used in the
  literature include an extra multiplicative factor of 3, or 3/2.

  The quadrupole moment is sometimes expressed in units of (Debye Å), related to
  (electron bohr\ :sup:`2`) by the expressions 1 (Debye Å) = 0.743476
  (electron bohr\ :sup:`2`) and 1 (electron bohr\ :sup:`2`) =
  1.3450336 (Debye Å) . The NIST Computational Chemistry Database
  (http://cccbdb.nist.gov) provides quadrupole moments of molecules in
  (Debye Å). A comparison of Qbox results with NIST values can be made using
  the relation:

  .. math::
   Q^{\rm NIST} {\rm (Debye Å)} = \frac{3}{2} 1.3450336 \; Q^{\rm Qbox}
   ({\rm e\; bohr}^2)

  Born effective charges are defined as the derivatives of ionic forces
  with respect to the total field

  .. math::
   Z_{ij}^\alpha = \frac{\delta F_i^\alpha}{\delta E_j}

  whereis :math:`F_i^\alpha` the ith component of the force on
  atom :math:`\alpha`. Born effective charges can be
  similarly computed using finite difference expressions.

  The calculation of the polarization is only implemented at
  the :math:`\Gamma` point of the Brillouin zone, for systems having no
  spin polarization.

 ALLOWED VALUES

  OFF, MLWF, MLWF_REF, MLWF_REF_Q, BERRY

 RELATED INFORMATION

  :ref:`e_field_var`

.. _ref_cell_var:

ref_cell
--------

 NAME

  ref_cell --reference unit cell

 DESCRIPTION

  The **ref_cell** variable determines the size of the reference unit
  cell. The reference unit cell is used in constant pressure calculations to
  ensure constant resolution of the basis set as the unit cell changes size. The
  unit cell must always be enclosed in the reference unit cell during a constant
  pressure calculation.

 ALLOWED VALUES

  positive real numbers

 RELATED INFORMATION

  :ref:`cell_var`

.. _scf_tol_var:

scf_tol
-------

 NAME

  **scf_tol** – tolerance for convergence of SCF iterations

 DESCRIPTION

  The **scf_tol** variable determines the energy tolerance criterion for
  convergence of SCF iterations. The unit is (a.u.) (hartree). The default value
  is zero. The maximum number of SCF iterations is determined by the second
  argument of the :ref:`run_cmd` command: “ **run** *niter nitscf nite* ”.
  If scf_tol is set to a
  non-zero value and if the energy changes by less than scf_tol in three
  successive SCF iterations, the remaining SCF iterations are skipped.
  If scf_tol is zero, the number of SCF iterations is *nitscf*.

 ALLOWED VALUES

  non-negative real numbers

 RELATED INFORMATION

  :ref:`run_cmd`

.. _stress_var:

stress
------

 NAME

  **stress** - stress calculation control variable

 DESCRIPTION

  The **stress** variable determines whether the stress tensor is calculated.
  The possible values are ON and OFF. The default is OFF.

 ALLOWED VALUES

  ON, OFF

 RELATED INFORMATION

  :ref:`ext_stress_var`, :ref:`cell_dyn_var`

.. _stress_tol_var:

stress_tol
----------

 NAME

  **stress_tol** - stress tolerance variable

 DESCRIPTION

  The **stress_tol** variable determines the stress tolerance criterion for
  convergence of unit cell relaxations. The unit is (GPa). The default value
  is zero. The maximum number of ionic iterations is determined by the first
  argument of the :ref:`run_cmd` command: “ **run** *niter nitscf nite* ”.
  If stress_tol is set to a
  non-zero value and if all elements of the stress tensor are smaller than
  stress_tol in absolute value, the remaining ionic iterations are skipped.
  If stress_tol is zero, the number of ionic iterations is *niter*.

 ALLOWED VALUES

  non-negative real numbers

 RELATED INFORMATION

  :ref:`stress_var`, :ref:`ext_stress_var`, :ref:`cell_dyn_var`

.. _thermostat_var:

thermostat
----------

 NAME

  **thermostat** - thermostat control variable

 DESCRIPTION

  The **thermostat** variable determines what type of thermostat is used for
  constant temperature simulations. Valid choices are

  * OFF: No thermostat is used. This is the default.
  * SCALING: Scaling of velocities. At each MD step, the velocities of
    all atoms are rescaled as

    .. math::
     v_i := v_i (1 - \eta dt)

    where

    .. math::
     \eta = \frac{1}{\tau} {\rm tanh} \frac{T-T_{\rm ref}}{\Delta}

    is the thermostat time constant (variable :ref:`th_time_var`), :math:`T` is
    the instantaneous temperature computed from the ionic kinetic energy,
    :math:`T_{\rm ref}` is the thermostat reference temperature (variable
    :ref:`th_temp_var`), and :math:`\Delta` is the thermostat temperature
    width (variable :ref:`th_width_var`).

  * ANDERSEN: Andersen thermostat. The atoms are subjected to random
    collisions with particles drawn from a Maxwell distribution of velocities
    with temperature :math:`T_{\rm ref}`. The collision frequency is
    :math:`1/\tau` where :math:`\tau` is given by the variable
    :ref:`th_time_var` (see H. C. Andersen, J. Chem. Phys. 72, 2384 (1980)).

  * LOWE: Lowe thermostat. Pairs of atoms are subjected to random collisions
    with a particle drawn from a Maxwell distribution of velocities with
    temperature :math:`T_{\rm ref}`. The collision frequency is
    :math:`1/\tau` where :math:`\tau` is given by the variable
    :ref:`th_time_var`. The Lowe thermostat is similar to
    the Andersen thermostat but conserves total momentum (see C. P. Lowe,
    Europhys. Lett. 47, 145 (1999)).

  * BDP: Bussi-Donadio-Parrinello thermostat. The stochastic thermostat
    described by Bussi, Donadio and Parrinello in J. Chem. Phys. 126, 014101
    (2007) is used. The parameter :math:`\tau` used in the BDP paper is the
    value of the variable :ref:`th_time_var`.
    The value of the variable th_width is ignored. When using
    the BDP thermostat, the value of <econst> printed on output corresponds to
    the conserved energy described in the above paper.

 ALLOWED VALUES

  OFF, SCALING, ANDERSON, LOWE, BDP

 RELATED INFORMATION

  :ref:`th_temp_var`, :ref:`th_time_var`, :ref:`th_width_var`

.. _th_temp_var:

th_temp
-------

 NAME

  **th_temp** - thermostat reference temperature

 DESCRIPTION

  The **th_temp** variable determines the thermostat reference temperature.
  The default is zero. See the :ref:`thermostat_var` variable.

 ALLOWED VALUES

  non-negative real numbers

 RELATED INFORMATION

  :ref:`thermostat_var`, :ref:`th_time_var`, :ref:`th_width_var`

.. _th_time_var:

th_time
-------

 NAME

  **th_time** - thermostat time constant

 DESCRIPTION

  The **th_time** variable determines the thermostat time constant. The time
  constant is a measure of the time over which the thermostat adjusts the
  temperature. See :ref:`thermostat_var` for details. The value of th_time
  must be given in atomic units of time. The default value is 5000 a.u.
  (~ 120 fs).

 ALLOWED VALUES

  positive real numbers

 RELATED INFORMATION

  :ref:`th_temp_var`, :ref:`th_width_var`, :ref:`thermostat_var`

.. _th_width_var:

th_width
--------

 NAME

  **th_width** - thermostat temperature window

 DESCRIPTION

  The **th_width** determines the value of the thermostat temperature
  width. See :ref:`thermostat_var` for details. The value of th_width must
  be given in degrees Kelvin. The default value is 100 K.

 ALLOWED VALUES

  positive real numbers

 RELATED INFORMATION

  :ref:`th_temp_var`, :ref:`th_time_var`, :ref:`thermostat_var`

.. _vext_var:

vext
----

 NAME

  **vext** - external potential file name

 DESCRIPTION

  The **vext** variable contains the name of a file describing a periodic
  external potential. If the variable is set to a non-empty string,
  subsequent calculations will include the external potential.
  The variable can be reset by using::

   set vext NULL

  which will revert to using no external potential.
  The file describing the external potential must be an XML file that
  conforms to the following example::

   <?xml version="1.0" encoding="UTF-8"?>
   <fpmd:function3d xmlns:fpmd="http://www.quantum-simulation.org/ns/fpmd/fpmd-1.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://www.quantum-simulation.org/ns/fpmd/fpmd-1.0 function3d.xsd"
    name="delta_v">
    <domain a="16.0 0.0 0.0"
            b="0.0 16.0 0.0"
            c="0.0 0.0 16.0"/>
   <grid nx="64" ny="64" nz="64"/>
   <grid_function type="double" nx="64" ny="64" nz="64" encoding="base64">
   AAAAAAAAAAAAAAAAAACgPwAAAAAAAMA/AAAAAAAA0j8AAAAAAADgPwAAAAAAAOk/AAAAAAAA8j8A
   AAAAAID4PwAAAAAAAABAAAAAAABABEAAAAAAAAAJQAAAAAAAQA5AAAAAAAAAEkAAAAAAACAVQAAA
   ...
   QAAAAAAAgABAAAAAAACA+T8AAAAAAADzPwAAAAAAAOs/AAAAAAAA4j8AAAAAAADWPwAAAAAAAMg/
   AAAAAAAAuD8=
   </grid_function>
   </fpmd:function3d>

  The values of the potential on the points defined by the grid are encoded
  using base64 encoding. The values are ordered as k,j,i with the i index
  changing fastest. See the file util/vext/mkvext.py for an example of how
  to generate an arbitrary external potential file.
  The value of the **name** attribute can be arbitrary. The origin of
  coordinates of the (nx,ny,nz) grid corresponds to the atomic position (0,0,0)
  in the unit cell.

 ALLOWED VALUES

  string

 RELATED INFORMATION

.. _wf_diag_var:

wf_diag
-------

 NAME

  **wf_diag** - diagonalization control variable

 DESCRIPTION

  The **wf_diag** variable determines whether eigenvectors and/or eigenvalues of
  the hamiltonian are computed after each optimization of the electronic
  structure. Valid choices are:

  * T: True. Eigenvalues and eigenvectors are computed. Eigenvalues are
    printed on output in eV units.
  * F: False. Eigenvalues and eigenvectors are not computed.
    This is the default.
  * EIGVAL: Eigenvalues only. The eigenvalues are computed and printed, but
    eigenvectors are not computed.
  * MLWF: Maximally localized Wannier Functions (MLWFs) are computed.
  * MLWFC: The position of MLWF centers is computed and printed but MLWFs
    are not computed.

  If empty states are added to the calculation (variable :ref:`nempty_var` > 0),
  the eigenvalues and eigenvectors are always computed.

 ALLOWED VALUES

  T, F, EIGVAL,MLWF,MLWFC

.. _wf_dyn_var:

wf_dyn
------

 NAME

  **wf_dyn** – wave function dynamics control variable

 DESCRIPTION

  The **wf_dyn** variable determines which algorithm is used to update the wave
  functions during electronic structure optimization. The choices are

  * SD: Steepest Descent. This the default. Wavefunctions are
    updated as follows:

    .. math::

     \Psi^{(k+1)} = \Psi^{(k)} - \alpha H \Psi^{(k)}

    where

    .. math::
     \alpha = \left\{
     \begin{array}{ll}
     \frac{1}{2 E_{\rm cut}} & m_e = 0 \\
     \frac{dt^2}{m_e} & m_e > 0 \\
     \end{array}
     \right.

    and :math:`m_e` is the fictitious electronic mass (variable emass). By
    default, :math:`m_e=0`. (Note that the SD algorithm is very inefficient and
    is not used in practice. It is provided for debugging purposes).

  * PSD: Preconditioned Steepest Descent. Wavefunctions are updated as follows:

    .. math::
     \Psi^{(k+1)} = \Psi^{(k)} - \alpha K P_c H \Psi^{(k)}

    where K is a diagonal preconditioning matrix

    .. math::
     k_{ij} = \delta_{ij} k(G)

    where

    .. math::
     k(G) = \left\{
     \begin{array}{ll}
     \frac{1}{2 E_{\rm cut}^{\rm prec}} &
     \frac{1}{2}G^2 < E_{\rm cut}^{\rm prec}\\
     \frac{1}{G^2} & \frac{1}{2}G^2 \ge E_{\rm cut}^{\rm prec}\\
     \end{array}
     \right.

    and :math:`P_c` is a projector on the orthogonal complement of the
    subspace spanned by all computed wave functions. The preconditioning
    matrix depends on the value of the variable :ref:`ecutprec_var`.

  * PSDA: Preconditioned Steepest Descent with Anderson acceleration.
    Wave functions are updated as with the PSD option, and convergence is
    accelerated by the Anderson scheme (D. G. Anderson, *JACM* 12, No 4,
    pp. 547-560 (1965)).

  * JD: Jacobi-Davidson. Wave functions are updated using a preconditioned
    Jacobi-Davidson algorithm.

  * MD: Molecular Dynamics. Wave functions are updated using the
    Car-Parrinello scheme

    .. math::

     \Psi^{(k+1)}_i = 2 \Psi^{(k)}_i - \Psi^{(k-1)}_i -
     \frac{dt^2}{m_e} H \Psi^{(k)}_i + \sum_j \Lambda_{ij} \Psi^{(k)}_j

    where holonomic constraints are used to enforce orthogonality.

  * LOCKED. Wavefunctions are not updated.

 ALLOWED VALUES

  SD, PSD, PSDA, JD, MD, LOCKED

 RELATED INFORMATION

  :ref:`ecutprec_var`

.. _xc_var:

xc
--

 NAME

  **xc** - exchange-correlation functional control variable

 DESCRIPTION

  The **xc** variable determines which exchange-correlation functional is used
  in the electronic structure calculation. Valid choices are :

  * LDA:	Local Density Approximation, Ceperley-Alder data.
    This is the default.
  * VWN: Local Density Approximation, parameterized by Vosko, Wilk and Nusair.
  * PBE: Perdew-Burke-Ernzerhof GGA functional.
  * PBE0: Hybrid density functional [C. Adamo and V. Barone, JCP 110,
    6158 (1999)].
  * BLYP: Becke-Lee-Yang-Parr functional.
  * HF: 	Hartree-Fock.
  * B3LYP: Three-parameter Becke-Lee-Yang-Parr hybrid density functional.
  * HSE: Heyd-Scuseria-Ernzerhof 2006 hybrid density functional.
  * RSH: Range-separated hybrid density functional [J. Skone et al. Phys.
    Rev. B 93, 235106 (2016)].
  * BHandHLYP: Becke "half-and-half" LYP hybrid density functional.
  * SCAN: Strongly Constrained and Appropriately Normed functional [J.
    Sun et al. Phys. Rev. Lett. 115, 036402 (2015)].

  The RSH functional uses the following definition of the electron self-energy

  .. math::

    \Sigma = \alpha \Sigma^{\rm erf}(\mu) + \beta \Sigma^{\rm erfc}(\mu) +
    (1-\alpha) \Sigma^{\rm LR}_{\rm x}(\mu) +
    (1-\beta) \Sigma^{\rm SR}_{\rm x}(\mu)

  where the parameters :math:`\alpha, \beta, \mu` have the values of the
  variables alpha_RSH, beta_RSH and mu_RSH respectively, and

   :math:`\Sigma^{\rm erf}(\mu)` is a screened exchange operator having
   an interaction potential :math:`\rm erf (\mu r) / r`

   :math:`\Sigma^{\rm erfc}(\mu)` is a screened exchange operator having
   an interaction potential :math:`\rm erfc (\mu r) / r`

   :math:`\Sigma^{\rm LR}_{\rm x}(\mu)` is the long-range semilocal PBE
   exchange potential

   :math:`\Sigma^{\rm SR}_{\rm x}(\mu)` is the short-range semilocal PBE
   exchange potential

  The following table shows how some specific functionals are special cases
  of the RSH functional:

  .. |LCmuPBE| replace:: LC\ :math:`\mu`\ PBE

  .. |alpha| replace:: :math:`\alpha`

  .. |beta| replace:: :math:`\beta`

  .. |mu| replace:: :math:`\mu`

  .. |infty| replace:: :math:`\infty`

  +------------+---------+---------+---------+
  |            | |alpha| |  |beta| |   |mu|  |
  +============+=========+=========+=========+
  |   HSE      |    0    |   0.25  |  0.11   |
  +------------+---------+---------+---------+
  |   PBE0     |   0.25  |   0     | |infty| |
  +------------+---------+---------+---------+
  |   PBE      |    0    |   0     |      0  |
  +------------+---------+---------+---------+
  |  CAM-B3LYP |   0.46  |  0.19   |  0.33   |
  +------------+---------+---------+---------+
  | |LCmuPBE|  |    1    |   0     |   0.4   |
  +------------+---------+---------+---------+


  If the RSH functional is selected, the default parameter values correspond
  to the HSE functional.

 ALLOWED VALUES

  LDA, VWN, PBE, PBE0, BLYP, HF, B3LYP, HSE, RSH, BHandHLYP, SCAN

