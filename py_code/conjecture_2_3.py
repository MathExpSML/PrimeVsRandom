import pandas as pd

primes = set()
for i in range(2, 100000):
  if all(i % p > 0 for p in primes):
      primes.add(i)


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
            return (n, p)

def tryForSet(set, bound, setname):
    """
    Try conjecture for a given set up to a certain bound. \n 
    setname is a string which will be used for the output report. \n
    Output is a dataframe with setname, number of successes and failures, maximum element for which conjecture was not verified and success rate for the set
    """
    success, failure, maxFail = 0,0,0
    for x in range(6,bound):
        if conjecture(x, set):
            success += 1    # Increment success count if output is non null
        else:
            failure += 1    # Increment failure count if output is nul
            maxFail = x     # then sets maxFail to last unverified element.
    print("Set: ", setname, \
        ", success: ", success, \
        ", failure:", failure, \
        ", maxFail:", maxFail, \
        ", success rate: ", round(success/(failure+success)*100,2),"%", \
        sep = "")
    return pd.DataFrame([[setname, success, failure, maxFail]],columns=["set","succes","failures","maxFail"])

# tryForSet(primes,100,"primes")

import os
bound = 10000


# files = [f for f in os.listdir('./data/prob_sets') if f.endswith('.txt')]

# for f in files:
#     s = {int(line.strip()) for line in open('./data/prob_sets/' + f)}
#     df = df.append(tryForSet(s,1000,f))
# df.to_csv('./data/conjecture_2_3.csv')

files = [f for f in os.listdir('./data/odd_prob_sets') if f.endswith('.txt')]

def record_output(folder,bound,output):
    """
    Takes a folder containing sets as an input, generates a csv report up to a given bound
    """
    df = pd.DataFrame(columns=["set","succes","failures","maxFail"])
    df = df.append(tryForSet(primes,bound,"primes"))
    files = [f for f in os.listdir(folder) if f.endswith('.txt')]
    for f in files:
        s = {int(line.strip()) for line in open(folder + f)}
        df = df.append(tryForSet(s,bound,f))
        df.to_csv('./data/' + output + ".csv")

# record_output('./data/odd_prob_sets/',10000,'conjecture_2_3_odd_10k')
record_output('./data/prob_sets/',10000,'conjecture_2_3_10k')

# for f in files:
#     s = {int(line.strip()) for line in open('./data/odd_prob_sets/' + f)}
#     df = df.append(tryForSet(s,bound,f))
#     df.to_csv('./data/conjecture_2_3_odd_10k.csv')

# files = [f for f in os.listdir('./data/odd_prob_sets') if f.endswith('.txt')]

# for f in files:
#     s = {int(line.strip()) for line in open('./data/odd_prob_sets/' + f)}
#     df = df.append(tryForSet(s,bound,f))
#     df.to_csv('./data/conjecture_2_3_odd_10k.csv')

