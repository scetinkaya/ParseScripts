#!/usr/bin/perl


# calculate N-H bond vectors from .pdb file 


%res_num_to_vector_ref = ();
$max_res = -1;

#open(PDB, "< 1AARH_model1.pdb") or die "can't open file for reading";
#open(PDB, "< 2I5O.model1.pdb") or die "can't open file for reading";
#open(PDB, "< 3GB1_model1.pdb") or die "can't open file for reading";
#open(PDB, "< 1CMZ_model1.pdb") or die "can't open file for reading";
#open(PDB, "< 1C05.pdb") or die "can't open file for reading";

$inputFile         = shift;


open (PDB, $inputFile) ||
    die ("couldn't open $inputFile (should be pdb file)");
#print STDOUT "substracting 78 from the residue indices in the inputted file for 1CMZ.\n";
while ($line = <PDB>) {
	if ($line =~ m/^ATOM/) {
		$atom_type = substr($line, 13, 2);
		$res_type = substr($line, 17, 3);
		$res_num = substr($line, 22, 5);
		$res_num =~ s/^\s+//;
		$res_num =~ s/\s+$//;
#		$res_num = $res_num - 78; for 1CMZ
		$atom_x = substr($line, 30, 8);
		$atom_y = substr($line, 38, 8);
		$atom_z = substr($line, 46, 8);

		if ($res_type eq "HOH") {
			last;
		}

		if ($atom_type eq "N ") {
			$n_x = $atom_x;
			$n_y = $atom_y;
			$n_z = $atom_z;
			
			if ($res_num > $max_res) {
				$max_res = $res_num;
			}
		} elsif ($atom_type eq "H ") {
		   
			#normalize, store the vector
			$x_comp = $atom_x - $n_x;
			$y_comp = $atom_y - $n_y;
			$z_comp = $atom_z - $n_z;

			$length = sqrt($x_comp * $x_comp + $y_comp * $y_comp + $z_comp * $z_comp);
			$vector_ref = [$x_comp / $length, $y_comp / $length, $z_comp / $length];

			$res_num_to_vector_ref{$res_num} = $vector_ref;
		}
	}
}
close(PDB);

####################################
# write data to file N-H_vectors.m #
####################################
open(HSQC, "< combinedResonancesAndProtonCoordinates.txt");
#open(HSQC, "< myinput.m.1DK8");
open(OUT, "> N-H_vectors.m") or die "can't open file for writing";

while ($line = <HSQC>) {
    if ($line =~ m/^(\d+)\s+/) {
	$res_num = $1;
	
	$i = $res_num; #for some reason doesn't work otherwise

	if (exists($res_num_to_vector_ref{$i})) {
		$vector_ref = $res_num_to_vector_ref{$i};
		@vector = @$vector_ref;
		print OUT "$i\t$vector[0]\t$vector[1]\t$vector[2]\n";
	} else {
		print OUT "$i\t-999\t-999\t-999\n";
	}
    }
}
#for ($i = 1; $i <= $max_res; $i++) {
#	if (exists($res_num_to_vector_ref{$i})) {
#		$vector_ref = $res_num_to_vector_ref{$i};
#		@vector = @$vector_ref;
#		print OUT "$i\t$vector[0]\t$vector[1]\t$vector[2]\n";
#	} else {
#		print OUT "$i\t-999\t-999\t-999\n";
#	}
#}
close(OUT);
