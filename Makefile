JAVA_INCLUDE=/System/Library/Frameworks/JavaVM.framework/Headers/

SUFFIX=dylib

MXNET_SRCS=src/executor.cxx src/kvstore.cxx src/operator.cxx src/symbol.cxx src/io.cxx src/ndarray.cxx src/optimizer.cxx

MXNET_OBJS=$(MXNET_SRCS:.cxx=.o)

SRCS=mlp.cxx

OBJS=$(SRCS:.cxx=.o)

TARGET=libmlp.$(SUFFIX)

CXX=g++

INCLUDE=-I$(JAVA_INCLUDE) -Iinclude

LDFLAGS=-L./lib -lmxnet

CXXFLAGS=-std=c++11 -O3

all: swig $(MXNET_OBJS) $(OBJS) $(TARGET)

$(MXNET_OBJS): %.o : %.cxx
	$(CXX) -c -fPIC $(CXXFLAGS) $(INCLUDE) $< -o $@

$(OBJS): %.o : %.cxx
	$(CXX) -c -fPIC $(CXXFLAGS) $(INCLUDE) $< -o $@

swig:
	swig -c++ -java -package water.gpu mlp.i

mlp_wrap.o:
	$(CXX) -c -fPIC $(CXXFLAGS) $(INCLUDE) mlp_wrap.cxx -o mlp_wrap.o

$(TARGET): mlp_wrap.o
	$(CXX) -shared $(MXNET_OBJS) $(OBJS) mlp_wrap.o -o $(TARGET) -L./lib -lmxnet

clean:
	rm -rf $(MXNET_OBJS) $(OBJS) $(TARGET) *.java *_wrap.cxx *_wrap.o 
