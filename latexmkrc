# latexmk configuration: PDF via pdfLaTeX, auxiliary files in build/
$pdf_mode = 1;
$out_dir = 'build';
$pdflatex = 'pdflatex -interaction=nonstopmode -file-line-error -synctex=1 %O %S';
