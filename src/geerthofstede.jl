# Showing stuff like power hierarchies
export plot_power_hierarchy, load_cultural_dim, plot_cultural_dim
using CairoMakie, ElectronDisplay

noto_sans = assetpath("fonts", "NotoSans-Regular.ttf")
noto_sans_bold = assetpath("fonts", "NotoSans-Bold.ttf")


function load_cultural_dim(countries::AbstractVector)
    path = joinpath(datadir, "geerthofstede-2015-08-16.csv")
    cultural = CSV.File(path) |> DataFrame
    cultures = select(cultural, :country,
               :pdi => :hierarchy,
               :idv => :individualism,
               :mas => :masculinity,
               :uai => :uncertainty,
               :ltowvs => :long_term,
               :ivr => :indulgence)
               
    selectedcountries = DataFrame(country=countries)
    sample = innerjoin(cultures, selectedcountries, on = :country)
    select!(sample, [:country, :hierarchy, :individualism])
    sort!(sample, [:hierarchy, :individualism])
    
    sample
end

function plot_power_hierarchy()
    countries = ["Norway", "Sweden", "Denmark", "China", "Iran", "Greece", "Netherlands", "India", "Arab countries"]
    sample = load_cultural_dim(countries)
    
    plot_cultural_dim(sample, :hierarchy)
end

function plot_cultural_dim(df::DataFrame, column::Symbol)
    xs = 1:length(df.country)
    ys = df[!, column]
    
    fig = Figure(resolution = (1024, 600), font = noto_sans)
    ax = Axis(fig[1, 1], xticks = (xs, df.country), ylabel=uppercasefirst(string(column)))
    
    barplot!(ax, xs, ys, color=xs)
    
    fig       
end