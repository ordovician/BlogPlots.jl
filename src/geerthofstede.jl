# Showing stuff like power hierarchies
export plot_power_hierarchy, load_cultural_dim, plot_cultural_dim, plot_all_cultural_dim
using CairoMakie, ColorSchemes, ElectronDisplay, Colors

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
    select!(sample, [:country, :hierarchy, :individualism, :masculinity, :uncertainty, :long_term, :indulgence])
    sort!(sample, [:hierarchy, :individualism])
    
    sample
end

function plot_power_hierarchy()
    # countries = ["Norway", "Sweden", "Denmark", "Netherlands", "Germany", "Great Britain", "China", "Iran", "Greece", "India", "Arab countries"]
    # countries = ["Norway", "Sweden", "Denmark", "Netherlands", "Germany", "China", "Iran", "India", "Arab countries"]
    # countries = ["Sweden", "Denmark", "Netherlands", "China", "Iran", "India", "Arab countries"]
    
    countries = ["Norway", "Denmark", "Germany"]
    df = load_cultural_dim(countries)
    
    plot_cultural_dim(df, :hierarchy)
end

function plot_cultural_dim(df::DataFrame, column::Symbol)
    xs = 1:length(df.country)
    ys = df[!, column]
    
    fig = Figure(resolution = (1024, 600), font = noto_sans)
    ax = Axis(fig[1, 1], xticks = (xs, df.country), ylabel=uppercasefirst(string(column)))
    
    barplot!(ax, xs, ys, color=xs)
    
    fig       
end

"Create legend elements of given colors"
function legend_elements(colors::AbstractArray{<:Color})
    elements = [PolyElement(polycolor = color) for color in colors]    
end

function plot_all_cultural_dim()
    countries = ["Norway", "Denmark", "Netherlands", "Germany"]
    df = load_cultural_dim(countries)
    plot_all_cultural_dim(df) 
end

function plot_all_cultural_dim(df::DataFrame)
    ncountries = nrow(df)
    # Will interpolate between these 4 colors to create enough colors for ncountries
    colors = get(ColorSchemes.Spectral_4, 1:ncountries, (1, ncountries))

    #culturaldim = ["hierarchy", "individualism", "masculinity", "uncertainty"]
    culturaldim = ["hierarchy", "individualism", "masculinity"]
    
    xs    = repeat(1:length(culturaldim), inner=ncountries)
    order = repeat(1:ncountries, length(culturaldim))
    #ys    = vcat(df.hierarchy, df.individualism, df.masculinity, df.uncertainty)
    ys    = vcat(df.hierarchy, df.individualism, df.masculinity)
     
    fig = Figure(resolution = (1120, 630), font = noto_sans)
    ax = Axis(fig[1, 1], 
            xticks = (unique(xs), culturaldim))
    
    barplot!(ax, xs, ys,
        strokewidth=1,
        color = colors[order],
        dodge = order)
        
    elements = legend_elements(colors)
    title = "Countries"

    Legend(fig[1,2], elements, df.country, title) 
        
    fig  
end