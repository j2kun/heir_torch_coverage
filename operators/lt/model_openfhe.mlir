!cc = !openfhe.crypto_context
!ct = !openfhe.ciphertext
!params = !openfhe.cc_params
!pk = !openfhe.public_key
!pt = !openfhe.plaintext
!sk = !openfhe.private_key
#layout = #tensor_ext.layout<"{ [i0, i1] -> [ct, slot] : i0 = 0 and ct = 0 and (-i1 + slot) mod 64 = 0 and 0 <= i1 <= 63 and 0 <= slot <= 1023 }">
#original_type = #tensor_ext.original_type<originalType = tensor<1x64xi1>, layout = #layout>
module attributes {backend.openfhe, scheme.actual_slot_count = 16384 : i64, scheme.ckks, scheme.requested_slot_count = 1024 : i64} {
  func.func private @_assign_layout_10373591793897889884(%arg0: tensor<1x64xf32>) -> tensor<1x1024xf32> attributes {client.pack_func = {func_name = "main"}} {
    %c1024_i32 = arith.constant 1024 : i32
    %c1_i32 = arith.constant 1 : i32
    %c0_i32 = arith.constant 0 : i32
    %cst = arith.constant dense<0.000000e+00> : tensor<1x1024xf32>
    %c64_i32 = arith.constant 64 : i32
    %c0 = arith.constant 0 : index
    %0 = scf.for %arg1 = %c0_i32 to %c1024_i32 step %c1_i32 iter_args(%arg2 = %cst) -> (tensor<1x1024xf32>)  : i32 {
      %1 = arith.remsi %arg1, %c64_i32 : i32
      %2 = arith.index_cast %1 : i32 to index
      %extracted = tensor.extract %arg0[%c0, %2] : tensor<1x64xf32>
      %3 = arith.index_cast %arg1 : i32 to index
      %inserted = tensor.insert %extracted into %arg2[%c0, %3] : tensor<1x1024xf32>
      scf.yield %inserted : tensor<1x1024xf32>
    }
    return %0 : tensor<1x1024xf32>
  }
  func.func @main(%cc: !cc, %arg0: tensor<1x!ct> {tensor_ext.original_type = #tensor_ext.original_type<originalType = tensor<1x64xf32>, layout = #layout>}, %arg1: tensor<1x!ct> {tensor_ext.original_type = #tensor_ext.original_type<originalType = tensor<1x64xf32>, layout = #layout>}) -> (tensor<1x!ct> {tensor_ext.original_type = #original_type}) {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 1.000000e+00 : tensor<1x64xf32>
    %cst_0 = arith.constant 5.000000e-01 : tensor<1x64xf32>
    %cst_1 = arith.constant dense<1.2824512720108032> : tensor<1024xf64>
    %cst_2 = arith.constant dense<2.000000e+00> : tensor<1024xf64>
    %cst_3 = arith.constant dense<1.000000e+00> : tensor<1024xf64>
    %cst_4 = arith.constant dense<-1.6389584541320801> : tensor<1024xf64>
    %cst_5 = arith.constant dense<2.367988109588623> : tensor<1024xf64>
    %0 = call @_assign_layout_10373591793897889884(%cst) : (tensor<1x64xf32>) -> tensor<1x1024xf32>
    %1 = call @_assign_layout_10373591793897889884(%cst_0) : (tensor<1x64xf32>) -> tensor<1x1024xf32>
    %extracted = tensor.extract %arg0[%c0] : tensor<1x!ct>
    %extracted_6 = tensor.extract %arg1[%c0] : tensor<1x!ct>
    %ct = openfhe.sub_inplace %cc, %extracted, %extracted_6 : (!cc, !ct, !ct) -> !ct
    %pt = openfhe.make_ckks_packed_plaintext %cc, %cst_1 : (!cc, tensor<1024xf64>) -> !pt
    %ct_7 = openfhe.mul_plain %cc, %ct, %pt : (!cc, !ct, !pt) -> !ct
    %ct_8 = openfhe.mul_no_relin %cc, %ct, %ct : (!cc, !ct, !ct) -> !ct
    %ct_9 = openfhe.relin_inplace %cc, %ct_8 : (!cc, !ct) -> !ct
    %ct_10 = openfhe.mod_reduce_inplace %cc, %ct_9 : (!cc, !ct) -> !ct
    %pt_11 = openfhe.make_ckks_packed_plaintext %cc, %cst_2 : (!cc, tensor<1024xf64>) -> !pt
    %ct_12 = openfhe.mul_plain %cc, %ct_10, %pt_11 : (!cc, !ct, !pt) -> !ct
    %pt_13 = openfhe.make_ckks_packed_plaintext %cc, %cst_3 : (!cc, tensor<1024xf64>) -> !pt
    %ct_14 = openfhe.sub_plain_inplace %cc, %ct_12, %pt_13 : (!cc, !ct, !pt) -> !ct
    %ct_15 = openfhe.mod_reduce_inplace %cc, %ct_14 : (!cc, !ct) -> !ct
    %ct_16 = openfhe.level_reduce %cc, %ct : (!cc, !ct) -> !ct
    %ct_17 = openfhe.mul_plain %cc, %ct_16, %pt_13 : (!cc, !ct, !pt) -> !ct
    %ct_18 = openfhe.mod_reduce_inplace %cc, %ct_17 : (!cc, !ct) -> !ct
    %ct_19 = openfhe.mul_no_relin %cc, %ct_18, %ct_15 : (!cc, !ct, !ct) -> !ct
    %ct_20 = openfhe.relin_inplace %cc, %ct_19 : (!cc, !ct) -> !ct
    %ct_21 = openfhe.mod_reduce_inplace %cc, %ct_20 : (!cc, !ct) -> !ct
    %ct_22 = openfhe.mul_plain %cc, %ct_21, %pt_11 : (!cc, !ct, !pt) -> !ct
    %ct_23 = openfhe.level_reduce %cc, %ct {levelToDrop = 2 : i64} : (!cc, !ct) -> !ct
    %ct_24 = openfhe.mul_plain %cc, %ct_23, %pt_13 : (!cc, !ct, !pt) -> !ct
    %ct_25 = openfhe.mod_reduce_inplace %cc, %ct_24 : (!cc, !ct) -> !ct
    %ct_26 = openfhe.sub_inplace %cc, %ct_22, %ct_25 : (!cc, !ct, !ct) -> !ct
    %ct_27 = openfhe.mod_reduce_inplace %cc, %ct_26 : (!cc, !ct) -> !ct
    %pt_28 = openfhe.make_ckks_packed_plaintext %cc, %cst_4 : (!cc, tensor<1024xf64>) -> !pt
    %ct_29 = openfhe.mul_plain %cc, %ct_27, %pt_28 : (!cc, !ct, !pt) -> !ct
    %ct_30 = openfhe.mul_no_relin %cc, %ct_15, %ct_15 : (!cc, !ct, !ct) -> !ct
    %ct_31 = openfhe.relin_inplace %cc, %ct_30 : (!cc, !ct) -> !ct
    %ct_32 = openfhe.mod_reduce_inplace %cc, %ct_31 : (!cc, !ct) -> !ct
    %ct_33 = openfhe.mul_plain %cc, %ct_32, %pt_11 : (!cc, !ct, !pt) -> !ct
    %ct_34 = openfhe.sub_plain_inplace %cc, %ct_33, %pt_13 : (!cc, !ct, !pt) -> !ct
    %pt_35 = openfhe.make_ckks_packed_plaintext %cc, %cst_5 : (!cc, tensor<1024xf64>) -> !pt
    %ct_36 = openfhe.mul_plain %cc, %ct, %pt_35 : (!cc, !ct, !pt) -> !ct
    %ct_37 = openfhe.mod_reduce_inplace %cc, %ct_34 : (!cc, !ct) -> !ct
    %ct_38 = openfhe.level_reduce_inplace %cc, %ct_36 {levelToDrop = 3 : i64} : (!cc, !ct) -> !ct
    %ct_39 = openfhe.mod_reduce_inplace %cc, %ct_38 : (!cc, !ct) -> !ct
    %ct_40 = openfhe.mul_no_relin %cc, %ct_39, %ct_37 : (!cc, !ct, !ct) -> !ct
    %ct_41 = openfhe.level_reduce_inplace %cc, %ct_7 {levelToDrop = 3 : i64} : (!cc, !ct) -> !ct
    %ct_42 = openfhe.mul_plain %cc, %ct_41, %pt_13 : (!cc, !ct, !pt) -> !ct
    %ct_43 = openfhe.mod_reduce_inplace %cc, %ct_42 : (!cc, !ct) -> !ct
    %ct_44 = openfhe.add_inplace %cc, %ct_43, %ct_29 : (!cc, !ct, !ct) -> !ct
    %extracted_slice = tensor.extract_slice %0[0, 0] [1, 1024] [1, 1] : tensor<1x1024xf32> to tensor<1024xf32>
    %2 = arith.extf %extracted_slice : tensor<1024xf32> to tensor<1024xf64>
    %pt_45 = openfhe.make_ckks_packed_plaintext %cc, %2 : (!cc, tensor<1024xf64>) -> !pt
    %ct_46 = openfhe.add_plain_inplace %cc, %ct_40, %pt_45 : (!cc, !ct, !pt) -> !ct
    %ct_47 = openfhe.relin_inplace %cc, %ct_46 : (!cc, !ct) -> !ct
    %ct_48 = openfhe.add_inplace %cc, %ct_44, %ct_47 : (!cc, !ct, !ct) -> !ct
    %ct_49 = openfhe.mod_reduce_inplace %cc, %ct_48 : (!cc, !ct) -> !ct
    %extracted_slice_50 = tensor.extract_slice %1[0, 0] [1, 1024] [1, 1] : tensor<1x1024xf32> to tensor<1024xf32>
    %3 = arith.extf %extracted_slice_50 : tensor<1024xf32> to tensor<1024xf64>
    %pt_51 = openfhe.make_ckks_packed_plaintext %cc, %3 : (!cc, tensor<1024xf64>) -> !pt
    %ct_52 = openfhe.mul_plain %cc, %ct_49, %pt_51 : (!cc, !ct, !pt) -> !ct
    %4 = tensor.empty() : tensor<1x!ct>
    %ct_53 = openfhe.mod_reduce_inplace %cc, %ct_52 : (!cc, !ct) -> !ct
    %inserted = tensor.insert %ct_53 into %4[%c0] : tensor<1x!ct>
    return %inserted : tensor<1x!ct>
  }
  func.func @main__encrypt__arg0(%cc: !cc, %arg0: tensor<1x64xf32>, %pk: !pk) -> tensor<1x!ct> attributes {client.enc_func = {func_name = "main", index = 0 : i64}} {
    %c1024_i32 = arith.constant 1024 : i32
    %c1_i32 = arith.constant 1 : i32
    %c0_i32 = arith.constant 0 : i32
    %cst = arith.constant dense<0.000000e+00> : tensor<1x1024xf32>
    %c64_i32 = arith.constant 64 : i32
    %c0 = arith.constant 0 : index
    %0 = scf.for %arg1 = %c0_i32 to %c1024_i32 step %c1_i32 iter_args(%arg2 = %cst) -> (tensor<1x1024xf32>)  : i32 {
      %2 = arith.remsi %arg1, %c64_i32 : i32
      %3 = arith.index_cast %2 : i32 to index
      %extracted = tensor.extract %arg0[%c0, %3] : tensor<1x64xf32>
      %4 = arith.index_cast %arg1 : i32 to index
      %inserted = tensor.insert %extracted into %arg2[%c0, %4] : tensor<1x1024xf32>
      scf.yield %inserted : tensor<1x1024xf32>
    }
    %extracted_slice = tensor.extract_slice %0[0, 0] [1, 1024] [1, 1] : tensor<1x1024xf32> to tensor<1024xf32>
    %1 = arith.extf %extracted_slice : tensor<1024xf32> to tensor<1024xf64>
    %pt = openfhe.make_ckks_packed_plaintext %cc, %1 : (!cc, tensor<1024xf64>) -> !pt
    %ct = openfhe.encrypt %cc, %pt, %pk : (!cc, !pt, !pk) -> !ct
    %from_elements = tensor.from_elements %ct : tensor<1x!ct>
    return %from_elements : tensor<1x!ct>
  }
  func.func @main__encrypt__arg1(%cc: !cc, %arg0: tensor<1x64xf32>, %pk: !pk) -> tensor<1x!ct> attributes {client.enc_func = {func_name = "main", index = 1 : i64}} {
    %c1024_i32 = arith.constant 1024 : i32
    %c1_i32 = arith.constant 1 : i32
    %c0_i32 = arith.constant 0 : i32
    %cst = arith.constant dense<0.000000e+00> : tensor<1x1024xf32>
    %c64_i32 = arith.constant 64 : i32
    %c0 = arith.constant 0 : index
    %0 = scf.for %arg1 = %c0_i32 to %c1024_i32 step %c1_i32 iter_args(%arg2 = %cst) -> (tensor<1x1024xf32>)  : i32 {
      %2 = arith.remsi %arg1, %c64_i32 : i32
      %3 = arith.index_cast %2 : i32 to index
      %extracted = tensor.extract %arg0[%c0, %3] : tensor<1x64xf32>
      %4 = arith.index_cast %arg1 : i32 to index
      %inserted = tensor.insert %extracted into %arg2[%c0, %4] : tensor<1x1024xf32>
      scf.yield %inserted : tensor<1x1024xf32>
    }
    %extracted_slice = tensor.extract_slice %0[0, 0] [1, 1024] [1, 1] : tensor<1x1024xf32> to tensor<1024xf32>
    %1 = arith.extf %extracted_slice : tensor<1024xf32> to tensor<1024xf64>
    %pt = openfhe.make_ckks_packed_plaintext %cc, %1 : (!cc, tensor<1024xf64>) -> !pt
    %ct = openfhe.encrypt %cc, %pt, %pk : (!cc, !pt, !pk) -> !ct
    %from_elements = tensor.from_elements %ct : tensor<1x!ct>
    return %from_elements : tensor<1x!ct>
  }
  func.func @main__decrypt__result0(%cc: !cc, %arg0: tensor<1x!ct>, %sk: !sk) -> tensor<1x64xi1> attributes {client.dec_func = {func_name = "main", index = 0 : i64}} {
    %cst = arith.constant dense<false> : tensor<1x64xi1>
    %c0_i32 = arith.constant 0 : i32
    %c1_i32 = arith.constant 1 : i32
    %c64_i32 = arith.constant 64 : i32
    %c1024_i32 = arith.constant 1024 : i32
    %c0 = arith.constant 0 : index
    %extracted = tensor.extract %arg0[%c0] : tensor<1x!ct>
    %pt = openfhe.decrypt %cc, %extracted, %sk : (!cc, !ct, !sk) -> !pt
    %0 = openfhe.decode_ckks %pt : !pt -> tensor<1x1024xi1>
    %1 = scf.for %arg1 = %c0_i32 to %c1024_i32 step %c1_i32 iter_args(%arg2 = %cst) -> (tensor<1x64xi1>)  : i32 {
      %2 = arith.remsi %arg1, %c64_i32 : i32
      %3 = arith.index_cast %arg1 : i32 to index
      %extracted_0 = tensor.extract %0[%c0, %3] : tensor<1x1024xi1>
      %4 = arith.index_cast %2 : i32 to index
      %inserted = tensor.insert %extracted_0 into %arg2[%c0, %4] : tensor<1x64xi1>
      scf.yield %inserted : tensor<1x64xi1>
    }
    return %1 : tensor<1x64xi1>
  }
  func.func @main__generate_crypto_context() -> !cc {
    %params = openfhe.gen_params  {mulDepth = 6 : i64, plainMod = 0 : i64} : () -> !params
    %cc = openfhe.gen_context %params {supportFHE = false} : (!params) -> !cc
    return %cc : !cc
  }
  func.func @main__configure_crypto_context(%cc: !cc, %sk: !sk) -> !cc {
    openfhe.gen_mulkey %cc, %sk : (!cc, !sk) -> ()
    return %cc : !cc
  }
}

