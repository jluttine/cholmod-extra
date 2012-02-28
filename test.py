#!/usr/bin/env/python3

import numpy as np
import scipy.sparse as sp
import scikits.sparse.cholmod as cm

I = sp.identity(5)
L = cm.cholesky(I)
b = np.ones(5)

x = L.solve_A(b)
print(x)

invI = L.spinv()
print(invI.todense())

print("success!")
