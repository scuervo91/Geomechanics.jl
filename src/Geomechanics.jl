module Geomechanics

using RecipesBase
using Plots
using Colors
using DataFrames

export C, Shmin, Shmax

include("Zobackogram.jl")
include("TriplotRecipe.jl")
include("FaultStress.jl")
include("Mohr3.jl")



end # module
