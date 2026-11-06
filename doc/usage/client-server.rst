.. _client-server:

Client-Server Operation
=======================

Qbox can be used in client-server mode. This means that Qbox can run on one
computer as a server that “listens” to commands being sent from another
computer. 
Commands can be sent interactively by a user, but also by another program (the
“client”, or “driver”). 
It is assumed that the computers used by the client and the server share a 
common file system. Typically, the client and server are different 
processes running on the same computer.

Client-server operation allows for extensions of the functionality of Qbox
in which the client and the server interact to achieve a result that is not
easy to get with the conventional approach of submitting a fixed input file to
Qbox. A Qbox driver (or “Qbox application”) program sends commands to Qbox by
writing them to a file. Qbox reads the commands, executes them, and produces an
output file. The client code can then read the output file, process it, and
send  the next commands to Qbox. Synchronization of this process is implemented
through the creation (or  destruction) of a file (the “lock” file) that signals
that the output (or input) file is ready for use.  Qbox is run in client-server
mode by invoking it as follows::

$ mpirun -np <ntasks> qbox_exec -server input_file output_file

The sequence of operations in client-server mode is described below

**Qbox:**

 1) Create a new file named *output_file*.
 2) Read commands from *input_file* and execute them until the end of file is
    reached. Write the output on *output_file*. After executing the last 
    command in *input_file*, close *output_file* and create a file named 
    *input_file.lock* to signal that Qbox is ready for more commands.
 3) Wait for the file *input_file.lock* to be removed by the driver. 
 4) Go to 1)

**Client:**

 1) Wait for the *file input_file.lock* to appear.
 2) Open the file *output_file* and read its contents. 
 3) Analyze the contents and decide what course of action to take. 
 4) Open the file *input_file* and overwrite it with new commands. 
 5) Close *input_file*.
 6) Remove *input_file.lock* to signal that the file *input_file* is ready.
 7) Go to 1)

Note that in server mode, Qbox only exits when it reads the **quit** command. 
When reaching the end of file in input, Qbox does not exit  but creates the lock
file and then waits for the client to remove it. It then starts reading the
input file again.

The contents of *output_file* form a valid XML document, i.e. The XML header is
repeated every time the output file is rewritten. This allows one to process
each output file using XML tools, such as e.g. XSLT scripts or a python XML
parser. 

A client can manage multiple copies of Qbox running in server mode. In that
case, multiple copies of Qbox must be launched with different input and output
file names. For example::

$ mpirun -np <ntasks> qbox_exec -server in0 out0 &
$ mpirun -np <ntasks> qbox_exec -server in1 out1 &
$ mpirun -np <ntasks> qbox_exec -server in2 out2 &

The client must then write on the files *in0, in1, in2*, and read 
output from the
files *out0, out1, out2*. This allows for simulations involving 
multiple samples,
such as replica exchange dynamics, nudged-elastic-band (NEB) simulations, or
path-integral molecular dynamics.
