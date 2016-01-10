PLBASE = $(shell eval `swipl --dump-runtime-variables` && echo $$PLBASE)

all: docker-test

test: clone test-packs test-blog-core

test-packs: install-deps
	make -C alternative-router test
	make -C dict-schema test
	make -C docstore test
	make -C markdown test
	make -C rdet test
	make -C simple-template test
	make -C sort-dict test

test-blog-core: copy-blog-core-deps
	make -C blog-core test

clone:
	git clone https://github.com/rla/alternative-router.git alternative-router
	git clone https://github.com/rla/dict-schema.git dict-schema
	git clone https://github.com/rla/docstore docstore
	git clone https://github.com/rla/prolog-markdown.git markdown
	git clone https://github.com/rla/rdet.git rdet
	git clone https://github.com/rla/simple-template.git simple-template
	git clone https://github.com/rla/sort-dict.git sort-dict
	git clone https://github.com/rla/blog-core.git blog-core

install-deps:
	swipl -g "Os=[interactive(false)],pack_install(lambda, Os),halt" -t "halt(1)"
	swipl -g "Os=[interactive(false)],pack_install(smtp, Os),halt" -t "halt(1)"

copy-blog-core-deps:
	mkdir -p ${PLBASE}/pack
	cp -r alternative-router ${PLBASE}/pack/arouter
	cp -r dict-schema ${PLBASE}/pack/dict_schema
	cp -r docstore ${PLBASE}/pack/docstore
	cp -r markdown ${PLBASE}/pack/markdown
	cp -r simple-template ${PLBASE}/pack/simple_template
	cp -r sort-dict ${PLBASE}/pack/sort_dict

docker-build:
	docker build -t=pack-tests .

docker-test: docker-build
	docker run --rm -i -t pack-tests

.PHONY: all clone test test-packs install-deps test-blog-core copy-blog-core-deps docker-build docker-test
