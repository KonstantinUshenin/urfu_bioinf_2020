import os
CHANNELS = os.listdir('dataset')
ARTICLES = [os.listdir(f'dataset/{channel}/article') for channel in CHANNELS]

rule all:
	input:
		"dataset/{channel}"
	output:
		"workflow/{channel}"
	shell:
		"mkdir {output}"

rule articles_indexs:
    input:
        "dataset/{channel}/article/{article}.pdf"
    output:
        "dataset/{channel}/articles_indexs/{article}.txt"
    notebook:
        "notebook_template/articles_indexs.ipynb"

rule cat_indexs:
    input:
        expand("dataset/{channel}/articles_indexs/{article}.txt", channel=CHANNELS, article=ARTICLES) 
    output:
        "indexes.txt"
    shell:
        "cat {input} >> {output}"

