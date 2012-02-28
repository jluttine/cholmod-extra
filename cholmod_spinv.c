/* ========================================================================== */
/* === cholmod_spinv ======================================================== */
/* ========================================================================== */

/* -----------------------------------------------------------------------------
 * CHOLMOD Extra Module.  Copyright (C) 2012, Jaakko Luttinen
 * Extra Module is licensed under Version 3.0 of the GNU General Public License.
 * See LICENSE for a text of the license.
 * -------------------------------------------------------------------------- */

/* Given an LL' or LDL' factorization of A, compute the sparse inverse of A,
 * that is, a matrix with the same sparsity as A but elements from inv(A).  Note
 * that, in general, inv(A) is dense but this computes only some elements of it.
 * All xtypes of A are supported (real, complex, and zomplex).
 */

//#ifndef NCHOLESKY

#include "cholmod_extra.h"

#include <suitesparse/cholmod_internal.h>
#include <suitesparse/cholmod_cholesky.h>


/* ========================================================================== */
/* === cholmod_spinv ======================================================== */
/* ========================================================================== */

cholmod_sparse *CHOLMOD(spinv)	    /* returns the sparse solution X */
(
    /* ---- input ---- */
    cholmod_factor *L,	/* factorization to use */
    /* --------------- */
    cholmod_common *Common
)
{
    int sys;
    double x, z ;
    cholmod_sparse *X ;
    double *Bx, *Bz, *Xx, *Xz, *B4x, *B4z, *X4x, *X4z ;
    Int *Bi, *Bp, *Xp, *Xi, *Bnz ;
    Int n, nrhs, q, p, i, j, jfirst, jlast, packed, block, pend, j_n, xtype ;
    size_t xnz, nzmax, nz ;

    /* ---------------------------------------------------------------------- */
    /* check inputs */
    /* ---------------------------------------------------------------------- */

    RETURN_IF_NULL_COMMON (NULL) ;
    RETURN_IF_NULL (L, NULL) ;
    RETURN_IF_XTYPE_INVALID (L, CHOLMOD_REAL, CHOLMOD_ZOMPLEX, NULL) ;
    Common->status = CHOLMOD_OK ;

    /* ---------------------------------------------------------------------- */
    /* allocate workspace B4 and initial result X */
    /* ---------------------------------------------------------------------- */

    n = L->n;
    //nzmax = L->nzmax;

    // Number of non-zero elements
    //nz = CHOLMOD(nnz) (L, Common);
    nz = L->nzmax;

    /* X is real if both L and B are real, complex/zomplex otherwise */
    xtype = L->xtype;

    //X = CHOLMOD(copy_sparse) (n, n, nzmax, xtype, Common) ;
    X = CHOLMOD(spzeros) (n, n, nz, xtype, Common) ;
    if (Common->status < CHOLMOD_OK)
    {
	CHOLMOD(free_sparse) (&X, Common) ;
	return (NULL) ;
    }

    Xp = X->p ;
    Xi = X->i ;
    Xx = X->x ;
    Xz = X->z ;

    //xnz = 0 ;

    /* ---------------------------------------------------------------------- */
    /* solve in chunks of 4 columns at a time */
    /* ---------------------------------------------------------------------- */
/*
    for (j = 0 ; j < n ; j += 1)
    {
*/
	/* ------------------------------------------------------------------ */
	/* adjust the number of columns of B4 */
	/* ------------------------------------------------------------------ */

	//jlast = MIN (nrhs, jfirst + block) ;
	//B4->ncol = jlast - jfirst ;

	/* ------------------------------------------------------------------ */
	/* scatter B(jfirst:jlast-1) into B4 */
	/* ------------------------------------------------------------------ */
/*
	for (i = j ; j > 0 ; j--)
	{
	    //p = Bp [j] ;
	    //pend = (packed) ? (Bp [j+1]) : (p + Bnz [j]) ;
	    //j_n = (j-jfirst)*n ;

	    switch (L->xtype)
	    {

		case CHOLMOD_REAL:
		    for ( ; p < pend ; p++)
		    {
			//B4x [Bi [p] + j_n] = Bx [p] ;
		    }
		    break ;

		case CHOLMOD_COMPLEX:
		    for ( ; p < pend ; p++)
		    {
			//q = Bi [p] + j_n ;
			//B4x [2*q  ] = Bx [2*p  ] ;
			//B4x [2*q+1] = Bx [2*p+1] ;
		    }
		    break ;

		case CHOLMOD_ZOMPLEX:
		    for ( ; p < pend ; p++)
		    {
			//q = Bi [p] + j_n ;
			//B4x [q] = Bx [p] ;
			//B4z [q] = Bz [p] ;
		    }
		    break ;
	    }
	}
*/
	/* ------------------------------------------------------------------ */
	/* solve the system (X4 = A\B4 or other system) */
	/* ------------------------------------------------------------------ */

/*
	X4 = CHOLMOD(solve) (sys, L, B4, Common) ;
	if (Common->status < CHOLMOD_OK)
	{
	    CHOLMOD(free_sparse) (&X, Common) ;
	    CHOLMOD(free_dense) (&B4, Common) ;
	    CHOLMOD(free_dense) (&X4, Common) ;
	    return (NULL) ;
	}
	ASSERT (X4->xtype == xtype) ;
	X4x = X4->x ;
	X4z = X4->z ;
*/
	/* ------------------------------------------------------------------ */
	/* append the solution onto X */
	/* ------------------------------------------------------------------ */

    for (i = 0; i < nzmax; i++) {
      Xx[i] = 5;
    }

    for (i = n-1; i >= 0; i--) {

	for (j = n-1; j > i ; j--)
	{
	    Xp [j] = xnz ;
	    j_n = (j-jfirst)*n ;

            /* ---------------------------------------------------------- */
            /* X is guaranteed to be large enough */
            /* ---------------------------------------------------------- */

		switch (xtype)
		{

		    case CHOLMOD_REAL:
			break ;

		    case CHOLMOD_COMPLEX:
			break ;

		    case CHOLMOD_ZOMPLEX:
			break ;
		}

	    }
	}

	/* ------------------------------------------------------------------ */
	/* clear B4 for next iteration */
	/* ------------------------------------------------------------------ */
/*
	if (jlast < nrhs)
	{

	    for (j = jfirst ; j < jlast ; j++)
	    {
		p = Bp [j] ;
		pend = (packed) ? (Bp [j+1]) : (p + Bnz [j]) ;
		j_n = (j-jfirst)*n ;

		switch (B->xtype)
		{

		    case CHOLMOD_REAL:
			for ( ; p < pend ; p++)
			{
			    B4x [Bi [p] + j_n] = 0 ;
			}
			break ;

		    case CHOLMOD_COMPLEX:
			for ( ; p < pend ; p++)
			{
			    q = Bi [p] + j_n ;
			    B4x [2*q  ] = 0 ;
			    B4x [2*q+1] = 0 ;
			}
			break ;

		    case CHOLMOD_ZOMPLEX:
			for ( ; p < pend ; p++)
			{
			    q = Bi [p] + j_n ;
			    B4x [q] = 0 ;
			    B4z [q] = 0 ;
			}
			break ;
		}
	    }
	}
    }
*/
  //  Xp [nrhs] = xnz ;

    /* ---------------------------------------------------------------------- */
    /* reduce X in size, free workspace, and return result */
    /* ---------------------------------------------------------------------- */

    ASSERT (xnz <= X->nzmax) ;
    CHOLMOD(reallocate_sparse) (xnz, X, Common) ;
    ASSERT (Common->status == CHOLMOD_OK) ;
    return (X) ;
}
//#endif
