# Plots related to CPU talks
export cpuwatts, plotvolts, plottransistors, plotfreq

using CairoMakie

noto_sans = assetpath("fonts", "NotoSans-Regular.ttf")
noto_sans_bold = assetpath("fonts", "NotoSans-Bold.ttf")

function cpuwatts()
    fig = Figure(resolution = (1000, 700), font = noto_sans)    
    grid = fig[1:3, 1:3] = GridLayout()

    axtransistors = Axis(grid[1:3, 1], xlabel="billion transistors", ylabel="watt")    
    axvolt = Axis(grid[1:1, 2], xlabel="volt")
    axfreq = Axis(grid[1:3, 3], xlabel="GHz")
    
    # CPU voltage is typically in range 0.5 V to 1.5 Volts
    x = range(0.5, 1.5, length=100)
    y = map(x->30*x^2, x)
    lines!(axvolt, x, y, linewidth=3)

    # M1 Max har about 57 billion transistors and consume 40 watts
    x = range(0, 57, length=100)
    y = 0.7x
    lines!(axtransistors, x, y, linewidth=3)
    
    # Aldter Lake has 5.2 GHz clock frequence. M1 Max has 3.1 GHz
    x = range(0.5, 5.2, length=100)
    y = 12x
    lines!(axfreq, x, y, linewidth=3)
    
    fig
end

function plotvolts()
    fig = Figure(resolution = (1000, 700), font = noto_sans)    

    # CPU voltage is typically in range 0.5 V to 1.5 Volts
    x = range(0.5, 1.5, length=100)
    y = map(x->30*x^2, x)
    lines(fig, x, y, linewidth=3)
    
    fig
end

function plottransistors()
    fig = Figure(resolution = (1000, 700), font = noto_sans)    

    # M1 Max har about 57 billion transistors and consume 40 watts
    x = range(0, 57, length=100)
    y = 0.7x
    lines(fig, x, y, linewidth=3)
    
    # Aldter Lake has 5.2 GHz clock frequence. M1 Max has 3.1 GHz
    x = range(0.5, 5.2, length=100)
    y = 12x
    lines(fig, x, y, linewidth=3)
    
    fig
end

function plotfreq()
    fig = Figure(resolution = (1000, 700), font = noto_sans)    
    
    # Aldter Lake has 5.2 GHz clock frequence. M1 Max has 3.1 GHz
    x = range(0.5, 5.2, length=100)
    y = 12x
    lines(fig, x, y, linewidth=3)
    
    fig
end