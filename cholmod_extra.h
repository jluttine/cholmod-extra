/* ========================================================================== */
/* === cholmod_extra.h ====================================================== */
/* ========================================================================== */

/* -----------------------------------------------------------------------------
 * cholmod_extra.h. Copyright (C) 2012, Jaakko Luttinen
 * cholmod_extra.h is licensed under Version 3.0 of the GNU General Public 
 * License.  See LICENSE for a text of the license.
 * -------------------------------------------------------------------------- */

/* CHOLMOD Extra Module.
 *
 * Sparse Cholesky routines: sparse inverse.
 *
 * cholmod_spinv		sparse inverse (simplicial)
 *
 * Requires the Core module, and three packages: CHOLMOD, AMD and COLAMD.
 * Optionally uses the Supernodal and Partition modules.
 */

#ifndef CHOLMOD_EXTRA_H
#define CHOLMOD_EXTRA_H

#include <suitesparse/UFconfig.h>
#include <suitesparse/cholmod_config.h>
#include <suitesparse/cholmod_core.h>

#ifndef NPARTITION
#include <suitesparse/cholmod_partition.h>
#endif

#ifndef NSUPERNODAL
#include <suitesparse/cholmod_supernodal.h>
#endif

/* -------------------------------------------------------------------------- */
/* cholmod_spinv:  compute the sparse inverse of a sparse matrix              */
/* -------------------------------------------------------------------------- */

cholmod_sparse *cholmod_spinv
(
    /* ---- input ---- */
    cholmod_factor *L,	/* factorization to use */
    /* --------------- */
    cholmod_common *Common
) ;

#endif
