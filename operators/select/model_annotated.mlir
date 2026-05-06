module {
  func.func @main(%arg0: tensor<1x64xf32> {secret.secret}) -> tensor<1xf32> {
    %extracted_slice = tensor.extract_slice %arg0[0, 0] [1, 1] [1, 1] : tensor<1x64xf32> to tensor<1x1xf32>
    %collapsed = tensor.collapse_shape %extracted_slice [[0, 1]] : tensor<1x1xf32> into tensor<1xf32>
    return %collapsed : tensor<1xf32>
  }
}
