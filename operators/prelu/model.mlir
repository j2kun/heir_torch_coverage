#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (0)>
module {
  func.func @main(%arg0: tensor<1x64xf32>) -> tensor<1x64xf32> {
    %cst = arith.constant dense<2.500000e-01> : tensor<1xf32>
    %cst_0 = arith.constant 0.000000e+00 : f64
    %0 = tensor.empty() : tensor<1x64xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map1, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0, %cst : tensor<1x64xf32>, tensor<1xf32>) outs(%0 : tensor<1x64xf32>) {
    ^bb0(%in: f32, %in_1: f32, %out: f32):
      %5 = arith.mulf %in, %in_1 : f32
      linalg.yield %5 : f32
    } -> tensor<1x64xf32>
    %2 = tensor.empty() : tensor<1x64xi1>
    %3 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0 : tensor<1x64xf32>) outs(%2 : tensor<1x64xi1>) {
    ^bb0(%in: f32, %out: i1):
      %5 = arith.extf %in : f32 to f64
      %6 = arith.cmpf olt, %5, %cst_0 : f64
      linalg.yield %6 : i1
    } -> tensor<1x64xi1>
    %4 = linalg.generic {indexing_maps = [#map, #map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%3, %1, %arg0 : tensor<1x64xi1>, tensor<1x64xf32>, tensor<1x64xf32>) outs(%0 : tensor<1x64xf32>) {
    ^bb0(%in: i1, %in_1: f32, %in_2: f32, %out: f32):
      %5 = arith.select %in, %in_1, %in_2 : f32
      linalg.yield %5 : f32
    } -> tensor<1x64xf32>
    return %4 : tensor<1x64xf32>
  }
}
