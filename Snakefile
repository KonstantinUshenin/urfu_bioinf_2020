import os
CHANNELS = os.listdir('dataset')

def get_articles(channel_name):
    res = os.listdir('dataset/{}/article'.format(channel_name))
    res = list(map(lambda x: x[:-4], res))
    return res


rule plot_tree:
	input:
		"workflow/tree.dnd"
	notebook:
		"notebook_template/plot_tree.ipynb"


rule tree_builder:
	input:
		"workflow/all_sequences.aln"
	output:
		temp("workflow/tree.dnd"),
		temp("workflow/score.txt")
	notebook:
		"notebook_template/tree_builder.ipynb"


rule global_alignment:
	input:
		"workflow/all_sequences.fasta"
	output:
		temp("workflow/all_sequences.aln")
	notebook:
		"notebook_template/global_alignment.ipynb"


rule request:
	input:
		"workflow/clear_indexs.csv"
	output:
		temp("workflow/all_sequences.fasta")
	notebook:
		"notebook_template/request_indexes.ipynb"


rule fusion:
	input:
		"indexs.txt",
		"fixed.txt"
	output:
		temp("workflow/clear_indexs.csv")
	notebook:
		"notebook_template/fusion.ipynb"


rule cat_indexs:
    input:
        [f"dataset/{channel}/articles_indexs/{article}.txt" for channel in CHANNELS for article in get_articles(channel)]
    output:
        temp("indexs.txt")
    shell:
        "cat {input} >> {output}"


rule articles_indexs:
    input:
        "dataset/{channel}/article/{article}.pdf"
    output:
        temp("dataset/{channel}/articles_indexs/{article}.txt")
    notebook:
        "notebook_template/articles_indexs.ipynb"

