#map = affine_map<(d0, d1, d2, d3, d4) -> (d0, d1, d2, d3, d4)>
module {
  func.func @main(%arg0: tensor<1x4x4x4x4xf32>) -> tensor<1x4x2x2x2xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 8.000000e+00 : f32
    %0 = tensor.empty() : tensor<2x2x2xf32>
    %1 = tensor.empty() : tensor<1x4x4x4x4xf32>
    %transposed = linalg.transpose ins(%arg0 : tensor<1x4x4x4x4xf32>) outs(%1 : tensor<1x4x4x4x4xf32>) permutation = [0, 2, 3, 4, 1] 
    %2 = tensor.empty() : tensor<1x2x2x2x4xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<1x2x2x2x4xf32>) -> tensor<1x2x2x2x4xf32>
    %4 = linalg.pooling_ndhwc_sum {dilations = dense<1> : vector<3xi64>, strides = dense<2> : vector<3xi64>} ins(%transposed, %0 : tensor<1x4x4x4x4xf32>, tensor<2x2x2xf32>) outs(%3 : tensor<1x2x2x2x4xf32>) -> tensor<1x2x2x2x4xf32>
    %5 = tensor.empty() : tensor<1x4x2x2x2xf32>
    %transposed_1 = linalg.transpose ins(%4 : tensor<1x2x2x2x4xf32>) outs(%5 : tensor<1x4x2x2x2xf32>) permutation = [0, 4, 1, 2, 3] 
    %6 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel", "parallel", "parallel"]} ins(%transposed_1 : tensor<1x4x2x2x2xf32>) outs(%5 : tensor<1x4x2x2x2xf32>) {
    ^bb0(%in: f32, %out: f32):
      %7 = arith.divf %in, %cst_0 : f32
      linalg.yield %7 : f32
    } -> tensor<1x4x2x2x2xf32>
    return %6 : tensor<1x4x2x2x2xf32>
  }
}
