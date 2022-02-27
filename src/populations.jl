# Plots related to CPU talks
export ancient, ironproduction, usa_advantage

using CairoMakie, ElectronDisplay

noto_sans = assetpath("fonts", "NotoSans-Regular.ttf")
noto_sans_bold = assetpath("fonts", "NotoSans-Bold.ttf")

# Sources for numbers:
# Japan: https://en.wikipedia.org/wiki/Demographic_history_of_Japan_before_the_Meiji_Restoration
# Sub-saharan Africa: 
# Greece https://en.wikipedia.org/wiki/Demographic_history_of_Greece
# Greece https://www.cs.mcgill.ca/~rwest/wikispeedia/wpcd/wp/a/Ancient_Greece.htm
# Egypt https://brewminate.com/estimating-population-in-ancient-egypt/
function ancient()
    fig = Figure(resolution = (800, 800), font = noto_sans)
    
    # Population around 500 BC
    # Africa here is sub-Saharan Africa
    # Greece with all colonies estimated to 8-10 million so I set it at 9 million    
    populations = Dict("Greece"=>9, "Persia"=>17, "India"=>35, "China"=>43, "Africa"=>7, "Japan"=>0.1, "Egypt" => 5)
    countries = ["Greece", "Japan", "Africa", "Egypt"]
    
    xs = 1:length(countries)
    ys = [populations[country] for country in countries]
    axis = Axis(fig[1,1],
                 xticks = (xs, countries),
                 ylabel = "millions",
                 title = "Population (500 BC)")
    
    ylims!(axis, (0, 10))
    
    barplot!(axis, xs, ys, 
        color=xs,           # Colors picked from the color table for each bar
        bar_labels=:y,      # Put value labels on top of each bar
        width = 0.7         # Width of each of the bars in relation to xs values
    )
    
    fig                     # barplot! does not return something we can show
end

function ironproduction()
    fig = Figure(resolution = (1024, 600), font = noto_sans)

    # Source for iron production https://www.statista.com/statistics/1071007/iron-ore-production-europe-1900-1945-country/
    # Numbers given in million metric tons
    ironprod = Dict("USA"=> 28.0, "Germany"=>12.7, "France"=>5.5, "UK"=>14.2, "Sweden"=>2.6, "Soviet"=>6.0, "Luxembourg"=>6.1)
    countries = ["Germany", "UK", "France", "USA"]
    
    xs = 1:length(countries)
    ys = [ironprod[country] for country in countries]
    
    axis = Axis(fig[1,1],
                 xticks = (xs, countries),
                 ylabel = "million metric tons",
                 title = "Iron ore production (1900)")
    
    ylims!(axis, (0, 30))

    
    barplot!(axis, xs, ys, 
        color=xs,          # Colors picked from the color table for each bar
        bar_labels=:y,     # Put value labels on top of each bar
        width = 0.7        # Width of each of the bars in relation to xs values
    )
                              
    return fig
end

function usa_advantage()
    fig = Figure(resolution = (1024, 600), font = noto_sans)

    # Based on data written at the end of article: https://medium.com/p/9a76c1a12456/edit
    ratios = Dict("agriculture"=> 6, "coal"=>5.5, "hydropower"=>2.3, "oil"=>150)
    resources = ["agriculture", "coal", "hydropower"]
    
    xs = 1:length(resources)
    ys = [ratios[r] for r in resources]
    
    axis = Axis(fig[1,1],
                 xticks = (xs, resources),
                 ylabel = "Ratio",
                 title = "American resources advantage relative to Europe")
    
    ylims!(axis, (0, 6.5))

    
    barplot!(axis, xs, ys, 
        color=xs,          # Colors picked from the color table for each bar
        bar_labels=:y,     # Put value labels on top of each bar
        width = 0.7        # Width of each of the bars in relation to xs values
    )
                              
    fig    
end

function usa_marketsize()
    
end

# display(ancient())