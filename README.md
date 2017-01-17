# platzfinderLMU
## Content of this Repo
R-Files to analyze a csv containing data from the ["Platzfinder" App at University of Munich](http://www.ub.uni-muenchen.de/arbeiten/platzfinder/index.html). The data runs from 16th of December 2016 to the 17th January 2017 (and is still continously pulled from a python scraper).

## Output ideas
Output should be a small data-journalistic piece with the following questions:
* When are the libraries the fullest?
* A GIF showing the fullness per hour
* a plot Showing a comparison between weekday and weekend on the mean of the total filling per hour (line chart)

## Open Questions:
* Should we throw away the Christmas holidays? (24.12.2016 00:00:00 -> 02.01.2017 00:00:00)

## Results
### Mean of Fullness all Weekdays, all Hours per Bibliothek
```R
                                      Bibliothek `mean(Belegt)`
                                          <fctr>          <dbl>
1       Allgemeiner Lesesaal (Zentralbibliothek)      30.886908
2  FB Biologie und Biomedizin (Lehrbuchsammlung)      13.108295
3    FB Biologie und Biomedizin (Präsenzbestand)      27.192146
4                        FB Chemie und Pharmazie      25.079439
5                           FB Englischer Garten      19.757685
6                           FB Geowissenschaften      17.578571
7               FB Germanistik und Komparatistik      17.405145
8                                  FB Historicum      34.816007
9                         FB Kunstwissenschaften      22.819802
10                     FB Medizinische Lesehalle      50.424978
11      FB Psychologie, Pädagogik und Soziologie      33.292054
12                  FB Theologie und Philosophie      46.980422
13    FB Wirtschaftswissenschaften und Statistik       4.736593
```


