import matplotlib.pyplot as plt
import approche_analytique as analytic

def count_twins(N, ens):
    """Fonction qui compte le nombre de nombres jumeaux inférieurs à x dans set."""
    k = 0
    for i in range(len(ens)-1):
        if ens[i+1] < N:
            if ens[i]+2 == ens[i+1]:
                k += 1
        else:
            break
    return k

def twin_primes(N):
    """Fonction qui renvoit un graphe de fonctions qui comptent le nombre
    de nombres jumeaux inférieur à x."""
    x = [i for i in range(10, N+1, 10)]
    path_q_odd = "/Users/maximerubio/Documents/uni/S2/EML/PrimeVsRandom/data/odd_analytic_sets/analytique_odd_set"
    path_q = "/Users/maximerubio/Documents/uni/S2/EML/PrimeVsRandom/data/analytic_sets/analytique_set_"
    path_v_odd = "/Users/maximerubio/Documents/uni/S2/EML/PrimeVsRandom/data/odd_prob_sets/odd_prob_set_"
    path_v = "/Users/maximerubio/Documents/uni/S2/EML/PrimeVsRandom/data/prob_sets/prob_set_"
    p = analytic.get_set(N, "/Users/maximerubio/Documents/uni/S2/EML/PrimeVsRandom/data/set_primes.txt")
    y1 = [count_twins(i, p) for i in x]
    g1, = plt.plot(x, y1)
    for j in range(1, 6, 1):
        q = analytic.get_set(N, path_q + str(j) + ".txt")
        q_odd = analytic.get_set(N, path_q_odd + str(j) + ".txt")
        v = analytic.get_set(N, path_v + str(0) + str(0) + str(j) + ".txt")
        v_odd = analytic.get_set(N, path_v_odd + str(0) + str(0) + str(j) + ".txt")
        y2 = [count_twins(i, q) for i in x]
        y2_odd = [count_twins(i, q_odd) for i in x]
        y3 = [count_twins(i, v) for i in x]
        y3_odd = [count_twins(i, v_odd) for i in x]
        if j == 1:
            g2, = plt.plot(x, y2, "blue")
            g2_odd, = plt.plot(x, y2_odd, "lightblue")
            g3, = plt.plot(x, y3, "red")
            g3_odd, = plt.plot(x, y3_odd, "orange")
        else:
            plt.plot(x, y2, "blue")
            plt.plot(x, y2_odd, "cyan")
            plt.plot(x, y3, "red")
            plt.plot(x, y3_odd, "orange")
    plt.legend([g1, g2, g2_odd, g3, g3_odd], ['twins in primes', 'twins in Q', 'twins in Q(odd)', 'twins in R', 'twins in R(odd)'])
    plt.title("Twins")
    plt.xlabel('x')
    plt.savefig('images/twins.pdf')

N = 10**6 
twin_primes(N)