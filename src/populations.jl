# Plots related to CPU talks
export cpuwatts, plotvolts, plottransistors, plotfreq

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
    fig = Figure(resolution = (1024, 768), font = noto_sans)
    
    # Population around 500 BC
    # Africa here is sub-Saharan Africa
    # Greece with all colonies estimated to 8-10 million so I set it at 9 million    
    populations = Dict("Greece"=>9, "Persia"=>17, "India"=>35, "China"=>43, "Africa"=>7, "Japan"=>0.1, "Egypt" => 5)
    barplot!(fig, )
end


# display(ancient())