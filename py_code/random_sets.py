import matplotlib.pyplot as plt
from math import log, fabs, sqrt, pi, ceil, floor
from mpmath import li
from random import choice


def primes(N):
    """Assume n is an integer, generate prime numbers up to N."""
    prime = set()
    for n in range(2, N + 1, 1):
        if all(n % p > 0 for p in prime):
            prime.add(n)
            yield n


def Q(N):
    """Assume N is an integer, bigger than 26, generate Q(x) a random set up to N"""
    q = [2, 3, 4, 5, 8, 10, 13, 16, 19, 23, 26]
    for x in q:
        yield x
    qn0 = 26
    for i in range(12, N, 1):
        a = ceil(ali(i) - (1 / pi) * sqrt(i) * (log(i)) ** (5 / 2))
        if a < qn0:
            a = qn0 + 1
        b = floor(ali(i) + (1 / pi) * sqrt(i) * (log(i)) ** (5 / 2))
        qn1 = choice([k for k in range(a, b + 1, 1)])
        if qn1 <= N:
            qn0 = qn1
            yield qn1
        else:
            break


def sigma(x):
    """Assume x is a real number, return the number of elements in q smaller than x."""
    n = 0
    for i in q:
        if i <= x:
            n += 1
    return n


def Pi(x):
    """Assume x is a real number, return the number of primes smaller than or equal to x."""
    return len(list(primes(x)))


def Li(x):
    """Assume x is a real number, return li(x) - li(2)."""
    return li(x) - li(2)


def ali(x):
    """Return ali(x) such that li(ali(x)) = x."""
    y0, b = 2, 2
    while li(b) <= x:
        b += 10  # to optimize.
    while fabs(li(y0) - x) > 10 ** -9:
        yn = (y0 + b) / 2
        if li(y0) < x < li(yn):
            b = yn
        elif li(yn) <= x <= li(b):
            y0 = yn
        if li(y0) == x:
            return y0
    return y0


bound = 5000
q = Q(bound)
plt.plot([i + 2 for i in range(bound)], [Pi(i+2) for i in range(bound)])
plt.plot([i + 2 for i in range(bound)], [sigma(i+2) for i in range(bound)])
#plt.plot([i + 2 for i in range(bound)], [(i+2)/log(i+2) for i in range(bound)])
plt.plot([i + 2 for i in range(bound)], [li(i+2) - li(2) for i in range(bound)])
plt.savefig("../images/test.pdf")

