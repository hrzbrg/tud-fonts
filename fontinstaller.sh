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
# 30.08.2012
# - Anpassung an Pfade mit Leerzeichen
# - Vorlagenname aktualisiert
#
# 31.08.2012
# - code cleanup
# - Zip-Dateien mit konvertierten Schriften generieren
#
# Aufruf: sudo ./fontinstaller.sh
#
# Installation erfolgt in das Tex-Haupt-Verzeichnis 
# da bei lokaler Installation die Schriften nicht gefunden werden
# 
# Installiert werden beide Schriften sowie die Vorlagen.
# Dazu müssen volgenede Dateien im selben Ordner wie dieses Script liegen:
# DIN_Bd_PS.zip 
# Univers_ps.zip
# Vorlagen_*.zip


# setzen des Installationsverzeichnisses und bekanntmachen
# dieses Pfades im TexLive-System
export TEMPTEXMF='texmf-local'
export INSTDIR='/usr/local/texlive/texmf-local'

# Wenn Verzeichniss nicht vorhanden -> anlegen
if [ -d $INSTDIR ] ; then
	echo 'Ordner existiert bereits.'
	else   
		mkdir -pv $INSTDIR 
fi

workdir=`pwd`

# extract vorlagen to installdir
mkdir -p $INSTDIR/tex/latex/tud/
unzip Vorlagen_*.zip -d $INSTDIR/tex/latex/tud/

# make tmp-dir
mkdir univers_converted
#unzip univers
unzip Univers_ps.zip
cd Univers_ps
# copy files
echo uvceb aunb8a
cp uvceb___.pfb "$workdir/univers_converted/aunb8a.pfb"
cp uvceb___.afm "$workdir/univers_converted/aunb8a.afm"
echo uvcel aunl8a
cp uvcel___.pfb "$workdir/univers_converted/aunl8a.pfb"
cp uvcel___.afm "$workdir/univers_converted/aunl8a.afm"
echo uvceo aunro8a
cp uvceo___.pfb "$workdir/univers_converted/aunro8a.pfb"
cp uvceo___.afm "$workdir/univers_converted/aunro8a.afm"
echo uvxbo aunbo8a
cp uvxbo___.pfb "$workdir/univers_converted/aunbo8a.pfb"
cp uvxbo___.afm "$workdir/univers_converted/aunbo8a.afm"
echo uvxlo aunlo8a
cp uvxlo___.pfb "$workdir/univers_converted/aunlo8a.pfb"
cp uvxlo___.afm "$workdir/univers_converted/aunlo8a.afm"
echo uvce aunr8a
cp uvce____.pfb "$workdir/univers_converted/aunr8a.pfb"
cp uvce____.afm "$workdir/univers_converted/aunr8a.afm"
echo uvczo aubro8a
cp uvczo___.pfb "$workdir/univers_converted/aubro8a.pfb"
cp uvczo___.afm "$workdir/univers_converted/aubro8a.afm"
echo uvcz aubr8a
cp uvcz____.pfb "$workdir/univers_converted/aubr8a.pfb"
cp uvcz____.afm "$workdir/univers_converted/aubr8a.afm"

cd ..
rm -rf Univers_ps

#build univers-fonts
cd univers_converted

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

cd ..
mkdir -p "$TEMPTEXMF/tex/latex/univers"
mkdir -p "$TEMPTEXMF/fonts/tfm/adobe/univers"
mkdir -p "$TEMPTEXMF/fonts/vf/adobe/univers"
mkdir -p "$TEMPTEXMF/fonts/type1/adobe/univers"
mkdir -p "$TEMPTEXMF/fonts/afm/adobe/univers"
mkdir -p "$TEMPTEXMF/fonts/map"

cp -v univers_converted/*.fd  "$TEMPTEXMF/tex/latex/univers/"
cp -v univers_converted/*.tfm "$TEMPTEXMF/fonts/tfm/adobe/univers/"
cp -v univers_converted/*.vf  "$TEMPTEXMF/fonts/vf/adobe/univers/"
cp -v univers_converted/*.pfb "$TEMPTEXMF/fonts/type1/adobe/univers/"
cp -v univers_converted/*.afm "$TEMPTEXMF/fonts/afm/adobe/univers"
cp -v univers_converted/univers.map "$TEMPTEXMF/fonts/map/"

rm -rf univers_converted

cd "$TEMPTEXMF"
zip -r ../univers_texmf.zip *
cd ..
rm -rf "$TEMPTEXMF"

# make tmp-dir
mkdir dinbold_converted

# unzip dinbold
unzip DIN_Bd_PS.zip
cd DIN_Bd_PS

# copy files
echo DINBd dinb8a
cp DINBd___.pfb "$workdir/dinbold_converted/dinb8a.pfb"
cp DINBd___.afm "$workdir/dinbold_converted/dinb8a.afm"

cd ..
rm -rf DIN_Bd_PS

# build dinbold fonts    
cd dinbold_converted

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

cd ..
mkdir -p "$TEMPTEXMF/tex/latex/dinbold"
mkdir -p "$TEMPTEXMF/fonts/tfm/adobe/dinbold"
mkdir -p "$TEMPTEXMF/fonts/vf/adobe/dinbold"
mkdir -p "$TEMPTEXMF/fonts/type1/adobe/dinbold"
mkdir -p "$TEMPTEXMF/fonts/afm/adobe/dinbold"
mkdir -p "$TEMPTEXMF/fonts/map"

cp -v dinbold_converted/*.fd "$TEMPTEXMF/tex/latex/dinbold/"
cp -v dinbold_converted/*.tfm "$TEMPTEXMF/fonts/tfm/adobe/dinbold/"
cp -v dinbold_converted/*.vf "$TEMPTEXMF/fonts/vf/adobe/dinbold/"
cp -v dinbold_converted/*.pfb "$TEMPTEXMF/fonts/type1/adobe/dinbold/"
cp -v dinbold_converted/*.afm "$TEMPTEXMF/fonts/afm/adobe/dinbold/"
cp -v dinbold_converted/dinbold.map "$TEMPTEXMF/fonts/map/"

rm -rf dinbold_converted

cd "$TEMPTEXMF"
zip -r ../dinbold_texmf.zip *
cd ..
rm -rf "$TEMPTEXMF"

# fonts kopieren, psfonts.map aktualisieren
unzip -u univers_texmf.zip -d $INSTDIR
unzip -u dinbold_texmf.zip -d $INSTDIR
mktexlsr

updmap-sys --enable Map=univers.map
updmap-sys --enable Map=dinbold.map