name=$1
mkdir $name
cp header.tex introduction.tex natbib.sty jmb.bst base.tex base.bib $name

printf "all:\n\tpdflatex $name\n\tbibtex $name\n\tpdflatex $name\n\topen -a skim $name.pdf\n\nclean:\n\trm *.aux *.brf *.pdf *.log *.bbl *.blg *.dvi *.ps *.out *.fdb_latexmk *.synctex.gz" > $name/Makefile

mv $name/base.tex $name/$name.tex
mv $name/base.bib $name/$name.bib

sed -i '.bak' 's/\bibliography{base}/\bibliography{'$name'}/g' $name/$name.tex
rm $name/$name.tex.bak
