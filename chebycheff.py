# import libraries
import matplotlib.pyplot as plt
import numpy as np
import math


# f(x) as a scalar function
def f(x):
    return 1/(1+(x**2))

# f(x) as a vector function
def f_vec(x):
    f = []
    for j in x:
        f.append(1/(1+(j**2)))
    return f

# approximates the maximum error by sampling the error at 10,000 evenly spaced points
def max_error(p):
    max = 0
    x = -5
    for i in p:
        error = abs(i - f(x))
        max = error if error > max else max
        x += 0.001
    return max


# MAIN
x = np.arange(-5.0, 5.0, 0.001)
y = f(x)

fig, ax = plt.subplots()

x_vec = []
# for n in range(20,21):
for n in range(1,21): # plot p(x) for n: 1-20
    # if (n%10 != 0): continue
    h = 10/n
    for j in range(n+1):
        x_vec.append(5 * math.cos((j*math.pi)/n))
    p_coef = np.polyfit(x_vec, f_vec(x_vec), n) # least squares polynomial fit
    p_vals = np.polyval(p_coef, x)              # evaluates polynomial p
    x_vec.clear()

    # print max error
    print('maximum error at n: {} is {}'.format(n, max_error(p_vals)))
    ax.plot(x, p_vals, label='p(x), n: {}'.format(n))

# plot f(x)
ax.plot(x, y, color='black', label='f(x)')

# format ax
ax.set(xlabel='x', ylabel='f(x)', title='Runge-Phenomenon w/ Chebycheff roots')
# ax.legend()
ax.grid()

# format px
plt.xlim([-5.2,5.2])
plt.ylim([-0.1,1.5])
plt.xticks(np.arange(-5, 6, 1))
plt.show()
