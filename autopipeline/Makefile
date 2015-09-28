CXXFLAGS ?= -O3 -std=c++11
LDLIBS ?= -lchdl

all: autopipeline.vcd # before.ps after.ps

%.ps : %.dot
	dot -Tps -o $@ $<

before.dot after.dot autopipeline.vcd : autopipeline
	./autopipeline

autopipeline: autopipeline.cpp

clean:
	rm -f autopipeline *.vcd *.dot *.ps *~
