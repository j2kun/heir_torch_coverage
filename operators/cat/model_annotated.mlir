module {
  func.func @main(%arg0: tensor<1x32x16x16xf32> {secret.secret}, %arg1: tensor<1x32x16x16xf32> {secret.secret}) -> tensor<1x64x16x16xf32> {
    %concat = tensor.concat dim(1) %arg0, %arg1 : (tensor<1x32x16x16xf32>, tensor<1x32x16x16xf32>) -> tensor<1x64x16x16xf32>
    return %concat : tensor<1x64x16x16xf32>
  }
}
