#!/usr/bin/perl
#Lwin Moe, October 2011
package burmeseunicode;
use strict;
use Encode;       # for Unicode handling
our (@ISA, @EXPORT, @EXPORT_OK);
use Exporter;
@ISA            = qw(Exporter);
@EXPORT         = qw(zawgyi2uni5 soas2uni5 uni4touni5 myazedi2uni5 metta2uni5 ava2uni5);
@EXPORT_OK      = qw(:DEFAULT %Table);

############### Usage example
# use Encode;
# use burmeseunicode;
# $foo = "text in some font encoding";		# the text we want to convert
# $foo = Encode::decode_utf8($foo);		# from bytes to UTF8 encoding
# $foo = zawgyi2uni5($foo);			# from Zawgyi Myanmar to Uni 5.1
# $foo = soas2uni5($foo);			# from SOAS Myanmar to Uni 5.1
# $foo = uni4touni5($foo);			# from Burmese Unicode 4.1 to 5.1
# $foo = myazedi2uni5($foo);			# from Myazedi to Uni 5.1
# $foo = Encode::encode_utf8($foo);		# back to bytes

############### utilities
# $foo = Encode::decode_utf8($foo);		# from bytes to UTF8 encoding
# $foo = normalize($foo);
# $foo = Encode::encode_utf8($foo);		# back to bytes

############### utilities
# $foo = Encode::decode_utf8($foo);		# from bytes to UTF8 encoding
# $foo = normalize($foo);

############### variables

############### variables
my $consonantsWithTallAA = "\x{1001}|\x{1002}|\x{1004}|\x{1012}|\x{1015}|\x{101D}";
                        # KHA, GA, NGA, DA, PA, WA
my $consonantsWithMedialR = "[\x{1000}\x{1001}\x{1002}\x{1003}\x{1004}\x{1005}\x{1006}\x{1007}\x{100E}\x{100F}\x{1010}\x{1011}\x{1012}\x{1013}\x{1014}\x{1015}\x{1016}\x{1017}\x{1018}\x{1019}\x{101A}\x{101B}\x{101C}\x{101D}\x{101F}\x{1021}]";

my $consonants = qq(\x{1000}|\x{1001}|\x{1002}|\x{1003}|\x{1004}|\x{1005}|\x{1006}|\x{1007}|\x{1008}|\x{1009}|\x{100A}|\x{100B}|\x{100C}|\x{100D}|\x{100E}|\x{100F}|\x{1010}|\x{1011}|\x{1012}|\x{1013}|\x{1014}|\x{1015}|\x{1016}|\x{1017}|\x{1018}|\x{1019}|\x{101A}|\x{101B}|\x{101C}|\x{101D}|\x{101E}|\x{101F}|\x{1020}|\x{1021});
my $shanConsonants = qq(\x{1075}|\x{1076}|\x{1078}|\x{101E}|\x{107A}|\x{107C}|\x{107D}|\x{107E}|\x{101B}|\x{1080}|\x{1081}|\x{1022});
my $medial = qq(\x{103B}|\x{103C}|\x{103D}|\x{103E}|\x{105E}|\x{105F}|\x{1060});
my $shanMedial = qq(\x{1082});
my $shanTones = qq(\x{1087}|\x{1088}|\x{1089}|\x{108A}|\x{108B}|\x{108C});
my $vowel = qq(\x{102B}|\x{102C}|\x{102D}|\x{102E}|\x{102F}|\x{1030}|\x{1031}|\x{1032}|\x{1084}|\x{1085});

############### zawgyi2uni5 converts Zawgyi encoding to unicode 5.1 encoding
# IN: Zawgyi encoding
# OUT: Unicode 5 encoding
sub zawgyi2uni5 {
  local ($_) = shift;
  ################ start conversion
  s/\x{1033}/\x{102F}/g;	# Myanmar Vowel Sign U
  s/\x{1034}/\x{1030}/g;	# Myanmar Vowel Sign UU
  s/\x{103D}/\x{103E}/g;	# MEDIAL HA
  s/\x{103C}/\x{103D}/g;	# MEDIAL WA
  s/(?:\x{103B}|\x{107E}|\x{107F}|\x{1080}|\x{1081}|\x{1082}|\x{1083}|\x{1084})(.*?$consonantsWithMedialR)/$1\x{103C}/g;  # Medial RA
  s/\x{103A}/\x{103B}/g;	# MIDIAL YA
  s/\x{1039}/\x{103A}/g;	# ASAT
  s/\x{104E}/\x{104E}\x{1004}\x{103A}\x{1038}/g;	# Myanmar Symbol Aforementioned
  s/\x{105A}/\x{102B}\x{103A}/g;	# Myanmar Vowell Tall AA + ASAT
  s/\x{1060}/\x{1039}\x{1000}/g;	# VIRAMA + LETTER KA
  s/\x{1061}/\x{1039}\x{1001}/g;	# VIRAMA + LETTER KHA
  s/\x{1062}/\x{1039}\x{1002}/g;	# VIRAMA + LETTER GA
  s/\x{1063}/\x{1039}\x{1003}/g;	# VIRAMA + LETTER GHA
  s/\x{1065}/\x{1039}\x{1005}/g;  # subscript CA
  s/\x{1066}/\x{1039}\x{1006}/g;  # subscript CHA
  s/\x{1067}/\x{1039}\x{1006}/g;  # subscript CHA
  s/\x{1068}/\x{1039}\x{1007}/g;  # subscript JA
  s/\x{1069}/\x{1039}\x{1005}\x{103B}/g;  # subscript CA + MEDIAL YA
  s/\x{106A}/\x{1009}}/g;         # NYA
  s/\x{106B}/\x{100A}}/g;         # NNYA
  s/\x{106C}/\x{1039}\x{100B}/g;  # subscript TTA
  s/\x{106D}/\x{1039}\x{100C}/g;  # subscript TTHA
  s/\x{106E}/\x{100D}\x{1039}\x{100D}/g;  # DDA + subscript DDA
  s/\x{106F}/\x{100E}\x{1039}\x{100D}/g;  # DDHA + subscript DDA
  s/\x{1070}/\x{1039}\x{100F}/g;  # subscript NNA
  s/\x{1071}/\x{1039}\x{1010}/g;  # subscript TA
  s/\x{1072}/\x{1039}\x{1010}/g;  # subscript TA
  s/\x{1073}/\x{1039}\x{1011}/g;  # subscript THA
  s/\x{1074}/\x{1039}\x{1011}/g;  # subscript THA
  s/\x{1075}/\x{1039}\x{1012}/g;  # subscript DA
  s/\x{1076}/\x{1039}\x{1013}/g;  # subscript DHA
  s/\x{1077}/\x{1039}\x{1014}/g;  # subscript NA
  s/\x{1078}/\x{1039}\x{1015}/g;  # subscript PA
  s/\x{1079}/\x{1039}\x{1016}/g;  # subscript PHA
  s/\x{107A}/\x{1039}\x{1017}/g;  # subscript BA
  s/\x{107B}/\x{1039}\x{1018}/g;  # subscript BHA
  s/\x{107C}/\x{1039}\x{1019}/g;  # subscript MA
  s/\x{107D}/\x{103B}/g;	# MIDIAL YA
  s/\x{1085}/\x{1039}\x{101C}/g;  # subscript LA
  s/\x{1086}/\x{103F}/g;  # GREAT SA
  s/\x{1087}/\x{103E}/g;	# MEDIAL HA
  s/\x{1088}/\x{103E}\x{102F}/g;	# MEDIAL HA + VOWEL U
  s/\x{1089}/\x{103E}\x{1030}/g;	# MEDIAL HA + VOWEL UU
  s/\x{108A}/\x{103D}\x{103E}/g;	# MEDIAL HA + MEDIAL WA
  s/\x{108E}/\x{102D}\x{1036}/g;	# VOWEL I + ANUSVARA
  s/\x{108F}/\x{1014}/g;	# NA
  s/\x{1090}/\x{101B}/g;	# RA
  s/\x{1091}/\x{100F}\x{1039}\x{100D}/g;	# NNA + Subscript DDA
  s/\x{1092}/\x{100B}\x{1039}\x{100C}/g;	# TTA + Subscript TTHA
  s/\x{1093}/\x{1039}\x{1018}/g;  # subscript BHA
  s/(?:\x{1094}|\x{1095})/\x{1037}/g;	# DOT BELOW
  s/\x{1096}/\x{1039}\x{1010}\x{103D}/g;  # Subscript (TA+MEDIAL WA)
  s/\x{1097}/\x{100B}\x{1039}\x{100B}/g;  # TTA + subscript TTA
  ################ finished conversion

  ################ normalization
  $_ = normalize($_); 		# normalization
################# Handle Kinzi stuff
  s/(.)(\x{108D})/$2$1\x{1036}/g;	# KINZI and ANUSVARA
  s/($vowel)(\x{1064})/$2$1/g;		# reorder KINZI
  s/($medial)(\x{1064})/$2$1/g;		# reorder KINZI
  s/($consonants)(\x{1064})/$2$1/g;	# reorder KINZI and consonant
  s/($medial)(\x{108B})/$2$1\x{102D}/g;	# KINZI and VOWEL I
  s/($consonants)(\x{108B})/$2$1\x{102D}/g;	# KINZI and VOWEL I
  s/($medial)(\x{108C})/$2$1\x{102E}/g;	# KINZI and VOWEL II
  s/($consonants)(\x{108C})/$2$1\x{102E}/g;	# KINZI and VOWEL II
  s/\x{1064}/\x{1004}\x{103A}\x{1039}/g;# KINZI
  s/\x{108D}/\x{1004}\x{103A}\x{1039}/g;# KINZI
  s/\x{108B}/\x{1004}\x{103A}\x{1039}/g;# KINZI
  s/\x{108C}/\x{1004}\x{103A}\x{1039}/g;# KINZI
  ################ finished Kinzi conversion

  return $_;
} # POST: zawgyi2uni5 converts Zawgyi Myanmar encoding to unicode 5.1


############### soas2uni5 converts SOAS Myanmar Shan to unicode 5.1 encoding
# IN: Shan in SOAS Myanmar encoding
# OUT: Unicode 5 encoding
sub soas2uni5 {
  local ($_) = shift;
  ################ finished conversion
  s/\x{EC80}/\x{1075}/g;	# Myanmar Letter SHAN KA
  s/\x{EC81}/\x{1076}/g;	# Myanmar Letter SHAN KHA
  s/\x{EC85}/\x{1078}/g;	# Myanmar Letter SHAN CA
  s/\x{EC86}/\x{101E}/g;	# Myanmar Letter SHAN CHA
  s/\x{EC8A}/\x{107A}/g;	# Myanmar Letter SHAN NYA
  s/\x{EC94}/\x{107C}/g;	# Myanmar Letter SHAN NA
  s/\x{EC96}/\x{107D}/g;	# Myanmar Letter SHAN PHA
  s/\x{ECF5}/\x{107E}/g;	# Myanmar Letter SHAN FA
  s/\x{EC2A}/\x{101B}/g;	# Variant form of RA ???
  s/\x{EC9E}/\x{1080}/g;	# Myanmar Letter SHAN THA
  s/\x{EC9F}/\x{1081}/g;	# Myanmar Letter SHAN HA
  s/\x{ECA1}/\x{1022}/g;	# Myanmar Letter SHAN A

  s/\x{ECEF}/\x{1083}/g;	# Myanmar Vowel Sign SHAN AA
  s/\x{ECF8}/\x{1062}/g;	# Myanmar Vowel Sign SHAN AA (variant form)
  s/\x{EC58}/\x{102F}/g;	# Myanmar Vowel Sign U (variant form)
  s/\x{EC5A}/\x{1030}/g;	# Myanmar Vowel Sign UU (variant form)
  s/\x{ECEB}/\x{1035}/g;	# Myanmar Vowel Sign E ABOVE
  s/\x{ECF9}/\x{1084}/g;	# Myanmar Vowel Sign SHAN E
  s/\x{ECEC}/\x{1085}/g;	# Myanmar Vowel Sign SHAN E ABOVE
  s/\x{ECED}+/\x{1086}/g;	# Myanmar Vowel Sign SHAN FINAL Y

  s/\x{ECE7}/\x{1087}/g;	# Myanmar Sign SHAN TONE-2
  s/\x{ECE6}/\x{1088}/g;	# Myanmar Sign SHAN TONE-3
  s/\x{ECF2}/\x{1089}/g;	# Myanmar Sign SHAN TONE-5
  s/\x{ECF7}/\x{108A}/g;	# Myanmar Sign SHAN TONE-6
#  s/\x{ECF3}/\x{}/g;	# Myanmar Sign SHAN TONE (BELOW AII?) (SHAN COUNCIL TONE-3) (no need?)
#  s/\x{ECF0}/\x{}/g;	# Myanmar Sign SHAN TONE (AI?) (SHAN COUNCIL TONE-2) (no need?)

  s/\x{1039}/\x{103A}/g;    	# Myanmar Sign ASAT

  s/\x{EC37}/\x{103B}/g;	# Myanmar Consonant Sign MEDIAL YA
  s/\x{EC3A}($consonants|$shanConsonants)/$1\x{103C}/g;	# Myanmar Consonant Sign MEDIAL RA
  s/\x{EC3C}($consonants|$shanConsonants)/$1\x{103C}/g;	# Myanmar Consonant Sign MEDIAL RA (variant form)
  s/\x{ECE8}/\x{1082}/g;	# Myanmar Consonant Sign SHAN MEDIAL VA
  s/\x{ECF4}+/\x{103D}/g;	# Myanmar Consonant Sign SHAN MEDIAL WA (variant form?)
  s/\x{EC2C}/\x{103D}/g;	# Myanmar Consonant Sign Medial WA
  ################ finished conversion

  s/(\x{1082})(\x{103B})/$2$1/g;# Reverse SHAN MEDIAL WA and MEDIAL YA
  ################ normalization
  $_ = normalize($_); 		# normalization
  return $_;
} # POST: soas2uni5 converts SOAS Myanmar Shan encoding to unicode 5.1

############### uni4touni5 converts burmese unicode 4.1 to unicode 5.1 encoding
# IN: Burmese words in unicode 4.1 encoding
# OUT: Burmese in Unicode 5 encoding
sub uni4touni5 {
  local ($_) = shift;
  #### normalization
  s/(\x{102F})(\x{102D}|\x{102E}|\x{1032})/$2$1/g;	
					# reverse VOWEL U and (VOWEL I, VOWEL II, SIGN AI)
  s/(\x{1030})(\x{102D}|\x{102E}|\x{1032})/$2$1/g;	
				# reverse VOWEL UU and (VOWEL I, VOWEL II, SIGN AI)
  s/(\x{1037})(\x{103A})/$2$1/g;	# reverse LOWER DOT and Visible VIRAMA (ASAT)
  s/($vowel)\1/$1/g;		# normalize vowels
  ################ convert to Unicode 5.1
  s/\x{200D}*\x{1039}\x{101B}/\x{103C}/g;	# Medial RA
  s/\x{200D}*\x{1039}\x{101A}/\x{103B}/g;	# Medial Y
  s/\x{200D}*\x{1039}\x{101D}/\x{103D}/g;	# Medial W
  s/\x{200D}*\x{1039}\x{101F}/\x{103E}/g;	# Medial H
  s/\x{200D}*\x{1039}\x{200C}/\x{103A}/g;	# ASAT (NGA + ASAT)
  s/\x{200D}*\x{1004}\x{1039}/\x{1004}\x{103A}\x{1039}/g;# kinzi
  s/([^\x{1039}])($consonantsWithTallAA)($vowel*)\x{102C}/$1$2$3\x{102B}/g;          
						# TALL AA preceeded by some consonants
  s/($consonantsWithTallAA)\x{102C}/$1\x{102B}/g;          
						# TALL AA preceeded by some consonants
  s/\x{101E}\x{1039}\x{101E}/\x{103F}/g;	# LETTER GREAT SA
  ################ finished conversion

  return $_;
} # POST: uni4touni5 converts Burmese unicode 4.1 to unicode 5.1

############### myazedi2uni5 converts burmese Myazedi to unicode 5.1 encoding
# IN: Burmese words in Myazedi encoding
# OUT: Burmese in Unicode 5 encoding
sub myazedi2uni5 {
  local ($_) = shift;
  ################ conversion
  s/\x{104E}/\x{104E}\x{1004}\x{103A}\x{1038}/g;	
				# SYMBOL AFOREMENTIONED + NGA + ASAT + VISARGA
  s/\x{1035}/\x{103B}/g;  # Medial Y
  s/\x{1096}/\x{103B}\x{103E}/g;  # Medial Y + Medial H
  s/\x{1096}/\x{103B}\x{103D}/g; # Medial Y + Medial WA
  s/\x{1096}/\x{103B}\x{103D}\x{103E}/g;  # Medial Y + Medial WA + Medial H
  s/\x{1097}/\x{103B}\x{103D}/g;  # Medial Y + Medial WA
  s/\x{1099}/\x{1039}\x{1005}\x{103B}/g;  # Subscript CA + Medial Y
  s/\x{1039}/\x{103A}/g;  # ASAT
  s/\x{105D}/\x{102B}/g;  # Tall AA
  s/\x{105E}/\x{102B}\x{103A}/g;  # Tall AA + ASAT
  s/\x{105F}/\x{103E}/g;  # Medial H
  s/\x{1080}/\x{103E}/g;  # Medial H
  s/\x{1060}/\x{1039}\x{1000}/g;  # subscript KA
  s/\x{1061}/\x{1039}\x{1001}/g;  # subscript KHA
  s/\x{1062}/\x{1039}\x{1002}/g;  # subscript GA
  s/\x{1063}/\x{1039}\x{1003}/g;  # subscript GHA
  s/\x{1064}/\x{1039}\x{1005}/g;  # subscript CA
  s/\x{1065}/\x{1039}\x{1006}/g;  # subscript CHA
  s/\x{1066}/\x{1039}\x{1007}/g;  # subscript JA
  s/(?:\x{1067}|\x{109C})/\x{1039}\x{100F}/g;  # subscript NNA
  s/\x{1068}/\x{1039}\x{1010}/g;  # subscript TA
  s/\x{1069}/\x{1039}\x{1010}/g;  # subscript TA
  s/\x{106A}/\x{1039}\x{1011}/g;  # subscript THA
  s/\x{106B}/\x{1039}\x{1011}/g;  # subscript THA
  s/\x{106C}/\x{1039}\x{1012}/g;  # subscript DA
  s/\x{106D}/\x{1039}\x{1013}/g;  # subscript DHA
  s/\x{106E}/\x{1039}\x{1014}/g;  # subscript NA
  s/\x{106F}/\x{1039}\x{1015}/g;  # subscript PA
  s/\x{1070}/\x{1039}\x{1016}/g;  # subscript PHA
  s/(?:\x{1071}|\x{109D})/\x{1039}\x{1017}/g;  # subscript BA
  s/\x{1072}/\x{1039}\x{1018}/g;  # subscript BHA
  s/\x{1073}/\x{1039}\x{1019}/g;  # subscript MA
  s/(?:\x{1074}|\x{109E})/\x{1039}\x{101C}/g;  # subscript LA
  s/\x{1075}/\x{1039}\x{100C}/g;  # subscript TTHA
  s/\x{1089}/\x{100C}\x{1039}\x{100C}/g;  # TTHA + subscript TTHA
  s/\x{1076}/\x{1039}\x{100B}/g;  # subscript TTA
  s/\x{108A}/\x{100B}\x{1039}\x{100B}/g;  # TTA + subscript TTA
  s/\x{1077}/\x{1039}\x{1010}/g;  # subscript TA ???
  s/\x{1078}/\x{100F}\x{1039}\x{100D}/g;  # NNA + subscript DDA
  s/\x{1079}/\x{100E}\x{1039}\x{100D}/g;  # DDHA + subscript DDA
  s/\x{108B}/\x{100D}\x{1039}\x{100D}/g;  # DDA + subscript DDA
  s/\x{107A}/\x{1039}\x{1000}/g;  # subscript KA
  s/\x{107B}/\x{1039}\x{1003}/g;  # subscript GHA
  s/\x{107C}/\x{1039}\x{101E}/g;  # subscript GHA
  s/\x{107D}/\x{1039}\x{1006}/g;  # subscript CHA
  s/\x{107E}/\x{103D}/g;  	  # Medial WA
  s/\x{107F}/\x{103D}\x{103E}/g;  # Medial WA and Medial H
  s/\x{1081}/\x{103E}\x{102F}/g;  # Medial H and Vowel U
  s/\x{1082}/\x{102F}/g;  		# Vowel U
  s/\x{1083}/\x{1030}/g;  		# Vowel UU
  s/\x{1084}/\x{102D}\x{1036}/g;  	# Vowel I and ANUSVARA

  s/\x{1033}\x{101E}/\x{1029}/g;	# Letter 0
  s/(?:\x{1033}|\x{1034}|\x{1090}|\x{1091}|\x{1092}|\x{1093})(.*?$consonantsWithMedialR)/$1\x{103C}/g;  # Medial RA
  s/(?:\x{1094}|\x{1095})(.*?$consonantsWithMedialR)/$1\x{103C}\x{103D}/g;  # Medial R + Medial WA
  s/\x{108C}/\x{100A}/g;	# Letter NNYA
  s/\x{108D}/\x{103F}/g;	# LETTER GREAT SA
  s/\x{108E}/\x{1014}/g;	# LETTER NA
  s/\x{108F}/\x{1009}/g;	# LETTER NYA
  s/(?:\x{109A}|\x{109B})/\x{1037}/g;	# DOT BELOW
  s/\x{109F}/\x{101B}/g;	# LETTER RA

  ################# normalization 
  $_ = normalize($_);

  ################# Kinzi stuff
  s/(.)(\x{1085})/$2$1\x{1036}/g;	# KINZI and ANUSVARA
  s/($vowel)(\x{1086})/$2$1/g;		# reorder KINZI
  s/($medial)(\x{1086})/$2$1/g;		# reorder KINZI
  s/($consonants)(\x{1086})/$2$1/g;	# reorder KINZI and consonant
  s/($medial)(\x{1087})/$2$1\x{102D}/g;	# KINZI and VOWEL I
  s/($consonants)(\x{1087})/$2$1\x{102D}/g;	# KINZI and VOWEL I
  s/($medial)(\x{1088})/$2$1\x{102E}/g;	# KINZI and VOWEL II
  s/($consonants)(\x{1088})/$2$1\x{102E}/g;	# KINZI and VOWEL II
  s/\x{1085}/\x{1004}\x{103A}\x{1039}/g;# KINZI
  s/\x{1086}/\x{1004}\x{103A}\x{1039}/g;# KINZI
  s/\x{1087}/\x{1004}\x{103A}\x{1039}/g;# KINZI
  s/\x{1088}/\x{1004}\x{103A}\x{1039}/g;# KINZI
  ################ finished conversion

  return $_;
} # POST: myazedi2uni5 converts Burmese Myazedi to unicode 5.1

############### metta2uni5 converts Metta Shan font to unicode 5.1 encoding
# IN: Shan in Metta font
# OUT: Unicode 5 encoding
sub metta2uni5 {
  local ($_) = shift;
  ################ conversion
  #conversion starts
  s/\x{0043}\x{0070}/\x{107D}\x{103C}/g;
  s/\x{0043}\x{0064}/\x{1010}\x{103C}/g;
  s/\x{0058}\x{006D}/\x{1019}\x{103C}/g;
  s/\x{0058}\x{0062}/\x{1015}\x{103C}/g;
  s/\x{0046}/\x{1082}\x{103A}/g;
  s/\x{004B}/\x{103B}\x{103D}/g;
  s/\x{0048}/\x{1081}\x{1082}\x{103A}/g;
  s/\x{005C}/\x{1081}\x{102F}/g;
  s/\x{007C}/\x{1081}\x{1030}/g;
  s/\x{004E}/\x{1081}\x{103D}/g;
  s/\x{0041}/\x{1022}/g;
  s/\x{0042}/\x{107F}/g;
  s/\x{0043}/\x{103C}/g;
  s/\x{0044}/\x{107B}/g;
  s/\x{0045}/\x{1084}/g;
  s/\x{0047}/\x{1077}/g;
  s/\x{0049}/\x{102E}/g;
  s/\x{004A}/\x{1079}/g;
  s/\x{004C}/\x{103B}/g;
  s/\x{004D}/\x{1036}/g;
  s/\x{004F}/\x{108A}/g;
  s/\x{0050}/\x{107E}/g;
  s/\x{0051}/\x{1085}/g;
  s/\x{0052}/\x{101B}/g;
  s/\x{0053}/\x{1080}/g;
  s/\x{0054}/\x{101B}/g;
  s/\x{0055}/\x{1030}/g;
  s/\x{0056}/\x{1030}/g;
  s/\x{0057}/\x{103B}/g;
  s/\x{0058}/\x{103C}/g;
  s/\x{0059}/\x{107A}/g;
  s/\x{005A}/\x{103D}/g;
  s/\x{0061}/\x{1062}/g;
  s/\x{0062}/\x{1015}/g;
  s/\x{0063}/\x{1004}/g;
  s/\x{0064}/\x{1010}/g;
  s/\x{0065}/\x{1031}/g;
  s/\x{0066}/\x{1082}/g;
  s/\x{0067}/\x{1075}/g;
  s/\x{0068}/\x{1081}/g;
  s/\x{0069}/\x{102D}/g;
  s/\x{006A}/\x{1078}/g;
  s/\x{006B}/\x{1076}/g;
  s/\x{006C}/\x{101C}/g;
  s/\x{006D}/\x{1019}/g;
  s/\x{006E}/\x{107C}/g;
  s/\x{006F}/\x{1086}/g;
  s/\x{0070}/\x{107D}/g;
  s/\x{0071}/\x{1035}/g;
  s/\x{0072}/\x{103A}/g;
  s/\x{0073}/\x{101E}/g;
  s/\x{0074}/\x{1011}/g;
  s/\x{0075}/\x{102F}/g;
  s/\x{0076}/\x{1083}/g;
  s/\x{0077}/\x{101D}/g;
  s/\x{0078}/\x{1037}/g;
  s/\x{0079}/\x{101A}/g;
  s/\x{007A}/\x{103D}/g;
  s/\x{003B}/\x{1088}/g;
  s/\x{003A}/\x{1038}/g;
  s/\x{002C}/\x{1087}/g;
  s/\x{002E}/\x{1089}/g;
  #s/\x{00E2}\x{0080}\x{0098}/\x{2018}/g;
  #finished conversion

  s/(\x{1082})(\x{103B})/$2$1/g;# Reverse SHAN MEDIAL WA and MEDIAL YA
  ################ normalization
  $_ = normalize($_); 		# normalization
  return $_;
} # POST: metta to uni5

############### ava2uni5 converts Avalaser font to unicode 5.1 encoding
# IN: avalaser font
# OUT: Unicode 5 encoding
sub ava2uni5 {
  local ($_) = shift;
  ################ conversion
  s/\x{0031}/\x{1041}/g;
  s/\x{0032}/\x{1042}/g;
  s/\x{0033}/\x{1043}/g;
  s/\x{0034}/\x{1044}/g;
  s/\x{0035}/\x{1045}/g;
  s/\x{0036}/\x{1046}/g;
  s/\x{0037}/\x{1047}/g;
  s/\x{0038}/\x{1048}/g;
  s/\x{0039}/\x{1049}/g;
  s/\x{0030}/\x{1040}/g;
  s/\x{002D}/\x{2013}/g;
  s/\x{003D}/\x{003D}/g;
  s/\x{0041}/\x{1021}/g;
  s/\x{0071}/\x{101E}/g;
  s/\x{0077}/\x{101D}/g;
  s/\x{0065}/\x{1031}/g;
  s/\x{0072}/\x{101B}/g;
  s/\x{0074}/\x{1010}/g;
  s/\x{0079}/\x{101A}/g;
  s/\x{0075}/\x{102F}/g;
  s/\x{0069}/\x{102D}/g;
  s/\x{006F}/\x{102F}/g;
  s/\x{0070}/\x{1015}/g;
  s/\x{005B}/\x{005B}/g;
  s/\x{005D}/\x{005D}/g;
  s/\x{005C}/\x{103A}/g;
  s/\x{0061}/\x{102C}/g;
  s/\x{0073}/\x{1005}/g;
  s/\x{0064}/\x{1012}/g;
  s/\x{0066}/\x{104F}/g;
  s/\x{0067}/\x{1002}/g;
  s/\x{0068}/\x{101F}/g;
  s/\x{006A}/\x{104D}/g;
  s/\x{006B}/\x{1000}/g;
  s/\x{006C}/\x{101C}/g;
  s/\x{003B}/\x{1038}/g;
  s/\x{0027}/\x{104A}/g;
  s/\x{007A}/\x{1007}/g;
  s/\x{0063}/\x{1004}/g;
  s/\x{0076}/\x{100A}/g;
  s/\x{0062}/\x{1017}/g;
  s/\x{006E}/\x{1014}/g;
  s/\x{006D}/\x{1019}/g;
  s/\x{002C}/\x{002C}/g;
  s/\x{002E}/\x{1037}/g;
  s/\x{002F}/\x{002F}/g;
  s/\x{007E}/\x{1039}\x{1014}/g;
  s/\x{0021}/\x{100B}/g;
  s/\x{0040}/\x{100C}/g;
  s/\x{00A3}/\x{100D}/g;
  s/\x{0024}/\x{100E}/g;
  s/\x{0025}/\x{100F}/g;
  s/\x{005E}/\x{102E}/g;
  s/\x{0026}/\x{104E}/g;
  s/\x{002A}/\x{002A}/g;
  s/\x{0028}/\x{0028}/g;
  s/\x{0029}/\x{0029}/g;
  s/\x{005F}/\x{2013}/g;
  s/\x{002B}/\x{002B}/g;
  s/\x{0051}/\x{1039}\x{101A}/g;
  s/\x{0057}/\x{103D}\x{103E}/g;
  s/\x{0045}/\x{1027}/g;
  s/\x{0052}/\x{101B}/g;
  s/\x{0054}/\x{1011}/g;
  s/\x{0059}/\x{103B}\x{103E}/g;
  s/\x{0055}/\x{1025}/g;
  s/\x{0049}/\x{1023}/g;
  s/\x{004F}/\x{103E}\x{102F}/g;
  s/\x{0050}/\x{1016}/g;
  s/\x{007B}/\x{201C}/g;
  s/\x{007D}/\x{201D}/g;
  s/\x{0053}/\x{1006}/g;
  s/\x{0044}/\x{1013}/g;
  s/\x{0047}/\x{1003}/g;
  s/\x{0048}/\x{103E}/g;
  s/\x{004B}/\x{1001}/g;
  s/\x{004C}/\x{1020}/g;
  s/\x{003B}/\x{1038}/g;
  s/\x{0022}/\x{104B}/g;
  s/\x{005A}/\x{1008}/g;
  s/\x{0058}/\x{103C}\x{102F}/g;
  s/\x{0043}/\x{1004}\x{103A}\x{1039}\x{1036}/g;
  s/\x{0056}/\x{100A}/g;
  s/\x{0042}/\x{1018}/g;
  s/\x{004E}/\x{1014}/g;
  s/\x{004D}/\x{1036}/g;
  s/\x{003C}/\x{1039}\x{1021}/g;
  s/\x{003E}/\x{1037}/g;
  s/\x{003F}/\x{003F}/g;
  s/\x{0060}/\x{100B}\x{1039}\x{100B}/g;
  s/\x{20AC}/\x{100B}\x{1039}\x{100C}/g;
  s/\x{0023}/\x{100D}\x{1039}\x{100D}/g;
  s/\x{00A2}/\x{100D}\x{1039}\x{100E}/g;
  s/\x{221E}/\x{100F}\x{1039}\x{100F}/g;
  s/\x{2013}/\x{200B}/g;
  s/\x{0153}/\x{103F}/g;
  s/\x{2211}/\x{103D}/g;
  s/\x{00B4}/\x{1032}/g;
  s/\x{00AE}/\x{103C}/g;
  s/\x{2020}/\x{1039}\x{1010}/g;
  s/\x{00A5}/\x{103B}/g;
  s/\x{00A8}/\x{1030}/g;
  s/\x{005E}/\x{102E}/g;
  s/\x{00F8}/\x{1030}/g;
  s/\x{03C0}/\x{1039}\x{1015}/g;
  s/\x{201C}/\x{103C}/g;
  s/\x{2018}/\x{103C}\x{102F}/g;
  s/\x{00E5}/\x{102B}/g;
  s/\x{00DF}/\x{1039}\x{1005}/g;
  s/\x{2202}/\x{1039}\x{1012}/g;
  s/\x{00A9}/\x{1039}\x{1002}/g;
  s/\x{02D9}/\x{103E}/g;
  s/\x{02DA}/\x{1039}\x{1000}/g;
  s/\x{00AC}/\x{1039}\x{101C}/g;
  s/\x{2026}/\x{2026}\x{00E6}/g;
  s/\x{03A9}/\x{1039}\x{1007}/g;
  s/\x{00E7}/\x{1004}\x{103A}\x{1039}/g;
  s/\x{221A}/\x{1025}/g;
  s/\x{222B}/\x{1039}\x{1017}/g;
  s/\x{007E}/\x{1039}\x{1014}/g;
  s/\x{00B5}/\x{1039}\x{1019}/g;
  s/\x{2265}/\x{1037}/g;
  s/\x{0178}/\x{100B}/g;
  s/\x{2044}/\x{100F}\x{1039}\x{100B}/g;
  s/\x{2122}/\x{100F}\x{1039}\x{100C}/g;
  s/\x{2039}/\x{100F}\x{1039}\x{100D}/g;
  s/\x{203A}/\x{100F}\x{1039}\x{100E}/g;
  s/\x{FB01}/\x{100F}\x{1039}\x{100F}/g;
  s/\x{0152}/\x{1039}\x{101E}/g;
  s/\x{201E}/\x{103B}\x{103D}\x{103E}/g;
  s/\x{2030}/\x{101B}/g;
  s/\x{00C2}/\x{103C}/g;
  s/\x{00CA}/\x{1039}\x{1011}/g;
  s/\x{00C1}/\x{103B}\x{103D}/g;
  s/\x{00CB}/\x{1026}/g;
  s/\x{00C8}/\x{1024}/g;
  s/\x{00D8}/\x{103E}\x{1030}/g;
  s/\x{220F}/\x{1039}\x{1016}/g;
  s/\x{201D}/\x{103C}/g;
  s/\x{2019}/\x{103C}\x{102F}/g;
  s/\x{00C5}/\x{102B}\x{103A}/g;
  s/\x{00CD}/\x{1039}\x{1006}/g;
  s/\x{00CE}/\x{1039}\x{1013}/g;
  s/\x{00CC}/\x{1039}\x{1003}/g;
  s/\x{F8FF}/\x{1039}\x{1001}/g;
  s/\x{00D2}/\x{104C}/g;
  s/\x{00DB}/\x{1039}\x{1008}/g;
  s/\x{00D9}/\x{1004}\x{103A}\x{1039}\x{102D}/g;
  s/\x{00C7}/\x{1004}\x{103A}\x{1039}\x{102E}/g;
  s/\x{25CA}/\x{1009}/g;
  s/\x{0131}/\x{1039}\x{1018}/g;
  s/\x{02C6}/\x{1009}/g;
  s/\x{02DC}/\x{102D}\x{1036}/g;
  s/\x{00AF}/\x{2018}/g;
  s/\x{02D8}/\x{2019}/g;

  #finished conversion
  ################ normalization
  s/(\x{103C}|\x{103C}\x{102F})($consonants)/$2$1/g;
					#reorder MEDIAL RA and MEDIAL RA + VOWEL U followed by
					#consonants
  $_ = normalize($_); 		# normalization
  return $_;
} # POST: metta to uni5

sub normalize {
  local ($_) = shift;
  ################ normalization
  s/(\x{1031})(\x{1040})/$1\x{101D}/g;	# VOWEL E + DIGIT ZERO => E + WA

  s/(\x{1036}|\x{1037}|\x{103A})\1/$1/g;	# normalize ASAT, ANUSVARA, LOWER DOT
  s/($vowel)\1/$1/g;		# normalize vowels
  s/[\x{102D}\x{102E}](\x{102D}|\x{102E})/$1/g;		# normalize vowels I and II

  s/(\x{1031}|\x{1084})($consonants|$shanConsonants)/$2$1/g;# reverse VOWEL E 
  s/($shanTones)(\x{103A})/$2$1/g;	# reverse Shan tones and ASAT (103A) 
  s/($vowel)(($medial|$shanMedial)+)/$2$1/g;# reverse medial and vowel
  s/(\x{103D}|\x{103E})(\x{103B}|\x{103C})/$2$1/g;	
				# reverse (MEDIAL Y|R) and (MEDIAL W|H)
  s/($vowel)(\x{1039})($consonants|$shanConsonants)/$2$3$1/g;	# reverse vowel and subscript

  s/(\x{1036})(($medial)+)/$2$1/g;	# reverse medial and ANUSVARA
  s/(\x{1037})(($medial)+)/$2$1/g;	# reverse medial and LOWER DOT
  s/(\x{1086})(($medial|$shanMedial)+)/$2$1/g;	# reverse medial and Shan Final Y
  s/(\x{1036})(($vowel)+)/$2$1/g;	# reverse vowel and ANUSVARA
  s/(\x{1037})(($vowel)+)/$2$1/g;	# reverse vowel and LOWER DOT
  s/(\x{1037})(\x{1036})/$2$1/g;# reverse ANUSVARA and LOWER DOT
  s/([\x{103A}|\x{103E}|\x{1038}]+)(\x{1037})/$2$1/g;# reverse LOWER DOT and [Visible VIRAMA (ASAT), Moh Ha, Visarga]
  s/(\x{102F})(\x{102D}|\x{102E}|\x{1032})/$2$1/g;	
					# reverse VOWEL U and (VOWEL I, VOWEL II, SIGN AI)
  s/(\x{1030})(\x{102D}|\x{102E}|\x{1032})/$2$1/g;	
				# reverse VOWEL UU and (VOWEL I, VOWEL II, SIGN AI)
  ### comment out the following two lines for Karen
  s/[^\x{1039}]($consonantsWithTallAA)([\x{103D}\x{103E}]*)($vowel*)\x{102C}/$1$2$3\x{102B}/g;
                                                # TALL AA preceeded by some consonants
  s/(\x{103B})\x{102B}/$1\x{102C}/g;	# MEDIAL Y + TALL AA => AA

  s/\x{1040}($vowel|$medial|\x{1036}|\x{1037}|\x{103A})/\x{101D}$1/g;# replace DIGIT ZERO with LETTER WA if followed by vowels
  s/\x{1025}\x{102E}/\x{1026}/g;# Myanmar Letter UU
  s/\x{1025}(\x{1039})/\x{1009}$1/g;# replace LETTER U with NYA
  s/\x{1025}($vowel|$medial|\x{103A})/\x{1009}$1/g;# replace LETTER U with NYA
  s/($vowel)\1/$1/g;		# normalize vowels
  s/($shanTones)+/$1/g;		# normalize Shan tone marks

  ## this is to comply with UTN 11 ver. 4 (http://www.unicode.org/notes/tn11/UTN11_4.pdf)
  s/(\x{103A})(\x{1037})/$2$1/g; # BURMESE ASAT
  s/(\x{103A})(\x{103E})/$2$1/g; # MON ASAT
  s/(\x{103A})(\x{1082})/$2$1/g; # MON ASAT

  return $_;
} # POST: normalized canonical order

1;
