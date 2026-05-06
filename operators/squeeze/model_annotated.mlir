module {
  func.func @main(%arg0: tensor<1x3x1x16xf32> {secret.secret}) -> tensor<3x16xf32> {
    %collapsed = tensor.collapse_shape %arg0 [[0, 1], [2, 3]] : tensor<1x3x1x16xf32> into tensor<3x16xf32>
    return %collapsed : tensor<3x16xf32>
  }
}
