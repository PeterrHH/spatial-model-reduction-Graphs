import pandas as pd
import networkx as nx
import matplotlib.pyplot as plt
import argparse

# Argument parser setup
parser = argparse.ArgumentParser(description="Construct a graph from transmission line CSV.")
parser.add_argument('--EdgeWeight', type=bool, default=True, help='Use edge weights (default: True)')
args = parser.parse_args()

# File path
filename = "case_studies/stylized_EU/inputs/transmission_lines.csv"

# Read CSV
df = pd.read_csv(filename)

# Create a directed graph
G = nx.DiGraph()

# Map from name to node ID
vertex_to_name = {}

# Build the graph
for index, row in df.iterrows():
    print(f"Index: {index}")
    print(f"From: {row['from']}")
    print(f"To: {row['to']}")
    print(f"Export Capacity: {row['export_capacity']}")
    print(f"Import Capacity: {row['import_capacity']}")

    # Add vertices if not already added
    if row['from'] not in vertex_to_name:
        node_id = len(vertex_to_name) + 1
        vertex_to_name[row['from']] = node_id
        G.add_node(node_id)
        print(f"ADDING TO VERTEX: {row['from']} at position {node_id}")

    if row['to'] not in vertex_to_name:
        node_id = len(vertex_to_name) + 1
        vertex_to_name[row['to']] = node_id
        G.add_node(node_id)
        print(f"ADDING TO VERTEX: {row['to']} at position {node_id}")

    from_id = vertex_to_name[row['from']]
    to_id = vertex_to_name[row['to']]

    if args.EdgeWeight:
        G.add_edge(from_id, to_id, capacity=row['export_capacity'])
        G.add_edge(to_id, from_id, capacity=row['import_capacity'])
    else:
        G.add_edge(from_id, to_id)
        G.add_edge(to_id, from_id)

    print("----------")

# Save the graph
nx.write_graphml(G, "SImpleGridGraph.graphml")
print(vertex_to_name)

# Plotting
plt.figure(figsize=(10, 8))
nx.draw_networkx(G, with_labels=True, node_color='lightblue', edge_color='gray')
plt.title(f"Graph with {G.number_of_nodes()} nodes and {G.number_of_edges()} edges")
plt.axis('off')
plt.show()

'''
Run without Edge Weight, Defual is True
python graph_construction.py --EdgeWeight False
'''



