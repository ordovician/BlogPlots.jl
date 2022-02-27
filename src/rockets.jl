using CairoMakie, ColorSchemes

export plot_neutron_falcon_stats, plot_mass_stats, plot_other_stats, plot_rocket_specs

noto_sans = assetpath("fonts", "NotoSans-Regular.ttf")
noto_sans_bold = assetpath("fonts", "NotoSans-Bold.ttf")

function plot_neutron_falcon_stats()
    colors = Makie.wong_colors()
    
    fig = Figure(resolution = (1000, 700), font = noto_sans)    
    grid = fig[1:3, 1:3] = GridLayout()
    
    heightaxis = Axis(grid[1:3, 1], 
                      xticks = (1:3, ["Falcon 9", "Falcon 9 v1.0", "Neutron"]),
                      ylabel = "meters")
            
    # position of each bar along x-axis
    # repeated x values means several bars are placed in the same position 
    xs =    [1, 1, 1, 2, 2, 2, 3, 3, 3]
    
    # indicate order for y-values placed on the same x-axis location.
    group = [1, 2, 3, 1, 2, 3, 1, 2, 3]
    
    # y-axis value for each bar
    heights = [70, 3.7, 5.2,  47.8, 3.7, 5.2, 40, 7, 5]       
    barplot!(
        heightaxis,
        xs, heights,
        dodge = group, # cluster bars per property
        color = colors[group])

    labels = ["Height", "Diameter", "Fairing Diameter"]
    elements = [PolyElement(polycolor = colors[i]) for i in 1:length(labels)]
    Legend(grid[1, 2], elements, labels)
    fig
end

function plot_mass_stats()
    colors = Makie.wong_colors()
    
    fig = Figure(resolution = (1000, 700), font = noto_sans)    
    grid = fig[1:3, 1:3] = GridLayout()
    
    massaxis = Axis(grid[1:3, 1], 
                      xticks = (1:3, ["Falcon 9", "Falcon 9 v1.0", "Neutron"]),
                      ylabel = "tonne")
            
    # position of each bar along x-axis
    # the max value is 3, which suggests the x-axis goes from 1 - 3
    # the same x-value is repeated twice, which means two y-values get
    # placed on the same location at every x-value
    xs =    [1, 1, 2, 2, 3, 3]
    
    # assigning each bar to a group. 
    group = [1, 2, 1, 2, 1, 2]
    
    # y-axis value for each bar
    masses = [549, 22.8, 333, 9, 480, 15]       
    barplot!(
        massaxis,
        xs, masses,
        dodge = group, # cluster bars per property
        color = colors[group])

    labels = ["Mass", "Payload (LEO)"]
    elements = [PolyElement(polycolor = colors[i]) for i in 1:length(labels)]
    Legend(grid[1, 2], elements, labels)
    fig                           
end


function plot_other_stats()
    fig = Figure(resolution = (1000, 700), font = noto_sans)    
    grid = fig[1:3, 1:3] = GridLayout()
    
    # massaxis = Axis(grid[1:3, 1],
    #                   xticks = (1:3, ["Falcon 9", "Falcon 9 v1.0", "Neutron"]),
    #                   ylabel = "Mass (tonne)")
    #
    # payloadaxis = Axis(grid[1:3, 1],
    #                 xticks = (1:3, ["Falcon 9", "Falcon 9 v1.0", "Neutron"]),
    #                 ylabel = "Payload (tonne)")
    #
    # masses = [549, 333, 480]
    #
    # barplot!(
    #     massaxis,
    #     xs, masses,
    #     dodge = group, # cluster bars per property
    #     color = colors[group])                    
end

function plot_rocket_specs()
    # Picked from catalog: https://juliagraphics.github.io/ColorSchemes.jl/stable/catalogue/
    colors = ColorSchemes.Spectral_4.colors
    
    df = load_rocket_specs()
    fig = Figure(resolution = (1024, 1024), font = noto_sans)
    
    cols = [:height, :diameter, :fairing, :mass, :payload, :thrust, :Isp]
    units = ["meter", "meter", "meter", "tonne", "tonne", "kilo Newton", "Secons"]
    
    # column position in grid for plot for a given index
    colpos = [1, 1, 1,  # meters
              2, 2,     # tonnes
              3, 3]
    rowpos = [1, 2, 3,
              1, 2,
              1, 2]
    
    rows = nrow(df)
    for (i, col) in enumerate(cols)
        ax = Axis(fig[colpos[i], rowpos[i]], 
                  ylabel = units[i],    # label along y-axis
                  title = string(col), 
                  xticks = 0:0          # num of tick marks and their spacing
             )
        # hidedecorations!(ax)
        # hidespines!(ax)
        barplot!(ax, 1:rows, df[:, col], 
            color=colors[1:rows],
            # color_over_bar=:white,
            # label_size=12,
            # flip_labels_at=0,
            # font=noto_sans_bold,
            # bar_labels=:y
        )
    end
    for i in 1:3
        colsize!(fig.layout, i, Relative(1/3))
    end
    elements = polyelement.(colors[1:rows])
    Legend(fig[2, 3], elements, df[:, :rocket])
    
    fig
end