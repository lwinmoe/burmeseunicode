#!/usr/bin/python3
# Lwin Moe, September 2016
# License: http://creativecommons.org/licenses/by-sa/4.0/

import sys, os
import re

############### variables
consonantsWithTallAA = "\u1001|\u1002|\u1004|\u1012|\u1015|\u101D"
                        # KHA, GA, NGA, DA, PA, WA
consonantsWithMedialR = "[\u1000\u1001\u1002\u1003\u1004\u1005\u1006\u1007\u100E\u100F\u1010\u1011\u1012\u1013\u1014\u1015\u1016\u1017\u1018\u1019\u101A\u101B\u101C\u101D\u101F\u1021]"

consonants = "\u1000|\u1001|\u1002|\u1003|\u1004|\u1005|\u1006|\u1007|\u1008|\u1009|\u100A|\u100B|\u100C|\u100D|\u100E|\u100F|\u1010|\u1011|\u1012|\u1013|\u1014|\u1015|\u1016|\u1017|\u1018|\u1019|\u101A|\u101B|\u101C|\u101D|\u101E|\u101F|\u1020|\u1021"
shanConsonants = "\u1075|\u1076|\u1078|\u101E|\u107A|\u107C|\u107D|\u107E|\u101B|\u1080|\u1081|\u1022"
medial = "\u103B|\u103C|\u103D|\u103E|\u105E|\u105F|\u1060"
shanMedial = "\u1082"
shanTones = "\u1087|\u1088|\u1089|\u108A|\u108B|\u108C"
vowel = "\u102B|\u102C|\u102D|\u102E|\u102F|\u1030|\u1031|\u1032|\u1084|\u1085"


############### zawgyi2uni5 converts Zawgyi encoding to unicode 5.2 encoding
# IN: Zawgyi encoding
# OUT: Unicode 5.2 encoding
def zawgyi2uni5(str):
    ################ start conversion
    str = re.sub("\u1033", "\u102F", str)       # Myanmar Vowel Sign U
    str = re.sub("\u1034", "\u1030", str)       # Myanmar Vowel Sign UU
    str = re.sub("\u103D", "\u103E", str)       # MEDIAL HA
    str = re.sub("\u103C", "\u103D", str)       # MEDIAL WA
    my_regex = r"(\u103B|\u107E|\u107F|\u1080|\u1081|\u1082|\u1083|\u1084)(?P<consonants>.*?" + consonantsWithMedialR + r")"
    str = re.sub(my_regex, "\g<consonants>\u103C", str) # Medial RA
    str = re.sub("\u103A", "\u103B", str)       # MIDIAL YA
    str = re.sub("\u1039", "\u103A", str)       # ASAT
    str = re.sub("\u104E", "\u104E\u1004\u103A\u1038", str)
                                                # Myanmar Symbol Aforementioned
    str = re.sub("\u105A", "\u102B\u103A", str) # Myanmar Vowell Tall AA + ASAT

    str = re.sub("\u1060", "\u1039\u1000", str) # VIRAMA + LETTER KA
    str = re.sub("\u1061", "\u1039\u1001", str) # VIRAMA + LETTER KHA
    str = re.sub("\u1062", "\u1039\u1002", str) # VIRAMA + LETTER GA
    str = re.sub("\u1063", "\u1039\u1003", str) # VIRAMA + LETTER GHA
    str = re.sub("\u1065", "\u1039\u1005", str) # subscript CA
    str = re.sub("\u1066", "\u1039\u1006", str) # subscript CHA
    str = re.sub("\u1067", "\u1039\u1006", str) # subscript CHA
    str = re.sub("\u1068", "\u1039\u1007", str) # subscript JA
    str = re.sub("\u1069", "\u1039\u1005\u103B", str)
                                                # subscript CA + MEDIAL YA
    str = re.sub("\u106A", "\u1009", str)       # NYA
    str = re.sub("\u106B","\u100A", str)        # NNYA
    str = re.sub("\u106C", "\u1039\u100B", str) # subscript TTA
    str = re.sub("\u106D", "\u1039\u100C", str) # subscript TTHA
    str =re.sub("\u106E", "\u100D\u1039\u100D", str)
                                                # DDA + subscript DDA
    str = re.sub("\u106F", "\u100E\u1039\u100D", str)
                                                # DDHA + subscript DDA

    str = re.sub("\u1070", "\u1039\u100F", str) # subscript NNA
    str = re.sub("\u1071", "\u1039\u1010", str) # subscript TA
    str = re.sub("\u1072", "\u1039\u1010", str) # subscript TA
    str = re.sub("\u1073", "\u1039\u1011", str) # subscript THA
    str = re.sub("\u1074", "\u1039\u1011", str) # subscript THA
    str = re.sub("\u1075", "\u1039\u1012", str) # subscript DA
    str = re.sub("\u1076", "\u1039\u1013", str) # subscript DHA
    str = re.sub("\u1077", "\u1039\u1014", str) # subscript NA
    str = re.sub("\u1078", "\u1039\u1015", str) # subscript PA
    str = re.sub("\u1079", "\u1039\u1016", str) # subscript PHA
    str = re.sub("\u107A", "\u1039\u1017", str) # subscript BA
    str = re.sub("\u107B", "\u1039\u1018", str) # subscript BHA
    str = re.sub("\u107C", "\u1039\u1019", str) # subscript MA
    str = re.sub("\u107D", "\u103B", str)       # MIDIAL YA
    str = re.sub("\u1085", "\u1039\u101C", str) # subscript LA
    str = re.sub("\u1086", "\u103F", str)       # GREAT SA
    str = re.sub("\u1087", "\u103E", str)       # MEDIAL HA
    str = re.sub("\u1088", "\u103E\u102F", str) # MEDIAL HA + VOWEL U
    str = re.sub("\u1089", "\u103E\u1030", str) # MEDIAL HA + VOWEL UU
    str = re.sub("\u108A", "\u103D\u103E", str) # MEDIAL HA + MEDIAL WA
    str = re.sub("\u108E", "\u102D\u1036", str) # VOWEL I + ANUSVARA
    str = re.sub("\u108F", "\u1014", str)       # NA
    str = re.sub("\u1090", "\u101B", str)       # RA
    str = re.sub("\u1091", "\u100F\u1039\u100D", str)
                                                # NNA + Subscript DDA
    str = re.sub("\u1092", "\u100B\u1039\u100C", str)
                                                # TTA + Subscript TTHA
    str = re.sub("\u1093", "\u1039\u1018", str) # subscript BHA
    str = re.sub(r"(\u1094|\u1095)", "\u1037", str)
                                                # DOT BELOW
    str = re.sub("\u1096", "\u1039\u1010\u103D", str)
                                                # Subscript (TA+MEDIAL WA)
    str = re.sub("\u1097", "\u100B\u1039\u100B", str)
                                                # TTA + subscript TTA
    str = re.sub("", "", str)
    ################ finished conversion

    ################ normalization
    str = normalize(str); 		# normalization

    ################# Handle Kinzi stuff
    str = re.sub("(?P<first>.)(?P<second>\u108D)", "\g<second>\g<first>", str)
                                                # KINZI and ANUSVARA

    # reorder KINZI
    my_regex = r"(?P<vowel>(" + vowel + r"))(?P<second>\u1064)"
    str = re.sub(my_regex, "\g<second>\g<vowel>", str)

    # reorder KINZI
    my_regex = r"(?P<medial>(" + medial + r"))(?P<second>\u1064)"
    str = re.sub(my_regex, "\g<second>\g<medial>", str)

    # reorder KINZI and consonant
    my_regex = r"(?P<cons>(" + consonants + r"))(?P<second>\u1064)"
    str = re.sub(my_regex, "\g<second>\g<cons>", str)

    # KINZI and VOWEL I
    my_regex = r"(?P<medial>(" + medial + r"))(?P<second>\u108B)"
    str = re.sub(my_regex, "\g<second>\g<medial>\u102D", str)

    # KINZI and VOWEL I
    my_regex = r"(?P<cons>(" + consonants + r"))(?P<second>\u108B)"
    str = re.sub(my_regex, "\g<second>\g<cons>\u102D", str)

    # KINZI and VOWEL II
    my_regex = r"(?P<medial>(" + medial + r"))(?P<second>\u108C)"
    str = re.sub(my_regex, "\g<second>\g<medial>\u102E", str)

    # KINZI and VOWEL II
    my_regex = r"(?P<cons>(" + consonants + r"))(?P<second>\u108C)"
    str = re.sub(my_regex, "\g<second>\g<cons>\u102E", str)

    str = re.sub("\u1064", "\u1004\u103A\u1039", str) # KINZI
    str = re.sub("\u108D", "\u1004\u103A\u1039", str)  # KINZI
    str = re.sub("\u108B", "\u1004\u103A\u1039", str)  # KINZI
    str = re.sub("\u108C", "\u1004\u103A\u1039", str)  # KINZI
    ################ finished Kinzi conversion

    return str;

################ normalization
# POST: normalized canonical order
def normalize(str):
    # VOWEL E + DIGIT ZERO => E + WA
    str = re.sub(r"(?P<vowel_e>\u1031)\u1040", "\g<vowel_e>\u101D", str)

    # normalize ASAT, ANUSVARA, LOWER DOT
    str = re.sub(r"(?P<first>(\u1036|\u1037|\u103A))(?P=first)", "\g<first>", str)

    # normalize vowels
    my_regex = r"(?P<vowels>(" + vowel + r"))(?P=vowels)"
    str = re.sub(my_regex, "\g<vowels>", str)

    # normalize vowels I and II
    str = re.sub(r"[\u102D\u102E](?P<vowels>(\u102D|\u102E))", "\g<vowels>", str)

    # reverse VOWEL E
    my_regex = r"(?P<vowels>(\u1031|\u1084))(?P<cons>(" + consonants + r"|" + shanConsonants + r"))"
    str = re.sub(my_regex, "\g<cons>\g<vowels>", str)

    # reverse Shan tones and ASAT (103A)
    my_regex = r"(?P<shan_tones>(" + shanTones + "))(?P<asat>\u103A)"
    str = re.sub(my_regex, "\g<asat>\g<shan_tones>", str)

    # reverse medial and vowel
    my_regex = r"(?P<vowel>(" + vowel + r"))(?P<medial>(" + medial + r"|" + shanMedial + r")+)"
    str = re.sub(my_regex, "\g<medial>\g<vowel>", str)

    # reverse (MEDIAL Y|R) and (MEDIAL W|H)
    str = re.sub(r"(?P<medial_wh>(\u103D|\u103E))(?P<medial_yr>(\u103B|\u103C))", "\g<medial_yr>\g<medial_wh>", str)

    # reverse vowel and subscript
    my_regex = r"(?P<vowel>(" + vowel + r"))(?P<virama>\u1039)(?P<cons>(" + consonants + r"|" + shanConsonants + r"))"
    str = re.sub(my_regex, "\g<virama>\g<cons>\g<vowel>", str)

    # reverse medial and ANUSVARA
    my_regex = r"(?P<anusvara>\u1036)(?P<medial>(" + medial + r")+)"
    str = re.sub(my_regex, "\g<medial>\g<anusvara>", str)

    # reverse medial and LOWER DOT
    my_regex = r"(?P<lower_dot>\u1037)(?P<medial>(" + medial + r")+)"
    str = re.sub(my_regex, "\g<medial>\g<lower_dot>", str)

    # reverse medial and Shan Final Y
    my_regex = r"(?P<finalY>\u1086)(?P<medial>(" + medial + r"|" + shanMedial + r")+)"
    str = re.sub(my_regex, "\g<medial>\g<finalY>", str)

    # reverse vowel and ANUSVARA
    my_regex = r"(?P<anusvara>\u1036)(?P<vowel>(" + vowel + r")+)"
    str = re.sub(my_regex, "\g<vowel>\g<anusvara>", str)

    # reverse vowel and LOWER DOT
    my_regex = r"(?P<lower_dot>\u1037)(?P<vowel>(" + vowel + r")+)"
    str = re.sub(my_regex, "\g<vowel>\g<lower_dot>", str)

    # reverse ANUSVARA and LOWER DOT
    str = re.sub("\u1037\u1036", "\u1036\u1037", str)

    # reverse LOWER DOT and [Visible VIRAMA (ASAT), Moh Ha, Visarga]
    str = re.sub(r"(?P<first>[\u103A|\u103E|\u1038]+)(?P<second>\u1037)", "\g<second>\g<first>", str)

    # reverse VOWEL U and (VOWEL I, VOWEL II, SIGN AI)
    str = re.sub(r"(?P<first>\u102F)(?P<second>(\u102D|\u102E|\u1032))", "\g<second>\g<first>", str)

    # reverse VOWEL UU and (VOWEL I, VOWEL II, SIGN AI)
    str = re.sub(r"(?P<first>\u1030)(?P<second>(\u102D|\u102E|\u1032))", "\g<second>\g<first>", str)

    ## comment out the following two rules for Karen
    # TALL AA preceeded by some consonants
    my_regex = r"[^\u1039](?P<consWithTallAA>(" + consonantsWithTallAA + r"))(?P<medialWaHa>[\u103D\u103E]*)(?P<vowel>(" + vowel + r")*)\u102C"
    str = re.sub(my_regex, "\g<consWithTallAA>\g<medialWaHa>\g<vowel>\u102B", str)
    str = re.sub("\u103B\u102B", "\u103B\u102C", str)       # MEDIAL Y + TALL AA => AA

    # replace DIGIT ZERO with LETTER WA if followed by vowels
    my_regex = r"\u1040(?P<first>(" + vowel + r"|" + medial + r"|\u1036|\u1037|\u103A))"
    str = re.sub(my_regex, "\u101D\g<first>", str)

    str = re.sub(r"\u1025\u102E", "\u1026", str)                # Myanmar Letter UU

    str = re.sub(r"\u1025\u1039", "\u1009\u1039", str)          # replace LETTER U with NYA

    # replace LETTER U with NYA
    my_regex = r"\u1025(?P<vowel_medial>(" + vowel + r"|" + medial + r"|\u103A))"
    str = re.sub(my_regex, "\u1009\g<vowel_medial>", str)

    #  normalize Shan tone marks
    my_regex = r"(?P<shan_tones>(" + shanTones + r"))(?P=shan_tones)"
    str = re.sub(my_regex, "\g<shan_tones>", str)

    ## this is to comply with UTN 11 ver. 4 (http://www.unicode.org/notes/tn11/UTN11_4.pdf)
    str = re.sub("\u103A\u1037", "\u1037\u103A", str)       # BURMESE ASAT
    str = re.sub("\u103A\u103E", "\u103E\u103A", str)       # MON ASAT
    str = re.sub("\u103A\u1082", "\u1082\u103A", str)       # MON ASAT
    return str

def main(fname):
    with open(fname) as f:
        content = f.read()
    f.close()
    content = zawgyi2uni5(content)
    outFName = os.path.dirname(fname) + '/' + os.path.splitext(os.path.basename(fname))[0] + '.out'
    outF = open(outFName, 'w', encoding='utf-8')
    outF.write(content)
    outF.close()

if __name__ == "__main__":
    if len(sys.argv) > 1:
        for fname in sys.argv[1:]:
            main(fname)
    else:
        print("Argument: files")

