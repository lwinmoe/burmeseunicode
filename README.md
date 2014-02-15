# Usage example

    use Encode;
    use burmeseunicode;
    $foo = "text in some font encoding";      # the text we want to convert
    $foo = Encode::decode_utf8($foo);     # from bytes to UTF8 encoding
    $foo = soas2uni5($foo);           # from SOAS Myanmar to Uni 5.1
    $foo = uni4touni5($foo);          # from Burmese Unicode 4.1 to 5.1
    $foo = myazedi2uni5($foo);            # from Myazedi to Uni 5.1
    $foo = Encode::encode_utf8($foo);     # back to bytes

# Unicode Technical Specification (UTN)

To comply with [UTN 11, version 4](http://www.unicode.org/notes/tn11/UTN11_4.pdf), you will need to reorder the diacratics u103A and [u1037, u103E, u1082]. The conversion is implemented in convert.pl.
