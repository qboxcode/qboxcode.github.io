Installing Qbox
===============

The Qbox distribution can be downloaded as a tar file 
from http://www.qboxcode.org/download

Example Makefiles are available in the build/ directory of the distribution.

The Qbox distribution is also available from the Qbox GitLab server using::

  $ git clone http://scherzo.ucdavis.edu/qbox/qbox-public.git 


Installation steps
------------------

Note: The installation steps are described below for version 1.64.0. 
Please change the version number accordingly for later versions.

1) Unpack the Qbox tar file::

   $ tar zxf qb-1.64.0.tgz

2) Identify a file in the build directory that is closest to your platform 
   (e.g. centos7.mk) and create a copy <myplatform>.mk where 
   <myplatform> is any name that identifies the current platform::

   $ cd rel1_64_0/src
   $ cp ../build/centos7.mk <myplatform>.mk
 
3) Edit the file <myplatform>.mk to customize for the current platform::

   $ vi <myplatform.mk>

4) Compile::

   $ export TARGET=<myplatform>
   $ make

The Qbox executable is ``rel1_64_0/src/qb``.

