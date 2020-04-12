import pandas as pd
import doctest

def unwrap_set(csv):
    """ Import a csv formatted as follow: first column is the list of integerers; \t other columns contain boolean values. \n
    Then generate a list of sets 
    """

    # import csv as data frame
    df = pd.read_csv(csv)
    # Generate an empty list
    samples = []

    # loops through all columns from column 2 (first random set)
    for i in range(2,len(df.columns)):
        # the following returns a set of all integers having "True" value in corresponding column.
        samples.append(set(df.iloc[:,1][df.iloc[:,i]==True]))
    
    return samples

################## TEST CODE ##################

if __name__ == "__main__":
    S = unwrap_set("samples.csv") # create 
    print(len(S))
    # print(samples[1])
    sample1 = S[1]
    print([i for i in sample1 if i <= 33]) # prints list of elements in first sample, less than 33
    print(len([i for i in sample1 if i <= 33])) # counts elements in fist sample, less than 33