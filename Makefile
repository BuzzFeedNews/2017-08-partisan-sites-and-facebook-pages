.PHONY: default clear reproduce

default:

clear:
	rm -r output
	mkdir output

reproduce: clear
	cd notebooks && find . -type f -maxdepth 1 -exec jupyter nbconvert \
		--ExecutePreprocessor.timeout=-1 \
		--ExecutePreprocessor.kernel_name=python3 \
		--to notebook \
		--output {} \
		--execute {} \;
