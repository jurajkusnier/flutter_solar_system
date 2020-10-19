fileName = "lib/main.dart"

def minify(text):
    minified = text.replace('\n','')
    minified = minified.replace('\t',' ')
    while '  ' in minified:
        minified = minified.replace('  ',' ')
    for symbol in ['(',')',',','=','>','<',';','+','-','*','/','{','}','[',']',':','.']:
        minified = minified.replace(symbol + ' ',symbol)
        minified = minified.replace(' ' + symbol,symbol)
    return minified

with open(fileName, "rt") as fIn:
    minified = minify(fIn.read())
    with open(fileName, "wt") as fOut:
        fOut.write(minified)



