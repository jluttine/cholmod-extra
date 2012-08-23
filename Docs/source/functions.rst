Functions
=========

* Sparse inverse

Sparse inverse
--------------

Although the inverse of a sparse matrix is dense in general, it is
sometimes sufficient to compute only some elements of the inverse.
For instance, in order to compute
:math:`\operatorname{tr}(\mathbf{K}^{-1}\mathbf{A})`, it is sufficient
to find those elements of :math:`\mathbf{K}^{-1}` that are non-zero in
:math:`\mathbf{A}^{\mathrm{T}}`.  If :math:`\mathbf{K}` is symmetric
positive-definite and :math:`\mathbf{A}` has the same sparsity
structure as :math:`\mathbf{K}` (e.g.,
:math:`\mathbf{A}=\partial\mathbf{K}/\partial\theta`), an efficient
algorithm can be used to compute the elements of the inverse
:math:`\mathbf{K}^{-1}` that correspond to the non-zero elements in
:math:`\mathbf{K}` [Takahashi:1973]_.  The resulting sparse matrix is
called the *sparse inverse*.

The algorithm for computing the sparse inverse can be derived as
follows [Vanhatalo:2008]_.  Let's denote the inverse as
:math:`\mathbf{Z}=\mathbf{K}^{-1}` and the Cholesky decomposition as
:math:`\mathbf{LL}^{\mathrm{T}} = \mathbf{K}`, where
:math:`\mathbf{L}` is a lower triangular matrix.  We have the identity

.. math::
   :label: ZL

   \mathbf{ZL} = \mathbf{L}^{-\mathrm{T}}.

Taking the diagonal elements of the Cholesky factor,
:math:`\mathbf{\Lambda} = \operatorname{mask}(\mathbf{L},\mathbf{I})`,
the equation :eq:`ZL` can be written as

.. math::
   
   \mathbf{Z\Lambda} + \mathbf{Z} (\mathbf{L} - \mathbf{\Lambda}) =
   \mathbf{L}^{-\mathrm{T}}.

Subtracting the second term on the left and multiplying by
:math:`\mathbf{\Lambda}^{-1}` from the right yields

.. math::
   
   \mathbf{Z} = \mathbf{L}^{-\mathrm{T}} \mathbf{\Lambda}^{-1} -
   \mathbf{Z} (\mathbf{L} - \mathbf{\Lambda}) \mathbf{\Lambda}^{-1}.

.. [Takahashi:1973] Takahashi K, Fagan J, and Chen M-S
                    (1973). Formation of a sparse bus impedance matrix
                    and its application to short circuit study. In
                    *Power Industry Computer Application Conference
                    Proceedings*. IEEE Power Engineering Society.

.. [Vanhatalo:2008] Vanhatalo J and Vehtari A (2008). Modelling local
                    and global phenomena with sparse Gaussian
                    processes. In *Proceedings of the 24th Conference
                    in Uncertainty in Artificial Intelligence*. AU AI
                    Press.
