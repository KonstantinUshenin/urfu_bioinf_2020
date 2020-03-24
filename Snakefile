import os
CHANNELS = os.listdir('dataset')

def get_articles(channel_name):
    res = os.listdir(f'dataset/{channel_name}/article')
    res = list(map(lambda x: x[:-4], res))
    return res

rule cat_indexs:
    input:
        [f"dataset/{channel}/articles_indexes/{article}.txt" for channel in CHANNELS for article in get_articles(channel)]
    output:
        "indexes.txt"
    shell:
        "cat {input} >> {output}"


rule articles_indexs:
    input:
        "dataset/{channel}/article/{article}.pdf"
    output:
        temp("dataset/{channel}/articles_indexes/{article}.txt")
    notebook:
        "notebook_template/articles_indexs.ipynb"
