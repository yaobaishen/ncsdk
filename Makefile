
ifneq ($(findstring movidius, $(PYTHONPATH)), movidius)
	export PYTHONPATH:=/opt/movidius/caffe/python:/opt/movidius/mvnc/python:$(PYTHONPATH)
endif


.PHONY: help
help:
	@echo "\nmake help starting."
	@echo "Make targets are:"
	@echo "  make help - shows this message"
	@echo "  make install - Installs the ncsdk."
	@echo "  make examples - makes the ncsdk examples."
	@echo "  make uninstall - uninstalls the ncsdk."
	@echo "  make clean - removes targets and intermediate files." 

.PHONY: all
all: install examples

.PHONY: opencv
opencv: 
	./install-opencv.sh

.PHONY: prereqs
prereqs:
	@sed -i 's/\r//' ncsdk.conf
	@if [ -e ncsdk_redirector.txt ] ; \
	then \
		@sed -i 's/\r//' ncsdk_redirector.txt ; \
	fi

	@sed -i 's/\r//' install.sh
	@sed -i 's/\r//' uninstall.sh
	@sed -i 's/\r//' README.md
	@chmod +x install.sh
	@chmod +x uninstall.sh
	@chmod +x install-opencv.sh

.PHONY: install
install: prereqs
	@echo "\nmake install starting."
	./install.sh

.PHONY: uninstall
uninstall: prereqs
	@echo "\nmake uninstall starting."
	./uninstall.sh

.PHONY: examples
examples: prereqs opencv
	@echo "\nmake examples starting."
	(cd examples; make)

.PHONY: runexamples
runexamples: prereqs opencv
	@echo "\nmake examples starting."
	(cd examples; make run)

.PHONY: clean
clean:
	@echo "\nmake clean starting."
	(cd examples; make clean)


