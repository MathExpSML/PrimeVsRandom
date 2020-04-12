import pandas as pd
import doctest

def wrap_csv(list_of_set, bound, filename, path="data/"):
    """
    Takes a csv based on on a list of list or list of sets, up to a certain bound. 
    The filename needs to be provided, the path is set as "data" by default
    """
    df = pd.DataFrame([i for i in range(2,bound+1)])
    colname = ['x']
    samp_id = 1
    for s in list_of_set:
        bool_vect = []
        for n in range(2,bound+1):
            bool_vect.append(n in s)
        df = pd.concat([df,pd.DataFrame(bool_vect)],axis=1)
        colname.append("sample"+str(samp_id)); samp_id+=1
    df.columns = colname
    df.to_csv(path+filename,index=False)

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
    S = unwrap_set("data\prob_samples-2020-04-12.csv") # create 
    print(len(S))
    # print(samples[1])
    sample1 = S[1]
    print([i for i in sample1 if i <= 33]) # prints list of elements in first sample, less than 33
    print(len([i for i in sample1 if i <= 33])) # counts elements in fist sample, less than 33
    wrap_csv(S,100000,"samp.csv")