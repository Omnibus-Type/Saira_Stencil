TTFDIR=./Fonts/static/ttf
OTFDIR=./Fonts/static/otf
VFDIR=./Fonts
mkdir -p $TTFDIR
mkdir -p $OTFDIR
mkdir -p $VFDIR
rm -r $TTFDIR/*.ttf
rm -r $OTFDIR/*.otf
rm -r $VFDIR/*.ttf

# Build ttf static instances
fontmake -g SairaStencil_VF.glyphs -o ttf -i --output-dir $TTFDIR -a
for f in $TTFDIR/*.ttf
do
	echo Processing $f
	gftools fix-dsig --autofix $f
	gftools fix-hinting $f
	mv $f.fix $f
done

# Build otf static instances
fontmake -g SairaStencil_VF.glyphs -o otf -i --output-dir $OTFDIR -a
for f in $OTFDIR/*.otf
do
	echo Processing $f
	gftools fix-dsig --autofix $f
	gftools fix-hinting $f
	mv $f.fix $f
done

set -e
# Build variable font
VF_FILENAME="./Fonts/SairaStencil[wght,wdth].ttf"
fontmake -g SairaStencil_VF.glyphs -o variable --output-path $VF_FILENAME
gftools fix-dsig --autofix $VF_FILENAME
ttfautohint $VF_FILENAME $VF_FILENAME.fix
mv $VF_FILENAME.fix $VF_FILENAME
gftools fix-hinting $VF_FILENAME
mv $VF_FILENAME.fix $VF_FILENAME

# Clean up
rm -r instance_ufo
rm -r master_ufo