using Documenter, NNHelferlein

makedocs(modules = [NNHelferlein],
         clean = false,
         assets = ["assets/favicon.ico"],
         sitename = "NNHelferlein.jl",
         authors = "Andreas Dominik",
         pages = [
                  "Introduction" => "index.md",
                  "Examples" => "examples.md",
                  "API" => "api.md",
                  "License" => "license.md"
                  ],
         #          # Use clean URLs, unless built as a "local" build
         #  html_prettyurls = !("local" in ARGS),
          html_canonical = "https://andreasdominik.github.io/NNHelferlein.jl/stable/"
         )
)