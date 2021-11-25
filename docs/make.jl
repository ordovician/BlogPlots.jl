using BlogPlots
using Documenter

DocMeta.setdocmeta!(BlogPlots, :DocTestSetup, :(using BlogPlots); recursive=true)

makedocs(;
    modules=[BlogPlots],
    authors="Erik Engheim <erik.engheim@mac.com> and contributors",
    repo="https://github.com/ordovician/BlogPlots.jl/blob/{commit}{path}#{line}",
    sitename="BlogPlots.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)
