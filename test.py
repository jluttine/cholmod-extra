#!/usr/bin/env/python3

import numpy as np
import scipy.sparse as sp
import scikits.sparse.cholmod as cm
import time
import scipy.spatial.distance as dist
import matplotlib.pyplot as pl

import scikits.sparse.distance as spdist

import sys
sys.path.append("/home/jluttine/python")
import Nodes.CovarianceFunctions as CF

if (False):
	A = 2*sp.identity(5, format='lil')
	A[[2,4,4],[0,2,3]] = 1

	N = 6
	A = sp.rand(N,N, density=0.1)

	A = sp.diags([np.ones(N), np.ones(N-1), np.ones(N-1)], [0, 1, -1])

	K = A.T.dot(A) + sp.identity(N)
	K.sort_indices()
	print(K.todense())
	#L = cm.cholesky(K, mode="simplicial")
	L = cm.cholesky(K, mode="supernodal")
	(l,d) = L.L_D()
	#b = np.ones(5)

	#x = L.solve_A(b)
	#print(x)


	S = L.LD().copy()
	S.data[:] = 1

	print('Original matrix\n', K.todense())
	print('Cholesky LDL factor L\n', l.todense())
	print('Cholesky LDL factor D\n', np.diag(d.todense()))
	print('Cholesky LL factor L\n', L.L().todense())
	print('Symbolic structure of LD\n', S.todense())
	#print('Check that LDL is K\n', l.dot(d.dot(l.T)).todense())
	print('Sparse inverse\n', L.spinv().todense())
	print('True inverse\n', L.inv().todense())
	#print(np.linalg.inv(K.toarray()))



np.set_printoptions(precision=4)

#x = np.arange(4000) + 5
#K = CF.covfunc_pp2([1, 40], x, x)# + 0.01*sp.identity(x.shape[0])
x = np.arange(100) + 5
K = CF.covfunc_pp2([1, 200], x, x)

modes = ["supernodal"]
modes = ["simplicial", "supernodal"]

LD = cm.cholesky(K, mode="supernodal")
invK = LD.inv()
if sp.issparse(invK):
	invK = invK.todense()
for mode in modes:
	print("MODE:", mode)
	#print(K.todense())
	#LD = cm.cholesky(K, mode="simplicial")
	LD = cm.cholesky(K, mode=mode)
	#print(LD.LD().todense())

	S = LD.LD().copy()
	S.data[:] = 1
	#print('Symbolic structure of LD\n', S.todense())

	print("timing..")
	t = time.time()
	Z = LD.spinv()
	print("time: %f" % (time.time() - t))
	#print(Z.todense())
	#print(LD.inv().todense())

	Zd = Z.todense()
	E = (invK - Z)
	E[Zd==0] = 0
	e = E[Zd!=0]
	pl.ion()
	pl.figure()
	pl.imshow(E, interpolation="nearest")
	pl.show()
	pl.colorbar()
	pl.figure()
	pl.imshow(Zd, interpolation="nearest")
	pl.show()
	pl.colorbar()
	e.sort()
	print(e[-20:])
	print("maxerr", e.max())
	print("Error: ", np.linalg.norm(e))
	
	# Check the error by checking that diagonal entries are one
	Zd = Zd + Zd.T - np.diag(np.diag(Zd))
	E = K.multiply(Zd)
	e = E.sum(axis=0) - 1
	print("Error2:", np.linalg.norm(e))

	E = K.multiply(invK)
	e = E.sum(axis=0) - 1
	print("Error2 for inv:", np.linalg.norm(e))

input("Press ENTER to exit")
