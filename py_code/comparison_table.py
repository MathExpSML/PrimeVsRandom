import pandas as pd
import os
primes = set()
for i in range(2, 100000):
  if all(i % p > 0 for p in primes):
      primes.add(i)

df = pd.DataFrame(columns=["set","up to","interesect","perc"])

sets = [f for f in os.listdir('./data/odd_prob_sets') if f.endswith('.txt')]

bound = 1000000
for s in sets:
    rs = {int(line.strip()) for line in open('./data/odd_prob_sets/' + s) if int(line.strip()) <= bound}
    intersect = len(rs.intersection(primes))
    intersect_perc = len(rs.intersection(primes)) / len(rs)
    dfToAppend = pd.DataFrame([[s, bound,intersect,intersect_perc]],columns=["set","up to","intersect","perc"])
    df = df.append(dfToAppend)  

print(df)