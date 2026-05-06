module {
  func.func @main(%arg0: tensor<1x64xf32>) -> (tensor<1x32xf32>, tensor<1x32xf32>) {
    %extracted_slice = tensor.extract_slice %arg0[0, 0] [1, 32] [1, 1] : tensor<1x64xf32> to tensor<1x32xf32>
    %extracted_slice_0 = tensor.extract_slice %arg0[0, 32] [1, 32] [1, 1] : tensor<1x64xf32> to tensor<1x32xf32>
    return %extracted_slice, %extracted_slice_0 : tensor<1x32xf32>, tensor<1x32xf32>
  }
}
