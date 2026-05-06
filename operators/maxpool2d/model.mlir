module {
  func.func @main(%arg0: tensor<1x3x16x16xf32>) -> tensor<1x3x8x8xf32> {
    %cst = arith.constant 0xFF800000 : f32
    %0 = tensor.empty() : tensor<1x3x8x8xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<1x3x8x8xf32>) -> tensor<1x3x8x8xf32>
    %2 = tensor.empty() : tensor<2x2xf32>
    %3 = linalg.pooling_nchw_max {dilations = dense<1> : vector<2xi64>, strides = dense<2> : vector<2xi64>} ins(%arg0, %2 : tensor<1x3x16x16xf32>, tensor<2x2xf32>) outs(%1 : tensor<1x3x8x8xf32>) -> tensor<1x3x8x8xf32>
    return %3 : tensor<1x3x8x8xf32>
  }
}
