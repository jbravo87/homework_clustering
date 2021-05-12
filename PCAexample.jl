# Outcomes
# 1. Simulate data to understand statistical methods and software.

# Principal Components

import Random
using MultivariateStats
using Plots
using Distributions

plotly()
SZ = ( 1000, 800 )

# Let's make a data cloud that varies mostly along the line y = x.

# Principal components Analysis.
# PCA

n = 100
x = rand( Normal(), n )
# Want it to vary along the y-line
#y = x
# Now to add some random noise
noise_level = 0.3
y = x + noise_level * rand( Normal(), n )
scatter( x, y, legend = false, size = SZ )

# What should be the first principal component direction?

# horizontal concatenation
xy = hcat( x,y )
size( xy )

# Notice that the data is not in the correct form.

xy[ 19, 1:2 ]
 # To properly format need the transpose of the matrix.

xy1 = transpose( hcat(x,y) )

# Going to fit a PCA with one two dimensional input and one dimensional output.
# PCA is a dimension reducing technique
pca1 = fit( PCA, xy1, maxoutdim=1 )
# The principal ratio tells how much of the variance is explained by the Principal
#Components model, and how much of the variance in original data is represented by the model.

# pca1 is our instance of a fitted model.
# Euclidead distance around the unit circle.
projection( pca1 )

# Now we want ot reduce the dimensions of our data.
# Want to transform it using our PCA model
xy_trans = transform( pca1, xy1 )
size( xy1 )
size( xy_trans)
# Transformed it so we projected it down into a subspace

# Now to go from subspace back into original space.
xy_approx = reconstruct( pca1, xy_trans )

scatter!( xy_approx[ 1, 1:end ], xy_approx[ 2, 1:end ] )

# By reducing can use algorithms such as k-means

# One dimension is meaningful. Need another meaningful dimension.

z = rand( Normal(), n )
scatter( x, y, z, size = SZ, legend = false )

xyz = transpose( hcat(x,y,z) )
pca2 = fit( PCA, xyz, maxoutdim = 2 )
projection( pca2 )

# How much variance in each compoenent of the data
# Variance in each component
principalvars( pca2 )

# Total variance
tvar( pca2 )

# Relatively how much variance is explained by each principal component?
principalvars( pca2 ) / tvar( pca2 )
