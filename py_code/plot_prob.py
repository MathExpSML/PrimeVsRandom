from wraps import unwrap_set
import matplotlib.pyplot as plt

# import latest data set for random samples
sets = unwrap_set("data\prob_samples-2020-04-12.csv")

# Manually inserted bound 
bound = 100000

# Generate list of all natural numbers up to bound
x = range(1,bound)

#Generate an empty list to store data
im = []

#The following function appends the list with image vector
for s in sets:
    cnt = []    # Empty list, will y coordinates for plot
    t = 0       # Count of integers lower than
    # Loop through all integers up to bound
    for n in x:
        if n in s:
            t += 1      # increment count of integers if n belongs in random sample
        cnt.append(t)   # append vector for each n
    im.append(cnt)      # append image list with image vector

# loop through image list and generate a curve for each sample
for i in im:
    plt.plot(x,i, alpha = .4)

# display plot
plt.show()