#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
module {
  func.func @main(%arg0: tensor<1x4x16xf32> {secret.secret}) -> tensor<1x4x8xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 2.000000e+00 : f32
    %0 = tensor.empty() : tensor<1x4x8xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<1x4x8xf32>) -> tensor<1x4x8xf32>
    %2 = tensor.empty() : tensor<2xf32>
    %3 = linalg.pooling_ncw_sum {dilations = dense<1> : vector<1xi64>, strides = dense<2> : vector<1xi64>} ins(%arg0, %2 : tensor<1x4x16xf32>, tensor<2xf32>) outs(%1 : tensor<1x4x8xf32>) -> tensor<1x4x8xf32>
    %4 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%3 : tensor<1x4x8xf32>) outs(%0 : tensor<1x4x8xf32>) {
    ^bb0(%in: f32, %out: f32):
      %5 = arith.divf %in, %cst_0 : f32
      linalg.yield %5 : f32
    } -> tensor<1x4x8xf32>
    return %4 : tensor<1x4x8xf32>
  }
}
