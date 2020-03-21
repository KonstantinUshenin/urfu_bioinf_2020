rule all:
	input:
		"dataset/{channel}"
	output:
		"workflow/{channel}"
	shell:
		"mkdir {output}"
