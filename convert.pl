#!/usr/bin/perl
use FindBin;
use lib $FindBin::Bin;

use Encode;
use strict;
use burmeseunicode;

my $file = $ARGV[0];
open IN, "$file" or die;
while (<IN>) {
  chomp;
  my $curr = $_;
  $curr = Encode::decode_utf8($curr);   # from bytes to UTF8 encoding
  $curr =~ s/(\x{103A})(\x{1037})/$2$1/g; # BURMESE ASAT
  $curr =~ s/(\x{103A})(\x{103E})/$2$1/g; # MON ASAT
  $curr =~ s/(\x{103A})(\x{1082})/$2$1/g; # MON ASAT
  $curr = Encode::encode_utf8($curr);   # back to bytes
  print qq($curr\n);
}
close IN;
