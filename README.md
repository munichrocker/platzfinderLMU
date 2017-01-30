# platzfinderLMU
## Content of this Repo
R-Files to analyze a csv containing data from the ["Platzfinder" App at University of Munich](http://www.ub.uni-muenchen.de/arbeiten/platzfinder/index.html). The data runs from 16th of December 2016 to the 31st January 2017 (and is still continously pulled from a python scraper).

## Output ideas
Output should be a small data-journalistic piece with the following questions:
* When are the libraries the fullest?
* A GIF showing the fullness per hour
* a plot Showing a comparison between weekday and weekend on the mean of the total filling per hour (line chart)
* a plot showing the mean of the fullness over each day of the week.

## Open Questions:
* Should we throw away the Christmas holidays? (24.12.2016 00:00:00 -> 02.01.2017 00:00:00)

## Results
### Mean of Fullness all Weekdays, all Hours per Bibliothek
```R
                                      Bibliothek `mean(Belegt)`
                                          <fctr>          <dbl>
1       Allgemeiner Lesesaal (Zentralbibliothek)      51.911748
2  FB Biologie und Biomedizin (Lehrbuchsammlung)      27.696858
3    FB Biologie und Biomedizin (Präsenzbestand)      36.956140
4                        FB Chemie und Pharmazie      29.485241
5                           FB Englischer Garten      27.550278
6                           FB Geowissenschaften      29.465071
7               FB Germanistik und Komparatistik      24.319213
8                                  FB Historicum      45.228754
9                         FB Kunstwissenschaften      26.702586
10                     FB Medizinische Lesehalle      63.506063
11      FB Psychologie, Pädagogik und Soziologie      43.797496
12                  FB Theologie und Philosophie      56.733292
13    FB Wirtschaftswissenschaften und Statistik       7.415789
```
###Mean of Fullness over all Bibliotheken per Hour of the day
```R
    hour `mean(Belegt)`
   <int>          <dbl>
1      8       9.071156
2      9      15.946690
3     10      26.850318
4     11      34.032958
5     12      43.433977
6     13      46.623397
7     14      47.804956
8     15      51.451200
9     16      50.969551
10    17      45.592444
11    18      38.365125
12    19      32.527439
13    20      22.326969
14    21      17.362301
15    22      18.268966
16    23      17.181435
```