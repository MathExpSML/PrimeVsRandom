# Conjecture 2.8
# For any integer n > 8 we can write 2n-1 as p+2q with
# p, q, p^2 + 60q^2 all primes

def assertion(n,set):
    #s = {p for p in set if p < n and n*6 > p in set}
    P = {p for p in set if p <= n}
    Q = {q for q in set if 2*q <= n}
    T = []
    for p in P:
        for q in Q:
            if (p**2 + 60*q**2) in set:
                T += (p,q)
    for s in S:
        if 2*n - 1 == s[1] + 2*s[2]

