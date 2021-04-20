# 10,000 nonprofits with highert revenue as metric of size
using Serialization

using Statistics

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

revenue = map( parse_rev, irs990extract )

mostrev = sortperm( revenue, rev = True )

top10k_indx = mostrev[ 1: 10000 ]

top10k = irs990extract[ top10k_indx ]
