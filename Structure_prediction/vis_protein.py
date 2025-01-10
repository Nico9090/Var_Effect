import nglview as nv
from Bio import PDB

# Load your protein structure (for example, from a PDB file)
pdb_file = "C:/Users/teemo/Downloads/fibrocystin_and_L_models/human_fc_parts/hfbr_1_to_500.pdb"

# Create a PDB parser to load the file
parser = PDB.PDBParser(QUIET=True)
structure = parser.get_structure("protein", pdb_file)

# Visualize the protein using nglview
view = nv.show_biopython(structure)
view