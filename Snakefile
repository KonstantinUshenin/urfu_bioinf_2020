configfile: "config.yml"
import os

for key in config:
    if key in os.environ:
        config[key] = os.environ.get(key)

CHANNELS = list(filter(lambda x: x in config['channels'], os.listdir('dataset')))


def get_articles(channel_name):
    res = os.listdir('dataset/{}/article'.format(channel_name))
    res = filter(lambda x: not x.startswith('.'), res)
    res = map(lambda x: os.path.splitext(x)[0], res)
    res = list(res)
    return res
    
channel_article_pair = []
for channel in CHANNELS:
    for article in get_articles(channel):
        channel_article_pair.append((channel, article))

rule all:
    input:
        expand("workflow/{channel}/plot_tree/tree.png", channel=CHANNELS),
        expand("workflow/{channel}/plot_tree/plot_tree.pdf", channel=CHANNELS)
  
rule article_index:
    input:
        "dataset/{channel}/article/{article}.html"
    output:
        "workflow/{channel}/article_index/{article}.txt"
    shell:
        'python notebook_template/article_index.py {input} {output}'

rule request_index:
    input:
        "dataset/{channel}/request.txt"
    output:
        "workflow/{channel}/request_index/index.txt"
    shell:
        'python utils/cat.py "{input}" > "{output}"'
        
rule fusion__join_all_index:
    input:
        expand("workflow/{tmp[0]}/article_index/{tmp[1]}.txt", tmp=channel_article_pair),
        "workflow/{channel}/request_index/index.txt"
    output:
        "workflow/{channel}/fusion/all_index.txt"
    run:
        for file_in in input:
            if "workflow/{}/".format(wildcards.channel) in file_in:
                file_out = output
                shell('python utils/cat.py "{file_in}" >> "{file_out}"')
                shell('python utils/uniq.py "{file_out}" "{file_out}"')
  
rule fusion:
    input:
        "workflow/{channel}/fusion/all_index.txt",
        "dataset/{channel}/fixes.txt"
    output:
        "workflow/{channel}/fusion/clear_index.txt"
    run:
        file_in_1 = input[0]
        file_in_2 = input[1]
        file_out = output
        shell('python utils/cat.py "{file_in_1}" "{file_in_2}" > "{file_out}"')
  
rule request_sequence:
    input:
        "workflow/{channel}/fusion/clear_index.txt"
    output:
        "workflow/{channel}/request_sequence/all_sequence.fasta"
    run:
        main_db = config['main_db']
        shell("python notebook_template/request_sequence.py {input} {output} {main_db}")
  
rule global_alignment:
    input:
        "workflow/{channel}/request_sequence/all_sequence.fasta"
    output:
        "workflow/{channel}/request_sequence/all_sequence.aln",
        "workflow/{channel}/request_sequence/all_sequence.dnd"
    run:
        shell('clustalw2 -infile="{input}"')
        

rule R_plot_tree:
    input:
        "workflow/{channel}/tree_builder/align.nex"
    output:
        "workflow/{channel}/plot_tree/plot_tree.pdf"
    shell:
        "Rscript --vanilla notebook_template/r_scr.R {input} {output}"


rule convert_dnd:
    input:
        "workflow/{channel}/tree_builder/tree.dnd"
    output:
        "workflow/{channel}/tree_builder/align.nex"
    shell:
        "python3 notebook_template/dnd_convert.py {input} {output}"


rule tree_builder:
    input:
        "workflow/{channel}/request_sequence/all_sequence.dnd"
    output:
        "workflow/{channel}/tree_builder/tree.dnd"
    shell:
        'python utils/cat.py "{input}" > "{output}"'
  
rule plot_tree:
    input:
        "workflow/{channel}/tree_builder/tree.dnd"
    output:
        "workflow/{channel}/plot_tree/tree.png"
    shell:
        "python3 notebook_template/plot_tree.py {input} {output}"









	
