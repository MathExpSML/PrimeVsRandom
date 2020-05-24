import pandas as pd
def conjecture(n, set):
    """
    Verify conjecture for a given integer n. \n
    Loops through all elements in set se, returns the first element of the set p for which both 6*n-p and 6*n+p are elements of the set.
    """
    # n*6-p > 0 => n*6 > p
    s = {p for p in set if p < n}
    for p in s:
        if (n*6 - p) in set and (n*6 + p) in set:
            return (p)

minbound = int(input("Please enter lower bound: ")) # initial value for which assertion will by test
maxbound = int(input("Please enter higher bound: ")) # last value for which assertion will by tested

# Select a set here
s =  {int(line.strip()) for line in open('./data/odd_prob_sets/odd_prob_set_032.txt')}

# Loop through all integers between minbound and maxbound
# fails as soon as the assertion is not verified.
for n in range(minbound,maxbound):
    p = conjecture(n,s)
    if p:
            print(n,p)
    else: 
        print("Failed at rank", n)
        break
print("Finished")
