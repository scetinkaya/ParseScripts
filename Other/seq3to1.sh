#!/bin/sh
# convert protein sequence from three letter code to one letter code
# Just write down your sequence to a ascii file with
# three letter-words, upper or lower case
# separated by a puntuation sign like comma, space, dash or
# other. Avoid heading, comments or other information
# Rogelio Rodr.ANmguez-Sotres, 24/09/2007 adapted from
# Kuen-Phon Wu, 06/11/2004 version 0.3
#
# This program will ignore any other characters in stardar 20 Amino
# acids, Either lowercases or uppercases can be process via this
# program
#
# Just use as: ./seq1to3.sh [FILENAME] > [OUT_FILE]
usage=$B!G(BUsage: seq3to1.sh [inputfile] > [OUTPUT]$B!F(B

if [ $# -lt 1 ] ; then
echo $B!H(B$usage$B!I(B
exit 1
fi

#### NOTE: change ==== to the other direction of $B!H(B>$B!I(B before running
cat $1 | tr $B!F(B[:punct:]$B!F(B $B!F(B $B!F(B | tr $B!F(B[0-9]$B!F(B $B!F(B $B!F(B |tr $B!F(B\n$B!G(B $B!F(B $B!F(B| tr $B!F(B[A-Z]$B!F(B $B!F(B[a-z]$B!F(B | \
sed -e $B!G(Bs/[x|z|j|b| ]/ /g$B!G(B \
-e $B!G(Bs/ ala / A /g$B!G(B -e $B!G(Bs/ cys / C /g$B!G(B -e $B!G(Bs/ asp / D /g$B!G(B \
-e $B!G(Bs/ glu / E /g$B!G(B -e $B!G(Bs/ phe / F /g$B!G(B -e $B!G(Bs/ gly / G /g$B!G(B \
-e $B!G(Bs/ his / H /g$B!G(B -e $B!G(Bs/ ile / I /g$B!G(B -e $B!G(Bs/ lys / K /g$B!G(B \
-e $B!G(Bs/ leu / L /g$B!G(B -e $B!G(Bs/ met / M /g$B!G(B -e $B!G(Bs/ pro / P /g$B!G(B \
-e $B!G(Bs/ arg / R /g$B!G(B -e $B!G(Bs/ gln / Q /g$B!G(B -e $B!G(Bs/ asn / N /g$B!G(B \
-e $B!G(Bs/ ser / S /g$B!G(B -e $B!G(Bs/ thr / T /g$B!G(B -e $B!G(Bs/ trp / W /g$B!G(B \
-e $B!G(Bs/ tyr / Y /g$B!G(B -e $B!G(Bs/ val / V /g$B!G(B -e $B!G(Bs/ //g$B!G(B

