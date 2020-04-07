import matplotlib.pyplot as plt
from math import log, fabs, sqrt, pi, ceil, floor
from mpmath import li, findroot
from random import choice


def primes(N):
    """Assume n is an integer, generate prime numbers up to N."""
    prime = set()
    for n in range(2, N + 1, 1):
        if all(n % p > 0 for p in prime):
            prime.add(n)
            yield n

def g(n):
    """Part of code often used in other functions."""
    return (1 / pi) * sqrt(n) * (log(n))**(5/2)


def Q(N):
    """Assume N is an integer, bigger than 26, generate Q(x) a random set up to N"""
    q = [2, 3, 4, 5, 8, 10, 13, 16, 19, 23, 26]
    for x in q:
        yield x
    qn0 = 26
    for i in range(11, N, 1):
        a = ceil(ali(i) - g(i))
        if a < qn0:
            a = qn0 + 1
        b = floor(ali(i) + g(i))
        qn1 = choice([k for k in range(a, b+1, 1)])
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
    return findroot(lambda y: li(y) - x, - 7).real

def test1():
    """Test whether sigma(x) ~ x/log(x). 
    Return a list which contains sigma(x) such that bound-9 <= x <= bound."""
    values = []
    for i in range(-9, 1, 1):
        values.append(sigma(bound+i)/((bound+i)/log(bound+i)))
    return values

def f(x):
    return sigma(x)/(x/log(x))

bound = 10**4
q = list(Q(bound))

x = [i for i in range(100, 10**4+1, 100)]
y = [f(i) for i in x]
size = 100*[1]

plt.scatter(x, y, s=size)

plt.title("sigma(x)/(x/log(x))")
plt.xlabel('x')
plt.ylabel('y')

plt.savefig('images/test1.pdf')

