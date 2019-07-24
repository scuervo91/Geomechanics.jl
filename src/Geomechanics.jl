module Geomechanics

using RecipesBase
using Plots
using Colors
using DataFrames

export C, Shmin, Shmax, FaultStress

include("Zobackogram.jl")
include("TriplotRecipe.jl")
include("FaultStress.jl")
include("Mohr3.jl")



end # module
