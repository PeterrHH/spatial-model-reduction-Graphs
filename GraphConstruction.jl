# GraphConstruction.jl
# Add Additional Package runing command:  
# add CSV DataFrames
# add Graphs
using CSV
using DataFrames
using Graphs

filename = "case_studies/stylized_EU/inputs/transmission_lines.csv"
G = SimpleDiGraph(0,0)



# Read the SCSV file
df = CSV.read(filename, DataFrame)
print(df)
for row in eachrow(df)
    println("From: ", row.from)
    println("To: ", row.to)
    println("Export Capacity: ", row.export_capacity)
    println("Import Capacity: ", row.import_capacity)
    println("----------")

    # Graph Building
    
end