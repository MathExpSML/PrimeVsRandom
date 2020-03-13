
import matplotlib.pyplot as plt
import math, random

bound = 10000

prime= []
def primes(n):
  for i in range(2, bound+1):
    if all(i % p > 0 for p in prime):
        prime.append(i)
  return prime

def Pi(x):
    """Assume x is a real number, return the number of primes smaller than or equal to x."""
    return len(primes(x))

randomSet = []
for i in range(2,bound+1):
  if random.uniform(0,1) <= 1/math.log(i):
    randomSet.append(i)

def randSet(n):
  return len([i for i in randomSet if i <= n])

plt.plot([i+1 for i in range(bound)],[Pi(i+1) for i in range(bound)])
plt.plot([i+1 for i in range(bound)],[randSet(i+1) for i in range(bound)])
plt.savefig('plot.pdf')
