import pandas as pd

def conjecture(n, set):
    """
    Verify conjecture for a given integer n. \n
    Loops through all elements in set se, returns a tupple (n,p) where: \n
    \t - n is the inputed number
    \t - p is the minimum element of the set for which both (6n-p) and (6n+p) are elements of the set
    """
    # n*6-p > 0 => n*6 > p
    s = {p for p in set if p < n and n*6 > p in set}
    for p in s:
        if (n*6 - p) in set and (n*6 + p) in set:
            return p

def tryForSet(set, bound, setname):
    """
    Try conjecture for a given set up to a certain bound. \n
    setname is a string which will be used for the output report. \n
    Output is a dataframe with setname, number of successes and failures, maximum element for which conjecture was not verified and success rate for the set
    """
    global df
    print("Trying set: ", setname)
    for x in range(6,bound):
        p = conjecture(x, set)
        if p:
            if x*6-p not in set or x*6+p not in set:
                print("Error for", x, p) 
                exit
        else: 
            # print("Set", setname, "failed for n=",x)
            df = df.append(pd.DataFrame([[setname,x]], columns=["set","failedInt"]))
        

folder = './data/'
import os
df = pd.DataFrame(columns=["set","failedInt"])

# for subfolder in [subfolder for subfolder in os.listdir(folder) if "set" in subfolder]:
#     for f in [f for f in os.listdir(folder + "/" + subfolder) if f.endswith('.txt')]:
#         set = {int(line.strip()) for line in open(folder + "/" + subfolder + "/" + f)}
#         tryForSet(set,1000,f)
#     df.to_csv('./data/failure_mapping.csv')

for subfolder in [subfolder for subfolder in os.listdir(folder) if "set" in subfolder]:
    for f in [f for f in os.listdir(folder + "/" + subfolder) if f.endswith('.txt')]:
        set = {int(line.strip()) for line in open(folder + "/" + subfolder + "/" + f)}
        tryForSet(set,10000,f)
        df.to_csv('./data/failure_mapping_10K_V2.csv')