/* ========================================================================== */
/* === Include/cholmod_cholesky.h =========================================== */
/* ========================================================================== */

/* -----------------------------------------------------------------------------
 * CHOLMOD/Include/cholmod_cholesky.h. Copyright (C) 2005-2006, Timothy A. Davis
 * CHOLMOD/Include/cholmod_cholesky.h is licensed under Version 2.1 of the GNU
 * Lesser General Public License.  See lesser.txt for a text of the license.
 * CHOLMOD is also available under other licenses; contact authors for details.
 * http://www.cise.ufl.edu/research/sparse
 * -------------------------------------------------------------------------- */

/* CHOLMOD Cholesky module.
 *
 * Sparse Cholesky routines: analysis, factorization, and solve.
 *
 * The primary routines are all that a user requires to order, analyze, and
 * factorize a sparse symmetric positive definite matrix A (or A*A'), and
 * to solve Ax=b (or A*A'x=b).  The primary routines rely on the secondary
 * routines, the CHOLMOD Core module, and the AMD and COLAMD packages.  They
 * make optional use of the CHOLMOD Supernodal and Partition modules, the
 * METIS package, and the CCOLAMD package.
 *
 * Primary routines:
 * -----------------
 *
 * cholmod_analyze		order and analyze (simplicial or supernodal)
 * cholmod_factorize		simplicial or supernodal Cholesky factorization
 * cholmod_solve		solve a linear system (simplicial or supernodal)
 * cholmod_spsolve		solve a linear system (sparse x and b)
 *
 * Secondary routines:
 * ------------------
 *
 * cholmod_analyze_p		analyze, with user-provided permutation or f set
 * cholmod_factorize_p		factorize, with user-provided permutation or f
 * cholmod_analyze_ordering	analyze a fill-reducing ordering
 * cholmod_etree		find the elimination tree
 * cholmod_rowcolcounts		compute the row/column counts of L
 * cholmod_amd			order using AMD
 * cholmod_colamd		order using COLAMD
 * cholmod_rowfac		incremental simplicial factorization
 * cholmod_rowfac_mask		rowfac, specific to LPDASA
 * cholmod_row_subtree		find the nonzero pattern of a row of L
 * cholmod_resymbol		recompute the symbolic pattern of L
 * cholmod_resymbol_noperm	recompute the symbolic pattern of L, no L->Perm
 * cholmod_postorder		postorder a tree
 *
 * Requires the Core module, and two packages: AMD and COLAMD.
 * Optionally uses the Supernodal and Partition modules.
 * Required by the Partition module.
 */

#ifndef CHOLMOD_EXTRA_H
#define CHOLMOD_EXTRA_H

#include "UFconfig.h"
#include "cholmod_config.h"
#include "cholmod_core.h"

#ifndef NPARTITION
#include "cholmod_partition.h"
#endif

#ifndef NSUPERNODAL
#include "cholmod_supernodal.h"
#endif

/* -------------------------------------------------------------------------- */
/* cholmod_spsolve:  solve a linear system with a sparse right-hand-side */
/* -------------------------------------------------------------------------- */

cholmod_sparse *cholmod_spinv
(
    /* ---- input ---- */
    cholmod_factor *L,	/* factorization to use */
    /* --------------- */
    cholmod_common *Common
) ;

#endif
