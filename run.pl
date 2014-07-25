#!/usr/bin/perl
use strict;
use Encode;
use burmeseunicode;

my $input_folder = "input";
my $output_folder = "output";

while (<"$input_folder/*">) {
  my $currF = $_;
  my ($fileName) = /\/(.*)/;
  print qq($fileName\n);
  local $/;
  open IN, "$currF" or die "can't read";
  my $foo = <IN>;
  close IN;
  $foo = Encode::decode_utf8($foo);     # from bytes to UTF8 encoding
  $foo = ava2uni5($foo);                # convert to Unicode 5.1
                                        # other possible conversion routines are:
                                        # soas2uni5, uni4touni5, myazedi2uni5, metta2uni5
  $foo = Encode::encode_utf8($foo);     # back to bytes
  open OUT, ">$output_folder/$fileName" or die;
  print OUT $foo;
  close OUT;
}
