import vim
import re
import bibtexparser


def parse_bibtex(fname):
    col = {'black': 'ESCCODE[30m',
           'red': 'ESCCODE[31m',
           'green': 'ESCCODE[32m',
           'yellow': 'ESCCODE[33m',
           'blue': 'ESCCODE[34m',
           'magenta': 'ESCCODE[35m',
           'cyan': 'ESCCODE[36m',
           'white': 'ESCCODE[37m'}
    bold = {'black': 'ESCCODE[30;1m',
            'red': 'ESCCODE[31;1m',
            'green': 'ESCCODE[32;1m',
            'yellow': 'ESCCODE[33;1m',
            'blue': 'ESCCODE[34;1m',
            'magenta': 'ESCCODE[35;1m',
            'cyan': 'ESCCODE[36;1m',
            'white': 'ESCCODE[37;1m'}
    reset = 'ESCCODE[0m'

    with open(fname) as bf:
        parser = bibtexparser.bparser.BibTexParser(common_strings=True)
        bd = bibtexparser.load(bf, parser=parser)

    bib = []
    for e in bd.entries:
        nodes = ['ENTRYTYPE', 'journal', 'year', 'title', 'ID']
        d = {}
        for n in nodes:
            d[n.lower()] = e.get(n, None)
        if d['title'] is None or d['id'] is None:
            continue
        d['title'] = re.sub("[}'\\\{]", '', d['title']).strip()
        d['id'] = '[{}]'.format(d['id'])

        author = e.get('author', '').split(' and ')
        d['author'] = []
        for au in author:
            if au:
                last, first = au.split(', ')
                d['author'].append('{}. {}'.format(first[0], last))
            else:
                d['author'] = []
                continue
        if len(d['author']) > 2:
            d['author'] = [d['author'][0], d['author'][-1], 'et al.']
        d['author'] = ', '.join(d['author'])

        nodes = ['entrytype', 'author', 'journal', 'year', 'title', 'id']
        colors = [col['yellow'], bold['blue'], bold['yellow'],
                  col['magenta'], col['white'], bold['green']]
        line = []
        for n, c in zip(nodes, colors):
            if d[n]:
                line.append(str(c) + d[n] + str(reset))
        bib.append('  '.join(line))
    vim.command('let l:return = {}'.format(str(bib)))
    return bib


if __name__ == "__main__":
    pass
