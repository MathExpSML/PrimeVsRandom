import matplotlib.pyplot as plt
from math import log, fabs, sqrt, pi, ceil, floor
from mpmath import li, findroot
from random import choice, uniform


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
        else:
            break
    return n


def Pi(x):
    """Assume x is a real number, return the number of primes smaller than or equal to x."""
    n = 0
    for i in p:
        if i <= x:
            n += 1
        else:
            break
    return n


def Li(x):
    """Assume x is a real number, return li(x) - li(2)."""
    return li(x) - li(2)


def ali(x):
    """Return ali(x) such that li(ali(x)) = x."""
    return findroot(lambda y: li(y) - x, - 7).real

def V(N):
    """"Créé un ensemble aléatoire en utilisant l'approche probabiliste."""
    randomSet = []
    for i in range(2,N+1):
        if uniform(0,1) <= 1/log(i):
            randomSet.append(i)
    return randomSet

def rho(x):
    """"Renvoit le nombre d'éléments inférieurs à x dans un ensemble V."""
    return len(v)

def count_twins(x, set):
    """Fonction qui compte le nombre de nombres jumeaux inférieurs à x dans set."""
    k = 0
    for i in range(len(set)-1):
        if set[i+1] < x:
            if set[i]+2 == set[i+1]:
                k += 1
        else:
            break
    return k

def twin_primes():
    """Fonction qui renvoit un graphe de fonctions qui comptent le nombre
    de nombres jumeaux inférieur à x."""
    x = [i for i in range(10, (10**3)+1, 10)]
    y1 = [count_twins(i, p) for i in x]
    y2 = [count_twins(i, q) for i in x]
    y3 = [count_twins(i, v) for i in x]
    g1, = plt.plot(x, y1)
    g2, = plt.plot(x, y2)
    g3, = plt.plot(x, y3)
    plt.legend([g1, g2, g3], ['twins in primes', 'twins in Q', 'twins in V'])
    plt.title("Twins")
    plt.xlabel('x')
    plt.savefig('images/twins.pdf')
    

bound = 10**3
p = list(primes(bound))
q = list(Q(bound))
v = V(bound)

twin_primes()