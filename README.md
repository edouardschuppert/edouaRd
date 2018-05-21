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

datetimes\_fr
=============

`datetimes_fr` turn your dates into a french format. Please note that this is NOT a useful format to work with R. This function can only be used with a purpose of report, in order to have a very understandable format.

``` r
require(edouaRd, quietly = TRUE)

your_datetime <- lubridate::as_datetime(Sys.time())

datetimes_fr(your_datetime)
```

    ## [1] "21/05/2018 18:49:31"

Please report issues and suggestions to the [issues tracker](https://github.com/edouardschuppert/edouaRd/issues).
