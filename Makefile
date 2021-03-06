
all: presentation.html Figs JS

Figs: Figs/intercross.png Figs/lodcurve_insulin.png

JS: JS/manyboxplots.js JS/lod_and_effect.js JS/cistrans.js JS/lod_alltimes.js JS/corr_w_scatter.js JS/selection_example.js JS/lod_onetime_random.js JS/handle_stickies.js

presentation.html: index.html js css/kbroman_talk.css css/kbroman_presentation.css
	Perl/create_presentation.pl

Figs/%.png: R/%.R
	cd R;R CMD BATCH $(<F)

JS/%.js: Coffee/%.coffee
	coffee -bco JS $^

web: presentation.html
	scp *.html broman-2.biostat.wisc.edu:public_html/presentations/BioVis/

weball: presentation.html JS Figs
	scp *.html broman-2.biostat.wisc.edu:public_html/presentations/BioVis/
	scp JS/* broman-2.biostat.wisc.edu:public_html/presentations/BioVis/JS/
	scp Coffee/* broman-2.biostat.wisc.edu:public_html/presentations/BioVis/Coffee/
	scp CSS/* broman-2.biostat.wisc.edu:public_html/presentations/BioVis/CSS/
	scp Figs/*.png broman-2.biostat.wisc.edu:public_html/presentations/BioVis/Figs/
	scp Figs/*.jpg broman-2.biostat.wisc.edu:public_html/presentations/BioVis/Figs/
	scp Figs/Panels/* broman-2.biostat.wisc.edu:public_html/presentations/BioVis/Figs/Panels/
	scp Figs/Charts/* broman-2.biostat.wisc.edu:public_html/presentations/BioVis/Figs/Charts/

tar: presentation.html JS Figs
	cd ..;tar czvhf broman_biovis.tgz BioVis/[A-Za-z]*
