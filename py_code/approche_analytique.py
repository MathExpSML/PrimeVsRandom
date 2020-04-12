import matplotlib.pyplot as plt
from math import log, fabs, sqrt, pi, ceil, floor
from mpmath import li, findroot
from random import choice


def gen_primes(N):
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


def get_set(N, file_name):
    """Renvoit, sous forme de liste, l'ensemble aléatoire file_name, jusqu'à N."""
    ensemble = []
    of = open(file_name, 'r')
    line = of.readline()
    while line:
        nombre = int(line[:-1])
        if nombre <= N:
            ensemble.append(nombre)
        else:
            break
        line = of.readline()
    return ensemble


def sigma(x):
    a, b = 0, len(q) - 1
    if q[b] <= x:
        return b+1
    while b-a > 1:
        m = (a+b) // 2
        if q[m] == x:
            return m+1
        if q[a] <= x <= q[m]:
            b = m
        elif q[m] <= x <= q[b]:
            a = m
    else:
        return a+1


def Pi(x):
    """Alternative à Pi(x)."""
    a, b = 0, len(p) - 1
    if p[b] <= x:
        return b+1
    while b-a > 1:
        m = (a+b) // 2
        if p[m] == x:
            return m+1
        if p[a] <= x <= p[m]:
            b = m
        elif p[m] <= x <= p[b]:
            a = m
    else:
        return a+1


def Li(x):
    """Assume x is a real number, return li(x) - li(2)."""
    return li(x) - li(2)


def ali(x):
    """Return ali(x) such that li(ali(x)) = x."""
    return findroot(lambda y: li(y) - x, - 7).real

################################################################################

def test1():
    """Test whether sigma(x) ~ x/log(x) by plotting the graph of sigma(x) / (x/(log(x))."""
    x = [i for i in range(100, 10**5+1, 100)]
    y = [sigma(i)/(i/log(i)) for i in x]
    g, = plt.plot(x, y)
    plt.legend([g], ['sigma(x) / (x/(log(x))'])
    plt.title("sigma(x) ~ x/log(x)")
    plt.xlabel('x')
    plt.savefig('images/test1.pdf')

def test2():
    """Test whether sigma(x) ~ Li(x) by plotting the graph of sigma(x) / Li(x)."""
    x = [i for i in range(100, 10**5+1, 100)]
    y = [sigma(i)/Li(i) for i in x]
    g, = plt.plot(x, y)
    plt.legend([g], ['sigma(x) / Li(x)'])
    plt.title("sigma(x) ~ Li(x)")
    plt.xlabel('x')
    plt.savefig('images/test2.pdf')

def graphe():
    """Plot the graph of Li(x), Pi(x), sigma(x), x/log(x)."""
    x = [i for i in range(100, (10**5)+1, 100)]
    y1 = [Li(i) for i in x]
    y2 = [Pi(i) for i in x]
    y3 = [sigma(i) for i in x]
    y4 = [i/log(i) for i in x]
    g1, = plt.plot(x, y1)
    g2, = plt.plot(x, y2)
    g3, = plt.plot(x, y3)
    g4, = plt.plot(x, y4)
    plt.legend([g1, g2, g3, g4], ['Li(x)', 'pi(x)', 'sigma(x)', 'x/log(x)'])
    plt.title("Random Sets")
    plt.xlabel('x')
    plt.savefig('images/analytic_approach_sets.pdf')

def ecarts():
    """Plot the graph of Pi(x)/sigma(x)."""
    x = [i for i in range(10**4, (10**7)+1, 10**4)]
    y = [Pi(i)/sigma(i) for i in x]
    g, = plt.plot(x, y)
    plt.legend([g], "pi(x)/sigma(x)")
    plt.title("pi(x) ~ sigma(x)")
    plt.xlabel('x')
    plt.savefig('images/ecarts.pdf')