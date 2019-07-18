# Geomechanics.jl


## Introduction.
This package is being designed among others to provide Petroleum Engineering tools in a modern programming language. This package is part of the project 7G which  proposes to make basic but powerful engineering software packages that cover the main topics of the Oil and Gas development phases which could be applied to any case study by suitable engineers.

There are five topics in which the project is going to be focused on:

<br>-Geoscience (Current Package)
<br>-Reservoir
<br>-Production
<br>-Economics
<br>-Integration

<br> The package will always be in permanent development and open to suggestions to enhance the program. As the code has been written so far by a code enthusiastic Petroleum Engineer I hope to learn as much as possible to get better and useful programs.

## Geomechanics.jl Description

Geomechanics.jl is a package that allows to make Geomechanics analysis focused on the Unconventional Resources evaluation.

## Stress State

By giving the pressure gradient in Psi/ft of the vertical stress, pore pressure and friction coefficient (Sv, Pp, μ) you can plot a zobackogram which shows the range of stresses.

### Example

```julia
using Geomechanics

Sv=1.0
Pp=0.433
μ=0.6
p1=zobackogram(Sv,Pp,μ, title="Stress State")
```
<img src="Geomechanics_EQ1.PNG"><br>
