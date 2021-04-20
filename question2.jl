# 10,000 nonprofits with highert revenue as metric of size
using Serialization
using Statistics
using SparseArrays

summary_stats = Serialization.deserialize( "irs990extract.jldata" )
termfreq = Serialization.deserialize( "termfreq.jldata" )
terms = Serialization.deserialize( "terms.jldata" )

funtion parse_rev( x )
    rev = x[ "revenue" ]
    if ismissing( rev )
        0
    else
        parse( Int, x[ "revenue" ] )
    end
end

revenue = map( parse_rev, summary_stats )
highest_rev = sortperm( revenue, rev = true )
top10k_indx = highest_rev[ 1: 10_000 ]
#top10k = summary_stats[ top10k_indx, : ]
top10k = summary_stats[ top10k_indx ]

# Part 2
# To find the nonprofit with the highest revenue
top10k[1]

# Part 3
# Drop all words that don't appear at least twice in subset
termfreq_2 = termfreq[ top10k_indx , : ]

# To determine how frequqntly each term is represented in the subset.
term_appearances = 0 .< termfreq_2
word_count = sum( term_appearances, dims = 1 )

twoOrMore = 2 .<= word_count
subset = dropdims( twoOrMore, dims = 1 )

# Update the termfreq matrix to remove letters that appear less than twice
# Assign to new variable
tf_10k = termfreq_2[ 1:end, subset ]
# This matrix stores all the words that appear at least twice as defined by...
# ... the top10k conditions.
# Will use this subset for the remainder of the assignment.
