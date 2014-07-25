# Usage example

    use Encode;
    use burmeseunicode;
    $foo = "text in some font encoding";      # the text we want to convert
    $foo = Encode::decode_utf8($foo);     # from bytes to UTF8 encoding
    $foo = soas2uni5($foo);           # from SOAS Myanmar to Uni 5.1
    $foo = uni4touni5($foo);          # from Burmese Unicode 4.1 to 5.1
    $foo = myazedi2uni5($foo);            # from Myazedi to Uni 5.1
    $foo = Encode::encode_utf8($foo);     # back to byte

# How to run the supplied run.pl file 

- Please make changes accordingly what converter routine you want to use in run.pl. It's ava2uni5 for now.
- Input files in plain text format have to be put in input/ folder. Then, just run

	perl run.pl

- Output files will be in output/ folder.


