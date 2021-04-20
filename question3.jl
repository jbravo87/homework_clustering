# 3 Principal Components Analysis
# Project data into a 10 dimensional subspace.

using MultivariateStats
using Plots
using Distributions
# First to transpose the matrix from our derived subset.
tf10k_tpose = transpose( tf_10k )
tf10kMatrix = Matrix( tf10k_tpose )
model_1 = fit( PCA, tf10kMatrix, maxoutdim = 10 )
proj1 = projection( model_1 )
tf10k_trans = transform( model_1 , tf10kMatrix )

pv = principalvars( model_1 )

# Part 3
# Words with largest relative loadings in 1st principal component.
# Absolute values of entries in 'projection()'.
absProj1 = abs.( proj1 )
firstPCproj1 = absProj1[ : , 1 ]
sortperm( firstPCproj1 )

terms[ sortperm( firstPCproj1 ) ]
