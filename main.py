import argparse
import fitz

parser = argparse.ArgumentParser(description='Convert PDF page to PNG image.')
parser.add_argument('pdf', type=str, help='Path to PDF file to convert')
parser.add_argument('png', type=str, help='Path to PNG file to produce')

args = parser.parse_args()
doc = fitz.open(args.pdf)
page = doc[0]
pix = page.get_pixmap()
pix.save(args.png)
