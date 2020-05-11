import pandas as pd
def conjecture(n, set):
    """
    Verify conjecture for a given integer n. \n
    Loops through all elements in set se, returns the first element of the set p for which both 6*n-p and 6*n+p are elements of the set.
    """
    # n*6-p > 0 => n*6 > p
    s = {p for p in set if p < n and n*6 > p in set}
    for p in s:
        if (n*6 - p) in set and (n*6 + p) in set:
            return (p)

f = input("Please enter file reference from root file ./data/ (for example: /odd_prob_sets/odd_prob_set_001.txt')")
minbound = int(input("Please enter lower bound: "))
maxbound = int(input("Please enter higher bound: "))

# s =  {int(line.strip()) for line in open('./data/odd_prob_sets/odd_prob_set_032.txt')}
s =  {int(line.strip()) for line in open('./data/prob_sets/prob_set_085.txt')}

for n in range(minbound,maxbound):
    if conjecture(n,s):
        if n%100 == 0:
            print(n)
    else: 
        print("Failed at rank", n)
        break
print("Finished")
