using CairoMakie, Colors, CSV, DataFrames

export polyelement, datadir, load_rocket_specs

const datadir = normpath(joinpath(@__DIR__, "../data"))

"""
    polyelement(cl::Color) -> PolyElement

This is useful to create legends. 

    fig = Figure(resolution = (800, 600))
    elements = polyelement.(colors)
    Legend(fig[row, col], elements, labels, title)
    
Make sure that the elements match up with the labels.
This must be true `length(elements) == length(labels)`.
"""
function polyelement(color::Color)
    PolyElement(polycolor = color)
end

function load_rocket_specs()
    path = joinpath(datadir, "rocket-specifications-2021.csv")
    rocketspecs = CSV.File(path) |> DataFrame
end