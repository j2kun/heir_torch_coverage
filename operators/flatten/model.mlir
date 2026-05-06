module {
  func.func @main(%arg0: tensor<1x3x16x16xf32>) -> tensor<1x768xf32> {
    %collapsed = tensor.collapse_shape %arg0 [[0], [1, 2, 3]] : tensor<1x3x16x16xf32> into tensor<1x768xf32>
    return %collapsed : tensor<1x768xf32>
  }
}
