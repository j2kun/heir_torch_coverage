module {
  func.func @main(%arg0: tensor<1x3x16x16xf32>) -> tensor<1x16x3x16xf32> {
    %0 = tensor.empty() : tensor<1x16x3x16xf32>
    %transposed = linalg.transpose ins(%arg0 : tensor<1x3x16x16xf32>) outs(%0 : tensor<1x16x3x16xf32>) permutation = [0, 2, 1, 3] 
    return %transposed : tensor<1x16x3x16xf32>
  }
}
