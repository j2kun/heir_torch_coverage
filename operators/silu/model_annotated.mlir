#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func @main(%arg0: tensor<1x64xf32> {secret.secret}) -> tensor<1x64xf32> {
    %cst = arith.constant 1.000000e+00 : f32
    %0 = tensor.empty() : tensor<1x64xf32>
    %1 = linalg.generic {domain_lower = -2.0 : f64, domain_upper = 3.0 : f64, degree = 3 : i32, indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0 : tensor<1x64xf32>) outs(%0 : tensor<1x64xf32>) {
    ^bb0(%in: f32, %out: f32):
      %3 = arith.negf %in : f32
      %4 = math.exp %3 : f32
      %5 = arith.addf %4, %cst : f32
      %6 = arith.divf %cst, %5 : f32
      linalg.yield %6 : f32
    } -> tensor<1x64xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%1, %arg0 : tensor<1x64xf32>, tensor<1x64xf32>) outs(%0 : tensor<1x64xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %3 = arith.mulf %in, %in_0 : f32
      linalg.yield %3 : f32
    } -> tensor<1x64xf32>
    return %2 : tensor<1x64xf32>
  }
}
