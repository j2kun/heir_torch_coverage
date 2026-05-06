#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d0)>
module {
  func.func @main(%arg0: tensor<1x64xf32> {secret.secret}) -> tensor<1xf32> {
    %cst = arith.constant 1.000000e+00 : f32
    %0 = tensor.empty() : tensor<1xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<1xf32>) -> tensor<1xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "reduction"]} ins(%arg0 : tensor<1x64xf32>) outs(%1 : tensor<1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %3 = arith.mulf %in, %out : f32
      linalg.yield %3 : f32
    } -> tensor<1xf32>
    return %2 : tensor<1xf32>
  }
}
