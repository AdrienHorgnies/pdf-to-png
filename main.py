import argparse
import fitz

parser = argparse.ArgumentParser(description='Convert PDF page to PNG image.')
parser.add_argument('pdf', type=str, help='Path to PDF file to convert')
parser.add_argument('png', type=str, help='Path to PNG file to produce')
parser.add_argument('--dpi', type=int, default=300, help='DPI for the PNG')
parser.add_argument('--page', type=int, default=0, help='Page to convert')

args = parser.parse_args()
doc = fitz.open(args.pdf)
page = doc[args.page]
zoom = args.dpi / 72
mat = fitz.Matrix(zoom, zoom)
pix = page.get_pixmap(matrix=mat)
pix.save(args.png)
