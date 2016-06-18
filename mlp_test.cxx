
#include "mlp.hpp"

int main() {

  MLPNative m = MLPNative();
  mx_float* aptr_x = new mx_float[128 * 38];
  mx_float* aptr_y = new mx_float[128];

  // we make the data by hand, in 10 classes, with some pattern
  for (int i = 0; i < 128; i++) {
    for (int j = 0; j < 38; j++) {
      aptr_x[i * 38 + j] = i % 10 * 1.0f;
    }
    aptr_y[i] = i % 10;
  }
  int lsize[1] = {10};
  m.setLayers(lsize, 1, 2);
  char * act[1] = {"tanh"};
  m.setAct(act);
  m.build_mlp();
/*
  int dimX[2] = {128, 38};
  m.setX(aptr_x, dimX, 2);
  m.setLabel(aptr_y, 128);
  m.buildnn();
  std::cout << m.train(1000, true) << std::endl;*/
}