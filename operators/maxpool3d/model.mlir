#map = affine_map<(d0, d1, d2, d3, d4, d5, d6, d7) -> (d0, d1, d2 * 2 + d5, d3 * 2 + d6, d4 * 2 + d7)>
#map1 = affine_map<(d0, d1, d2, d3, d4, d5, d6, d7) -> (d5, d6, d7)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5, d6, d7) -> (d0, d1, d2, d3, d4)>
module {
  func.func @main(%arg0: tensor<1x3x4x4x4xf32>) -> tensor<1x3x2x2x2xf32> {
    %cst = arith.constant 0xFF800000 : f32
    %0 = tensor.empty() : tensor<1x3x2x2x2xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<1x3x2x2x2xf32>) -> tensor<1x3x2x2x2xf32>
    %2 = tensor.empty() : tensor<2x2x2xf32>
    %3 = linalg.generic {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "parallel", "parallel", "parallel", "reduction", "reduction", "reduction"]} ins(%arg0, %2 : tensor<1x3x4x4x4xf32>, tensor<2x2x2xf32>) outs(%1 : tensor<1x3x2x2x2xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %4 = arith.maximumf %in, %out : f32
      linalg.yield %4 : f32
    } -> tensor<1x3x2x2x2xf32>
    return %3 : tensor<1x3x2x2x2xf32>
  }
}
