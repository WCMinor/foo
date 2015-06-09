set terminal pngcairo  enhanced font "arial,10" fontscale 1.0 size 1500, 500 
set output "output.png"
set boxwidth 0.5
set style fill   solid 1.00 border lt -1
set key inside right top vertical Right noreverse noenhanced autotitles nobox
set style histogram clustered gap 1 title  offset character 0, 0, 0
set datafile missing '-'
set style data histograms
set xtics border in scale 0,0 nomirror rotate by -45  offset character 0, 0, 0 autojustify
set xtics   ()
set title "test" 
plot 'data' using (column(0)):2:xtic(1) ti col with boxes 
