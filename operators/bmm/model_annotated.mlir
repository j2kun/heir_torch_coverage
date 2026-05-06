module {
  func.func @main(%arg0: tensor<2x64x32xf32> {secret.secret}, %arg1: tensor<2x32x10xf32> {secret.secret}) -> tensor<2x64x10xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %0 = tensor.empty() : tensor<2x64x10xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<2x64x10xf32>) -> tensor<2x64x10xf32>
    %2 = linalg.batch_matmul ins(%arg0, %arg1 : tensor<2x64x32xf32>, tensor<2x32x10xf32>) outs(%1 : tensor<2x64x10xf32>) -> tensor<2x64x10xf32>
    return %2 : tensor<2x64x10xf32>
  }
}
