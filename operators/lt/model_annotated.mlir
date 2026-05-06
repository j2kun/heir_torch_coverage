#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func @main(%arg0: tensor<1x64xf32> {secret.secret}, %arg1: tensor<1x64xf32> {secret.secret}) -> tensor<1x64xi1> {
    %0 = tensor.empty() : tensor<1x64xi1>
    %1 = linalg.generic {domain_lower = -2.0 : f64, domain_upper = 3.0 : f64, degree = 3 : i32, indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0, %arg1 : tensor<1x64xf32>, tensor<1x64xf32>) outs(%0 : tensor<1x64xi1>) {
    ^bb0(%in: f32, %in_0: f32, %out: i1):
      %2 = arith.cmpf olt, %in, %in_0 : f32
      linalg.yield %2 : i1
    } -> tensor<1x64xi1>
    return %1 : tensor<1x64xi1>
  }
}
