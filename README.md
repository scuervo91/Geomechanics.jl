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


## Stress Polygon
```julia
using Geomechanics

Sv=1.0
Pp=0.433
μ=0.6
p1=zobackogram(Sv,Pp,μ, title="Stress State")
```
<img src="Geomechanics_EQ1.PNG"><br>


## Ternary Plots

You can plot the composition of the rocks by using a ternary plot recipe:

```julia

SampleA=[.16,0.19,0.65]
SampleB=[0.38,0.55,0.07]
SampleC=[0.3,0.4,0.3]
Data=[SampleA';SampleB']

p1=triplot(Data,1,NodeName=["Clay","Quartz","Calcite"])
p1=triplot!(SampleC',1, markercolor=:green,NodeName=["Clay","Quartz","Calcite"])

p2=triplot(rand(20,3),1,Norm=true)
plot(p1,p2,layout=(1,2), size=(900,400))
```
<img src="Geomechanics_EQ2.PNG"><br>


## Stress on Fault

You can estimate the Normal (σn) and Shear (τ) stress on a fault with an arbitrary strike and dip direction and plot it on a Mohr circle

```julia
Data=CSV.read("FractureData.csv")
first(Data,10)
```
<img src="Geomechanics_EQ3.PNG"><br>

```julia
S=[0.97,0.78,0.6] # Principal Stresses Normal Faulting [Sv, Shmax,Shmin] [psi/ft]
Pp=0.43           # Pore Pressure [psi/ft]
μ=0.6             # Coeficient of sliding friction
a =0              #trend of S1, except when S1 is vertical a = trend of SHmax minus 90 degrees
b =-90 #-plunge of S1 (plunge is angle from horizontal)
c =0.0            #rake of S2, 0 if S1 or S3 is vertical, 90 if S2 is vertical

σn, τ, CFF=FaultStress(S,Pp,μ,a,b,c,Data[1:10,:])
σn2, τ2, CFF2=FaultStress(S,Pp,μ,a,b,c,Data)
p1=mohr3(S, Pp, μ, σn, τ, CFF, title="3D Mohr Circle first 10 Faults")
p2=mohr3(S, Pp, μ, σn2, τ2, CFF2, title="3D Mohr Circle all Faults")
plot(p1,p2, layout=(2,1), size=(700,700))
```
 <img src="Geomechanics_EQ4.PNG"><br>

## References

Zoback, Mark D.. Reservoir Geomechanics. Cambridge University Press, 2014.
Zoback, M. D., & Kohli, A. H. (2019). Unconventional reservoir geomechanics shale gas, tight oil and induced seismicity. Cambridge University Press.
