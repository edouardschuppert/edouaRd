edouaRd
================

Ceci est un package de trucs pratiques que j’utilise au quotidien. C’est
pourquoi il n’est pas très orienté communauté.

`edouaRd` peut être installé depuis GitHub :

``` r
# install.packages("devtools")
devtools::install_github("edouardschuppert/edouaRd")
```

# povertext

`povertext` permet d’appauvrir le texte, en supprimant tous les accents
et trémas.

``` r
library(edouaRd, quietly = TRUE)

povertext(c("Père Noël", "Où êtes-vous ?"))
```

    ## [1] "pere noel"      "ou etes-vous ?"

# wordfrequency, bigramfrequency & hashtagfrequency

`wordfrequency` découpe les phrases en mots et les classe, permettant
ainsi de savoir lesquels sont les plus utilisés. `bigramfrequency` fait
la même chose, mais avec des bigrams. `hashtagfrequency` fait la même
chose, mais avec les hashtags. La possibilité est offerte de ne garder
qu’une partie de ces données.

``` r
suppressPackageStartupMessages(library(tidyverse))

edouaRd::rstats %>% 
  wordfrequency(text)
```

    ## # A tibble: 3,275 x 2
    ##    words           n
    ##    <chr>       <int>
    ##  1 rstats       2038
    ##  2 datascience   600
    ##  3 python        514
    ##  4 bigdata       448
    ##  5 analytics     421
    ##  6 javascript    401
    ##  7 reactjs       389
    ##  8 vuejs         389
    ##  9 golang        385
    ## 10 serverless    382
    ## # … with 3,265 more rows

``` r
edouaRd::rstats %>% 
  hashtagfrequency(text, slice = 30, original = TRUE)
```

    ## # A tibble: 30 x 2
    ##    hashtags         n
    ##    <chr>        <int>
    ##  1 #rstats       2038
    ##  2 #DataScience   600
    ##  3 #Python        462
    ##  4 #BigData       448
    ##  5 #Analytics     413
    ##  6 #JavaScript    391
    ##  7 #ReactJS       389
    ##  8 #VueJS         389
    ##  9 #GoLang        385
    ## 10 #Serverless    382
    ## # … with 20 more rows

``` r
edouaRd::rstats %>% 
  bigramfrequency(text, slice = 50)
```

    ## # A tibble: 50 x 2
    ##    bigram                        n
    ##    <chr>                     <int>
    ##  1 python rstats               410
    ##  2 reactjs vuejs               389
    ##  3 javascript reactjs          381
    ##  4 vuejs golang                378
    ##  5 bigdata analytics           374
    ##  6 java javascript             341
    ##  7 rstats tensorflow           339
    ##  8 datascience ai              307
    ##  9 cloudcomputing serverless   300
    ## 10 tensorflow java             281
    ## # … with 40 more rows

# datetimes\_fr & dates\_fr

`datetimes_fr` transforme les dates et heures en un format français.
`dates_fr` fait la même chose mais uniquement avec les dates. Il faut
noter que ceci n’est PAS un format utile pour travailler avec R. Cette
fonction ne peut être utilisée que dans un but de rapport ou de
présentation, afin d’obtenir un format très compréhensible.

``` r
Sys.time()
```

    ## [1] "2021-06-07 09:46:17 CEST"

``` r
datetimes_fr(Sys.time())
```

    ## [1] "07/06/2021 07:46:17"

``` r
dates_fr(Sys.time())
```

    ## [1] "07/06/2021"

# distribution\_time

`distribution_time` permet de vérifier la distribution temporelle d’un
jeu de données.

``` r
edouaRd::rstats %>% 
  distribution_time(created_at, granularity = "hour")
```

    ## # A tibble: 22 x 2
    ##    created_at              n
    ##    <dttm>              <int>
    ##  1 2018-07-11 12:00:00    50
    ##  2 2018-07-11 13:00:00   157
    ##  3 2018-07-11 14:00:00    97
    ##  4 2018-07-11 15:00:00   104
    ##  5 2018-07-11 16:00:00   100
    ##  6 2018-07-11 17:00:00    62
    ##  7 2018-07-11 18:00:00    82
    ##  8 2018-07-11 19:00:00    98
    ##  9 2018-07-11 20:00:00    69
    ## 10 2018-07-11 21:00:00   107
    ## # … with 12 more rows

Avec l’argument draw, cette distribution peut être exprimée de manière
plus visuelle.

``` r
edouaRd::rstats %>% 
  distribution_time(created_at, granularity = "hour", draw = TRUE)
```

![](README_fr_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

# rm\_empty\_cols

`rm_empty_cols` permet de supprimer les colonnes d’un tableau ne
comprenant que des NA.

``` r
edouaRd::rstats
```

    ## # A tibble: 2,000 x 88
    ##    user_id  status_id   created_at          screen_name  text            source 
    ##  * <chr>    <chr>       <dttm>              <chr>        <chr>           <chr>  
    ##  1 2865404… 1017339607… 2018-07-12 09:27:18 ma_salmon    "Great to see … Twitte…
    ##  2 2865404… 1017109552… 2018-07-11 18:13:08 ma_salmon    "The #useR2018… Twitte…
    ##  3 2865404… 1017270770… 2018-07-12 04:53:46 ma_salmon    "aaaand the li… Twitte…
    ##  4 2865404… 1017264158… 2018-07-12 04:27:29 ma_salmon    "This is a gre… Twitte…
    ##  5 2865404… 1017044420… 2018-07-11 13:54:20 ma_salmon    "Slides, code,… Twitte…
    ##  6 2865404… 1017318711… 2018-07-12 08:04:16 ma_salmon    "Glue strings … Twitte…
    ##  7 2865404… 1017267064… 2018-07-12 04:39:02 ma_salmon    "super useful … Twitte…
    ##  8 2865404… 1017093772… 2018-07-11 17:10:26 ma_salmon    "And you can m… Twitte…
    ##  9 29460483 1017338807… 2018-07-12 09:24:07 EuropePMC_n… "Great to see … TweetD…
    ## 10 1702037… 1017338790… 2018-07-12 09:24:03 WoodChivalry "Great to see … Twitte…
    ## # … with 1,990 more rows, and 82 more variables: display_text_width <dbl>,
    ## #   reply_to_status_id <chr>, reply_to_user_id <chr>,
    ## #   reply_to_screen_name <chr>, is_quote <lgl>, is_retweet <lgl>,
    ## #   favorite_count <int>, retweet_count <int>, hashtags <list>, symbols <list>,
    ## #   urls_url <list>, urls_t.co <list>, urls_expanded_url <list>,
    ## #   media_url <list>, media_t.co <list>, media_expanded_url <list>,
    ## #   media_type <list>, ext_media_url <list>, ext_media_t.co <list>,
    ## #   ext_media_expanded_url <list>, ext_media_type <chr>,
    ## #   mentions_user_id <list>, mentions_screen_name <list>, lang <chr>,
    ## #   quoted_status_id <chr>, quoted_text <chr>, quoted_created_at <dttm>,
    ## #   quoted_source <chr>, quoted_favorite_count <int>,
    ## #   quoted_retweet_count <int>, quoted_user_id <chr>, quoted_screen_name <chr>,
    ## #   quoted_name <chr>, quoted_followers_count <int>,
    ## #   quoted_friends_count <int>, quoted_statuses_count <int>,
    ## #   quoted_location <chr>, quoted_description <chr>, quoted_verified <lgl>,
    ## #   retweet_status_id <chr>, retweet_text <chr>, retweet_created_at <dttm>,
    ## #   retweet_source <chr>, retweet_favorite_count <int>,
    ## #   retweet_retweet_count <int>, retweet_user_id <chr>,
    ## #   retweet_screen_name <chr>, retweet_name <chr>,
    ## #   retweet_followers_count <int>, retweet_friends_count <int>,
    ## #   retweet_statuses_count <int>, retweet_location <chr>,
    ## #   retweet_description <chr>, retweet_verified <lgl>, place_url <chr>,
    ## #   place_name <chr>, place_full_name <chr>, place_type <chr>, country <chr>,
    ## #   country_code <chr>, geo_coords <list>, coords_coords <list>,
    ## #   bbox_coords <list>, status_url <chr>, name <chr>, location <chr>,
    ## #   description <chr>, url <chr>, protected <lgl>, followers_count <int>,
    ## #   friends_count <int>, listed_count <int>, statuses_count <int>,
    ## #   favourites_count <int>, account_created_at <dttm>, verified <lgl>,
    ## #   profile_url <chr>, profile_expanded_url <chr>, account_lang <chr>,
    ## #   profile_banner_url <chr>, profile_background_url <chr>,
    ## #   profile_image_url <chr>

``` r
rm_empty_cols(edouaRd::rstats)
```

    ## # A tibble: 2,000 x 86
    ##    user_id  status_id   created_at          screen_name  text            source 
    ##    <chr>    <chr>       <dttm>              <chr>        <chr>           <chr>  
    ##  1 2865404… 1017339607… 2018-07-12 09:27:18 ma_salmon    "Great to see … Twitte…
    ##  2 2865404… 1017109552… 2018-07-11 18:13:08 ma_salmon    "The #useR2018… Twitte…
    ##  3 2865404… 1017270770… 2018-07-12 04:53:46 ma_salmon    "aaaand the li… Twitte…
    ##  4 2865404… 1017264158… 2018-07-12 04:27:29 ma_salmon    "This is a gre… Twitte…
    ##  5 2865404… 1017044420… 2018-07-11 13:54:20 ma_salmon    "Slides, code,… Twitte…
    ##  6 2865404… 1017318711… 2018-07-12 08:04:16 ma_salmon    "Glue strings … Twitte…
    ##  7 2865404… 1017267064… 2018-07-12 04:39:02 ma_salmon    "super useful … Twitte…
    ##  8 2865404… 1017093772… 2018-07-11 17:10:26 ma_salmon    "And you can m… Twitte…
    ##  9 29460483 1017338807… 2018-07-12 09:24:07 EuropePMC_n… "Great to see … TweetD…
    ## 10 1702037… 1017338790… 2018-07-12 09:24:03 WoodChivalry "Great to see … Twitte…
    ## # … with 1,990 more rows, and 80 more variables: display_text_width <dbl>,
    ## #   reply_to_status_id <chr>, reply_to_user_id <chr>,
    ## #   reply_to_screen_name <chr>, is_quote <lgl>, is_retweet <lgl>,
    ## #   favorite_count <int>, retweet_count <int>, hashtags <list>,
    ## #   urls_url <list>, urls_t.co <list>, urls_expanded_url <list>,
    ## #   media_url <list>, media_t.co <list>, media_expanded_url <list>,
    ## #   media_type <list>, ext_media_url <list>, ext_media_t.co <list>,
    ## #   ext_media_expanded_url <list>, mentions_user_id <list>,
    ## #   mentions_screen_name <list>, lang <chr>, quoted_status_id <chr>,
    ## #   quoted_text <chr>, quoted_created_at <dttm>, quoted_source <chr>,
    ## #   quoted_favorite_count <int>, quoted_retweet_count <int>,
    ## #   quoted_user_id <chr>, quoted_screen_name <chr>, quoted_name <chr>,
    ## #   quoted_followers_count <int>, quoted_friends_count <int>,
    ## #   quoted_statuses_count <int>, quoted_location <chr>,
    ## #   quoted_description <chr>, quoted_verified <lgl>, retweet_status_id <chr>,
    ## #   retweet_text <chr>, retweet_created_at <dttm>, retweet_source <chr>,
    ## #   retweet_favorite_count <int>, retweet_retweet_count <int>,
    ## #   retweet_user_id <chr>, retweet_screen_name <chr>, retweet_name <chr>,
    ## #   retweet_followers_count <int>, retweet_friends_count <int>,
    ## #   retweet_statuses_count <int>, retweet_location <chr>,
    ## #   retweet_description <chr>, retweet_verified <lgl>, place_url <chr>,
    ## #   place_name <chr>, place_full_name <chr>, place_type <chr>, country <chr>,
    ## #   country_code <chr>, geo_coords <list>, coords_coords <list>,
    ## #   bbox_coords <list>, status_url <chr>, name <chr>, location <chr>,
    ## #   description <chr>, url <chr>, protected <lgl>, followers_count <int>,
    ## #   friends_count <int>, listed_count <int>, statuses_count <int>,
    ## #   favourites_count <int>, account_created_at <dttm>, verified <lgl>,
    ## #   profile_url <chr>, profile_expanded_url <chr>, account_lang <chr>,
    ## #   profile_banner_url <chr>, profile_background_url <chr>,
    ## #   profile_image_url <chr>

Pour toute question ou suggestion, merci de consulter la section [issues
tracker](https://github.com/edouardschuppert/edouaRd/issues).
