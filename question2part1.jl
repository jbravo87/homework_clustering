# 10,000 nonprofits with highert revenue as metric of size
using Serialization
using Statistics
using SparseArrays

summary_stats = Serialization.deserialize( "irs990extract.jldata" )
termfreq = Serialization.deserialize( "termfreq.jldata" )
terms = Serialization.deserialize( "terms.jldata" )

funtion parse_rev( x )
    rev = x["revenue"]
    if ismissing( rev )
        0
    else
        parse( Int, x[ "revenue" ] )
    end
end

revenue = map( parse_rev, summary_stats )
mostrev = sortperm( revenue, rev = true )
top10k_indx = mostrev[ 1: 10000 ]
top10k = irs990extract[ top10k_indx ]

# Part 2
# To find the nonprofit with the highest revenue
top10k[1]

# Part 3
# Drop all words that don't appear at least twice in subset
sparse_termfreq = sparse( termfreq )

#firstSubset = sum( termfreq .> 0, dims = 1 )
firstSubset = sum( sparse_termfreq .> 0, dims = 1 )
#firstSubset = sum( x->x>0, sparse_termfreq .> 0, dims = 1 )
firstSubset = dropdims( firstSubset .> 0, dims = 1 )

fewerThanTwo = firstSubset .< 2
twoOrMore = 2 .<= firstSubset

termfreq_2 = termfreq[ 1:end, twoOrMore ]
