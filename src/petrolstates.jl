# Oil production and petro states
export total_oil_prod, oil_gdp_of_nordics, per_capita_pumped_oil, oil_percent_gdp, oil_rent
using CairoMakie, ElectronDisplay

noto_sans = assetpath("fonts", "NotoSans-Regular.ttf")
noto_sans_bold = assetpath("fonts", "NotoSans-Bold.ttf")

function oil_gdp_of_nordics()
    petrostates_path = joinpath(datadir, "petro-states-data.csv")
    petrostates = CSV.File(petrostates_path) |> DataFrame
    petrostates.OilGDP = petrostates.GDP .* (petrostates.OilPercent ./ 100)
    
    nordics = ["Norway", "Denmark", "Sweden", "Finland", "Iceland"]
    nordics = DataFrame(Country=nordics)
    nordics = innerjoin(petrostates, nordics, on=:Country)
    
    (sum(nordics.OilGDP) / sum(nordics.GDP)) * 100
end

function oil_percent_gdp()
    petrostates_path = joinpath(datadir, "petro-states-data.csv")
    petrostates = CSV.File(petrostates_path) |> DataFrame
    
    countries = ["Norway", "Nordics", "United States", "Canada", "Russia", "Saudi Arabia"]    
    
    filter!(petrostates) do row
       row.Country in countries 
    end
    
    fig = Figure(resolution = (1024, 600), font = noto_sans)
    xs = 1:nrow(petrostates)
    ys = petrostates.OilPercent
    
    countries = replace(countries, "United States" => "USA")
    ax = Axis(fig[1, 1], 
        xticks = (xs, countries), 
        ylabel="Percent",
        title="GDP based on Oil")
    barplot!(ax, xs, ys, color=xs)
    
    fig
end

function oil_rent()
    petrostates_path = joinpath(datadir, "petro-states-data.csv")
    petrostates = CSV.File(petrostates_path) |> DataFrame
    
    countries = ["Norway", "Kuwait", "Iraq", "UAE", "Saudi Arabia"]    
    
    filter!(petrostates) do row
       row.Country in countries 
    end
    
    fig = Figure(resolution = (1024, 600), font = noto_sans)
    xs = 1:nrow(petrostates)
    ys = petrostates.OilRent
    
    ax = Axis(fig[1, 1], 
        xticks = (xs, countries), 
        ylabel="Percent",
        title="Oil Rent")
    barplot!(ax, xs, ys, color=xs)
    
    fig    
end

# Plot total oil production for various petro states from 1900 to present time
function total_oil_prod()
    oilprod_path = joinpath(datadir, "oil-production-by-country.csv")
    oilprod = CSV.File(oilprod_path) |> DataFrame
    
    petrostates_path = joinpath(datadir, "petro-states-data.csv")

    select!(oilprod, :Entity => :Country, :Year, Symbol("Oil production (TWh)") => :Oil)
    petrostates = CSV.File(petrostates_path) |> DataFrame
    sample = select(petrostates, :Country)
    oilprod = innerjoin(oilprod, sample, on=:Country)
    
    filter!(oilprod) do row
        # row.Year > 2015 &&
        row.Country ∉ ["Finland", "Sweden", "Denmark", "Iceland", "Nordic"]
    end
    
    oilgroups = groupby(oilprod, :Country)
    totaloilprod = combine(oilgroups, :Oil => sum => :Oil)
    

    
    fig = Figure(resolution = (1024, 600), font = noto_sans)
    xs = 1:length(totaloilprod.Country)
    ys = totaloilprod.Oil
    countries = replace(totaloilprod.Country, "United States" => "USA")
    ax = Axis(fig[1, 1], xticks = (xs, countries), ylabel="Oil Prod (TWh)")
    barplot!(ax, xs, ys, color=xs)
    
    fig 
end

function per_capita_pumped_oil()
    oilprod_path = joinpath(datadir, "oil-prod-per-capita.csv")
    oilprod = CSV.File(oilprod_path) |> DataFrame
    
    petrostates_path = joinpath(datadir, "petro-states-data.csv")

    select!(oilprod, :Entity => :Country, :Year, Symbol("Oil production per capita (kWh)") => :Oil)
    petrostates = CSV.File(petrostates_path) |> DataFrame
    sample = select(petrostates, :Country)
    oilprod = innerjoin(oilprod, sample, on=:Country)
    
    endyear = 1989
    
    filter!(oilprod) do row
        row.Year <= endyear &&
        row.Country ∉ ["Finland", "Sweden", "Denmark", "Iceland", "Kuwait", "Saudi Arabia", "Nordic"]
    end
    
    oilgroups = groupby(oilprod, :Country)
    totaloilprod = combine(oilgroups, :Oil => sum => :Oil)

    fig = Figure(resolution = (1024, 600), font = noto_sans)
    xs = 1:length(totaloilprod.Country)
    
    # Get average per capita oil production from 1900 to 1990
    ys = totaloilprod.Oil ./ (endyear - 1900)
    
    countries = replace(totaloilprod.Country, "United States" => "USA")
    ax = Axis(fig[1, 1], 
        xticks = (xs, countries), 
        ylabel="per capita oil production (kWh)",
        title = "Average oil production per capita (1900 to $endyear)")
    barplot!(ax, xs, ys, color=xs)
    
    fig     
end