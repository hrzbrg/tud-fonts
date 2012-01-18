#!/bin/bash
# universMac.sh
# Installation der TU Schriftarten unter Latex
#
# Autor: Michael Kluge, ZIH
# kluge@zhr.tu-dresden.de
#
# Anpassung an Mac OS von Johannes Rödel
# Letzte Aenderung: 08. Juni 2007
# 
# 11.11.2009
# Erweiterung durch Rico Backasch (Student TU Dresden)
# an Texlive 2009
# Testsystem: MBP, OSX 10.6.2, Texlive2009
#
# 18.01.2012
# kleine Anpassungen für Mac OS Lion durch Sebastian Herzberg (Student TU Dresden)
# getestet mit MacTex2011, OSX 10.7.2
#
# Installation erfolgt in das Tex-Haupt-Verzeichnis 
# da bei lokaler Installation die Schriften nicht gefunden werden
# 
# Installiert werden beide Schriften sowie die Vorlagen.
# Dazu müssen volgenede Dateien im selben Ordner wie dieses Script liegen:
# DIN_Bd_PS.zip 
# Univers_ps.zip
# vorlagen_20110504.zip (ist im Moment aktuell)


# setzen des Installationsverzeichnisses und bekanntmachen
# dieses Pfades im TexLive-System
export INSTDIR=`kpsexpand '/usr/local/texlive/texmf-local'`

# Wenn Verzeichniss nicht vorhanden -> anlegen
if [ -d $INSTDIR ] ; then
	echo "Ordner existiert bereits."  
	else   
		mkdir -pv $INSTDIR 
fi

workdir=`pwd`

# extract vorlagen to installdir
mkdir -p $INSTDIR/tex/latex/tud/
unzip vorlagen_20110504.zip -d $INSTDIR/tex/latex/tud/

# make tmp-dir for univers and dinbold
mkdir converted_univers
mkdir converted_dinbold

#unzip univers
unzip Univers_ps.zip
cd Univers_ps
# copy files
echo uvceb aunb8a
mv uvceb___.pfb $workdir/converted_univers/aunb8a.pfb
mv uvceb___.afm $workdir/converted_univers/aunb8a.afm
echo uvcel aunl8a
mv uvcel___.pfb $workdir/converted_univers/aunl8a.pfb
mv uvcel___.afm $workdir/converted_univers/aunl8a.afm
echo uvceo aunro8a
mv uvceo___.pfb $workdir/converted_univers/aunro8a.pfb
mv uvceo___.afm $workdir/converted_univers/aunro8a.afm
echo uvxbo aunbo8a
mv uvxbo___.pfb $workdir/converted_univers/aunbo8a.pfb
mv uvxbo___.afm $workdir/converted_univers/aunbo8a.afm
echo uvxlo aunlo8a
mv uvxlo___.pfb $workdir/converted_univers/aunlo8a.pfb
mv uvxlo___.afm $workdir/converted_univers/aunlo8a.afm
echo uvce aunr8a
mv uvce____.pfb $workdir/converted_univers/aunr8a.pfb
mv uvce____.afm $workdir/converted_univers/aunr8a.afm
echo uvczo aubro8a
mv uvczo___.pfb $workdir/converted_univers/aubro8a.pfb
mv uvczo___.afm $workdir/converted_univers/aubro8a.afm
echo uvcz aubr8a
mv uvcz____.pfb $workdir/converted_univers/aubr8a.pfb
mv uvcz____.afm $workdir/converted_univers/aubr8a.afm
#remove other files
rm -f *.inf
rm -f *.pfm

#unzip dinbold
cd ..
unzip DIN_Bd_PS.zip
cd DIN_Bd_PS
# copy files
mv DINBd___.pfb $workdir/converted_dinbold/dinb8a.pfb
mv DINBd___.afm $workdir/converted_dinbold/dinb8a.afm
#remove other files
rm -f *.PFM
rm -f *.afm
rm -f *.inf
rm -f *.pfb

cd ..

#build univers-fonts
cd converted_univers

cat > fiaun.tex <<%EOF
\\input fontinst.sty
\\latinfamily{aun}{}
\\bye
%EOF
latex fiaun.tex

cat > fiaub.tex <<%EOF
\\input fontinst.sty
\\latinfamily{aub}{}
\\bye
%EOF
latex fiaub.tex

for f in *.pl ; do
    pltotf $f
done

for f in *.vpl ; do
    vptovf $f
done

cat > univers.map <<%EOF
aunb8r UniversCE-Bold "TeXBase1Encoding ReEncodeFont" <8r.enc <aunb8a.pfb
aunl8r UniversCE-Light "TeXBase1Encoding ReEncodeFont" <8r.enc <aunl8a.pfb
aunro8r UniversCE-Oblique "TeXBase1Encoding ReEncodeFont" <8r.enc <aunro8a.pfb
aunbo8r UniversCE-BoldOblique "TeXBase1Encoding ReEncodeFont" <8r.enc <aunbo8a.pfb
aunlo8r UniversCE-LightOblique "TeXBase1Encoding ReEncodeFont" <8r.enc <aunlo8a.pfb
aunr8r UniversCE-Medium "TeXBase1Encoding ReEncodeFont" <8r.enc <aunr8a.pfb
aubro8r UniversCE-BlackOblique "TeXBase1Encoding ReEncodeFont" <8r.enc <aubro8a.pfb
aubr8r UniversCE-Black "TeXBase1Encoding ReEncodeFont" <8r.enc <aubr8a.pfb
%EOF

mkdir -p $INSTDIR/tex/latex/univers
mkdir -p $INSTDIR/fonts/tfm/adobe/univers
mkdir -p $INSTDIR/fonts/vf/adobe/univers
mkdir -p $INSTDIR/fonts/type1/adobe/univers
mkdir -p $INSTDIR/fonts/afm/adobe/univers

mv -v *.fd  $INSTDIR/tex/latex/univers/
mv -v *.tfm $INSTDIR/fonts/tfm/adobe/univers/
mv -v *.vf  $INSTDIR/fonts/vf/adobe/univers/
mv -v *.pfb $INSTDIR/fonts/type1/adobe/univers/
mv -v *.afm $INSTDIR/fonts/afm/adobe/univers

mkdir -p $INSTDIR/fonts/map 
mv univers.map $INSTDIR/fonts/map/


# buld dinbold fonts    
cd ..
rm -rf converted_univers
cd converted_dinbold


cat > fidin.tex <<%EOF
\\input fontinst.sty
\\latinfamily{din}{}
\\bye
%EOF
latex fidin.tex

for f in *.pl ; do
    pltotf $f
done

for f in *.vpl ; do
    vptovf $f
done

cat > dinbold.map <<%EOF
dinb8r DIN-Bold "TeXBase1Encoding ReEncodeFont" <8r.enc <dinb8a.pfb
%EOF

mkdir -p $INSTDIR/tex/latex/dinbold
mkdir -p $INSTDIR/fonts/tfm/adobe/dinbold
mkdir -p $INSTDIR/fonts/vf/adobe/dinbold
mkdir -p $INSTDIR/fonts/type1/adobe/dinbold
mkdir -p $INSTDIR/fonts/afm/adobe/dinbold

mv -v *.fd $INSTDIR/tex/latex/dinbold/
mv -v *.tfm $INSTDIR/fonts/tfm/adobe/dinbold/
mv -v *.vf $INSTDIR/fonts/vf/adobe/dinbold/
mv -v *.pfb $INSTDIR/fonts/type1/adobe/dinbold/
mv -v *.afm $INSTDIR/fonts/afm/adobe/dinbold/

mkdir -pv $INSTDIR/fonts/map
mv -v dinbold.map $INSTDIR/fonts/map/
    
cd ..
rm -rf converted_dinbold

# psfonts.map aktualisieren
sudo mktexlsr

updmap-sys --enable Map=univers.map
updmap-sys --enable Map=dinbold.map