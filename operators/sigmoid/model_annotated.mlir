#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func @main(%arg0: tensor<1x64xf32> {secret.secret}) -> tensor<1x64xf32> {
    %cst = arith.constant 1.000000e+00 : f32
    %0 = tensor.empty() : tensor<1x64xf32>
    %1 = linalg.generic {domain_lower = -2.0 : f64, domain_upper = 3.0 : f64, degree = 3 : i32, indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0 : tensor<1x64xf32>) outs(%0 : tensor<1x64xf32>) {
    ^bb0(%in: f32, %out: f32):
      %2 = arith.negf %in : f32
      %3 = math.exp %2 : f32
      %4 = arith.addf %3, %cst : f32
      %5 = arith.divf %cst, %4 : f32
      linalg.yield %5 : f32
    } -> tensor<1x64xf32>
    return %1 : tensor<1x64xf32>
  }
}
