import ruamel.yaml
from ruamel.yaml.scalarstring import LiteralScalarString
import sys, textwrap, os

def LS(s):
    return LiteralScalarString(textwrap.dedent(s))

def FSlist(l): 
    from ruamel.yaml.comments import CommentedSeq
    cs = CommentedSeq(l)
    cs.fa.set_flow_style()
    return cs

def Quoted(s):
    return ruamel.yaml.scalarstring.DoubleQuotedScalarString(s)

# check for cards*.typ files and generate the list of files
files = os.listdir('.')
files = [f for f in files if f.startswith('cards') and f.endswith('.typ')]

# generate the list of render types by checking render.typ 
render_types = []
with open('render.typ', 'r') as f:
    # search for 'render_type == "' and extract the value between the quotes
    for line in f:
        if 'render_type == "' in line:
            render_types.append(line.split('"')[1])


steps = [
  {
    'name': 'Checkout',
    'uses': 'actions/checkout@v4'
  },
  {
    'name': 'Render Rules',
    'uses': 'leana8959/typst-action@main',
    'with': {
      'source_file': LS("""\
        Game of Intrigue.typ
      """),
      'options': LS("""\
        --input=render_type=""" + render_types[0] + """
      """)
    }
  },
  {
    'run': LS("""\
      mkdir -p assets
      mv Game\\ of\\ Intrigue.pdf assets/Game\\ of\\ Intrigue.pdf
    """)
  }
]

for render_type in render_types:
  steps.append({
    'name': 'Render ' + " ".join(map(lambda x: x.capitalize(), render_type.split("_"))),
    'uses': 'leana8959/typst-action@main',
    'with': {
      'source_file': LS('\n'.join(files)),
      'options': LS("""\
        --input=render_type=""" + render_type + """
      """)
    }
  })
  steps.append({
    'run': LS("""\
      mkdir -p assets/cards/""" + render_type + """
      mv cards.pdf assets/cards/""" + render_type + """/cards.pdf
      mv cards_abstract.pdf assets/cards/""" + render_type + """/cards_abstract.pdf
    """)
  })

steps.append({
  'name': 'Upload Files',
  'uses': 'actions/upload-artifact@v4',
  'with': {
    'name': 'Game of Intrigue',
    'path': Quoted('assets/**')
  }
})
steps.append({
  'name': 'Zip for Release',
  'run': 'zip -r assets.zip assets'
})
steps.append({
  'name': 'Release',
  'uses': 'softprops/action-gh-release@v2',
  'if': "github.ref_type == 'tag'",
  'with': {
    'name': Quoted('${{ github.ref_name }}'),
    'files': Quoted('assets.zip')
  }
})
    

d = {
  'name':'Build and Release',
  'on': FSlist(['push', 'workflow_dispatch']),
  'permissions': {
    'contents': 'write'
  },
  'jobs': {
    'build': {
      'env': {
        'TYPST_FONT_PATHS': './fonts'
      },
      'runs-on': 'ubuntu-latest',
      'steps': steps
    }
  }
}

yaml = ruamel.yaml.YAML()
yaml.default_flow_style = False
yaml.preserve_quotes = True
yaml.indent(mapping=2, sequence=4, offset=2)
with open('.github/workflows/main.yaml', 'w') as yaml_file:
  yaml.dump(d, yaml_file)