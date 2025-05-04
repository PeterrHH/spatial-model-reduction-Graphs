# GraphConstruction.jl
# Add Additional Package runing command:  
# add CSV DataFrames
# add Graphs
using CSV
using DataFrames
using Graphs
using Plots, GraphRecipes
using Karnak
using NetworkLayout
using Colors
using Luxor

filename = "case_studies/stylized_EU/inputs/transmission_lines.csv"
G = SimpleDiGraph(0,0)



# Read the SCSV file
df = CSV.read(filename, DataFrame)


vertex_to_name = Dict{String, Int}()



for (index,row) in enumerate(eachrow(df))
    println("Index: ", index)
    println("From: ", row.from)
    println("To: ", row.to)
    println("Export Capacity: ", row.export_capacity)
    println("Import Capacity: ", row.import_capacity)
    # Graph Building
    # Add Node if not exist already
    # Add Edge betwenn From and TO (Directed), with dsistances as some sort of edge weight


    if !haskey(vertex_to_name, row.from)
        push!(vertex_to_name, (row.from => length(vertex_to_name)+1))
        add_vertices!(G, 1)
        print("ADDING TO VERTEX: $(row.from) at position $(length(vertex_to_name))")
        end
    if !haskey(vertex_to_name, row.to)
        push!(vertex_to_name, (row.to => length(vertex_to_name)+1))
        print("ADDING TO VERTEX: $(row.to) at position $(length(vertex_to_name))")
        add_vertices!(G, 1)
        end
    add_edge!(G, vertex_to_name[row.from], vertex_to_name[row.to])
    add_edge!(G, vertex_to_name[row.to], vertex_to_name[row.from])

    # println("Vertex to name: ", nv(G))
    # print("Num Vertex $(nv(G)) If index exist: $(has_vertex(G, index))")
    println("----------")
end

# Save Graph
savegraph("SimpleGridgraph.lg",G,compress = true)


# Plot graph using GraphReceipes.jl
graphplot(G,curves = false) 
print("TOtal number of vertices: $(nv(G)) total number of edges: $(ne(G))")
println(vertex_to_name)
println("Dict length $(length(vertex_to_name))")