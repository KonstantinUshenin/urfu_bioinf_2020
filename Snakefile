import os
CHANNELS = os.listdir('dataset')

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
        expand("workflow/{channel}/plot_tree/tree.png", channel=CHANNELS)
  
rule article_index:
    input:
        "dataset/{channel}/article/{article}.pdf"
    output:
        "workflow/{channel}/article_index/{article}.txt"
    shell:
        'cat "{input}" > "{output}"'
  
rule request_index:
    input:
        "dataset/{channel}/request.txt"
    output:
        "workflow/{channel}/request_index/index.txt"
    shell:
        'cat "{input}" > "{output}"'
        
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
                shell('cat "{file_in}" >> "{file_out}"')
  
rule fusion:
    input:
        "workflow/{channel}/fusion/all_index.txt",
        "dataset/{channel}/fixes.txt"
    output:
        "workflow/{channel}/fusion/clear_index.csv"
    run:
        file_in_1 = input[0]
        file_in_2 = input[1]
        file_out = output
        shell('cat "{file_in_1}" "{file_in_2}" >> "{file_out}"')
  
rule request_sequence:
    input:
        "workflow/{channel}/fusion/clear_index.csv"
    output:
        "workflow/{channel}/request_sequence/all_sequence.fasta"
    shell:
        "python3 notebook_template/request_sequence.py {input} {output}"
    #shell:
    #    'cat "{input}" > "{output}"'
  
rule global_alignment:
    input:
        "workflow/{channel}/request_sequence/all_sequence.fasta"
    output:
        "workflow/{channel}/global_alignment/all_sequence.aln"
    shell:
        'cat "{input}" > "{output}"'
        
rule tree_builder:
    input:
        "workflow/{channel}/global_alignment/all_sequence.aln"
    output:
        "workflow/{channel}/tree_builder/tree.dnd"
    shell:
        'cat "{input}" > "{output}"'
  
rule plot_tree:
    input:
        "workflow/{channel}/tree_builder/tree.dnd"
    output:
        "workflow/{channel}/plot_tree/tree.png"
    shell:
        'cat "{input}" > "{output}"'