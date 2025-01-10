#!/usr/bin/env python3
def parse_coord(pdb):
    '''Parse pdb file to access atom coordinates by residue '''
    with open(pdb,"r")as pdb_file:
        x,y,z={line[:4].strip()+line[5:12].strip():float(line[32:39].strip()) for line in pdb_file if line.startswith("ATOM")
               },{line[:4].strip()+line[5:12].strip():float(line[41:47].strip()) for line in pdb_file if line.startswith("ATOM")
                            	},{line[:4].strip()+line[5:12].strip():float(line[49:55].strip())for line in pdb_file if line.startswith("ATOM")}
    return x,y,z

