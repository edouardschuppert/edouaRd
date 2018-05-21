edouaRd
================

This is a package of practical things I use every day. Thus, it is not really community oriented.

`edouaRd` can be installed from Github :

``` r
# install.packages("devtools")
devtools::install_github("edouardschuppert/edouaRd")
```

povertext
=========

`povertext` deplete your text, it deletes any accents or umlaut.

``` r
require(edouaRd, quietly = TRUE)

your_string <- c("Père Noël", "Où êtes-vous ?")

povertext(your_string)
```

    ## [1] "pere noel"      "ou etes-vous ?"

Please report issues and suggestions to the [issues tracker](https://github.com/edouardschuppert/edouaRd/issues).
