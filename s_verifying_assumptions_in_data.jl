---
title: Skills Assignment - Verifying Assumptions in Data
author: J. Bravo
date: April 13, 2021
---

Will verify the correspondernce between 'irs990extract', 'terms', 'termfreq'. Will do this
by picking a random index from irs990extract and checking that the terms in termfreq are actually in the corresponding
mission description. Need to submit code along with output from the Julia REPL.

Used the following code to import the Julia data file into my Julia REPL in tmux.

```{julia , eval = false}
summary_stats = Serialization.deserialize( "irs990extract.jldata" )
```
```{julia , eval = false }
│julia> typeof( summary_stats )
│Array{Dict{String,V} where V,1}

termfreq = Serialization.deserialize( "termfreq.jldata" )

terms = Serialization.deserialize( "terms.jldata" )
```
I decided to choose item 12,345 using the following code with the following output.

```{julia , eval = false}
summary_stats[12345]
│Dict{String,String} with 7 entries:
│  "name"       => "MANSFIELD URBAN MINORITY ALCOHOLISM"
│  "volunteers" => "45"
│  "revenue"    => "10137977"
│  "file"       => "201901289349301150_public.xml"
│  "mission"    => "PROVIDE SPECIFIC DRUG AND ALCOHOL PREVENTIO…
│  "employees"  => "77"
│  "ein"        => "341703136"

summary_stats[12345][ "mission" ]
"PROVIDE SPECIFIC DRUG AND ALCOHOL PREVENTION SERVICES"
```
I used the following to extract element 12,345 out of "irs990extract" that corresponds to a row
from the "termfreq" data file, and stored the result in the variable "row12345".

```{julia , eval = false }
row12345 = termfreq[ 12345, 1 : end ]
│79653-element SparseArrays.SparseVector{Float64,Int64} with 7 stored entries:
│  [5448 ]  =  0.142857
│  [6298 ]  =  0.142857
│  [22924]  =  0.142857
│  [57966]  =  0.142857
│  [58980]  =  0.142857
│  [65249]  =  0.142857
│  [67624]  =  0.142857
```
In this final step, I used the "nzind" dot notation to extract the nonzero indices in the "terms" data file so as
to compare the mission statement from the IRS 990 forms after it was processed.

```{julia , eval = false }
│julia> terms[ row12345.nzind ]
│7-element Array{String,1}:
│ "alcohol"
│ "and"
│ "prevent"
│ "provid"
│ "servic"
│ "specif"
```
The output of the above code does seem to correspond to row 12,345 from the summary data. There are certain features
that indicate that the mission statment was succesfully processed. For example, the string was changed to all lowercase,
as well as some of the words missing vowels at the end of the word.
