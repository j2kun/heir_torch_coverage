!cc = !openfhe.crypto_context
!ct = !openfhe.ciphertext
!params = !openfhe.cc_params
!pk = !openfhe.public_key
!pt = !openfhe.plaintext
!sk = !openfhe.private_key
#layout = #tensor_ext.layout<"{ [i0, i1] -> [ct, slot] : i0 = 0 and ct = 0 and (-i1 + slot) mod 64 = 0 and 0 <= i1 <= 63 and 0 <= slot <= 1023 }">
#original_type = #tensor_ext.original_type<originalType = tensor<1x64xf32>, layout = #layout>
module attributes {backend.openfhe, scheme.actual_slot_count = 16384 : i64, scheme.ckks, scheme.requested_slot_count = 1024 : i64} {
  func.func @main(%cc: !cc, %arg0: tensor<1x!ct> {tensor_ext.original_type = #original_type}) -> (tensor<1x!ct> {tensor_ext.original_type = #original_type}) {
    %cst = arith.constant dense<0.40000000596046448> : tensor<1024xf64>
    %c0 = arith.constant 0 : index
    %cst_0 = arith.constant dense<0.20000000298023224> : tensor<1024xf64>
    %cst_1 = arith.constant dense<6.6214265823364258> : tensor<1024xf64>
    %cst_2 = arith.constant dense<3.3536741733551025> : tensor<1024xf64>
    %cst_3 = arith.constant dense<4.2048530578613281> : tensor<1024xf64>
    %cst_4 = arith.constant dense<2.000000e+00> : tensor<1024xf64>
    %cst_5 = arith.constant dense<1.000000e+00> : tensor<1024xf64>
    %cst_6 = arith.constant dense<5.4240021705627441> : tensor<1024xf64>
    %pt = openfhe.make_ckks_packed_plaintext %cc, %cst : (!cc, tensor<1024xf64>) -> !pt
    %extracted = tensor.extract %arg0[%c0] : tensor<1x!ct>
    %ct = openfhe.mul_plain %cc, %extracted, %pt : (!cc, !ct, !pt) -> !ct
    %pt_7 = openfhe.make_ckks_packed_plaintext %cc, %cst_0 : (!cc, tensor<1024xf64>) -> !pt
    %ct_8 = openfhe.add_plain_inplace %cc, %ct, %pt_7 : (!cc, !ct, !pt) -> !ct
    %ct_9 = openfhe.mod_reduce_inplace %cc, %ct_8 : (!cc, !ct) -> !ct
    %pt_10 = openfhe.make_ckks_packed_plaintext %cc, %cst_1 : (!cc, tensor<1024xf64>) -> !pt
    %ct_11 = openfhe.mul_plain %cc, %ct_9, %pt_10 : (!cc, !ct, !pt) -> !ct
    %pt_12 = openfhe.make_ckks_packed_plaintext %cc, %cst_2 : (!cc, tensor<1024xf64>) -> !pt
    %ct_13 = openfhe.mul_plain %cc, %ct_9, %pt_12 : (!cc, !ct, !pt) -> !ct
    %pt_14 = openfhe.make_ckks_packed_plaintext %cc, %cst_3 : (!cc, tensor<1024xf64>) -> !pt
    %ct_15 = openfhe.add_plain_inplace %cc, %ct_13, %pt_14 : (!cc, !ct, !pt) -> !ct
    %ct_16 = openfhe.mul_no_relin %cc, %ct_9, %ct_9 : (!cc, !ct, !ct) -> !ct
    %ct_17 = openfhe.relin_inplace %cc, %ct_16 : (!cc, !ct) -> !ct
    %ct_18 = openfhe.mod_reduce_inplace %cc, %ct_17 : (!cc, !ct) -> !ct
    %pt_19 = openfhe.make_ckks_packed_plaintext %cc, %cst_4 : (!cc, tensor<1024xf64>) -> !pt
    %ct_20 = openfhe.mul_plain %cc, %ct_18, %pt_19 : (!cc, !ct, !pt) -> !ct
    %pt_21 = openfhe.make_ckks_packed_plaintext %cc, %cst_5 : (!cc, tensor<1024xf64>) -> !pt
    %ct_22 = openfhe.sub_plain_inplace %cc, %ct_20, %pt_21 : (!cc, !ct, !pt) -> !ct
    %ct_23 = openfhe.mod_reduce_inplace %cc, %ct_22 : (!cc, !ct) -> !ct
    %ct_24 = openfhe.level_reduce_inplace %cc, %ct_15 : (!cc, !ct) -> !ct
    %ct_25 = openfhe.mod_reduce_inplace %cc, %ct_24 : (!cc, !ct) -> !ct
    %ct_26 = openfhe.mul_no_relin %cc, %ct_25, %ct_23 : (!cc, !ct, !ct) -> !ct
    %ct_27 = openfhe.relin_inplace %cc, %ct_26 : (!cc, !ct) -> !ct
    %pt_28 = openfhe.make_ckks_packed_plaintext %cc, %cst_6 : (!cc, tensor<1024xf64>) -> !pt
    %ct_29 = openfhe.add_plain_inplace %cc, %ct_11, %pt_28 : (!cc, !ct, !pt) -> !ct
    %ct_30 = openfhe.level_reduce_inplace %cc, %ct_29 : (!cc, !ct) -> !ct
    %ct_31 = openfhe.mul_plain %cc, %ct_30, %pt_21 : (!cc, !ct, !pt) -> !ct
    %ct_32 = openfhe.mod_reduce_inplace %cc, %ct_31 : (!cc, !ct) -> !ct
    %ct_33 = openfhe.add_inplace %cc, %ct_32, %ct_27 : (!cc, !ct, !ct) -> !ct
    %0 = tensor.empty() : tensor<1x!ct>
    %ct_34 = openfhe.mod_reduce_inplace %cc, %ct_33 : (!cc, !ct) -> !ct
    %inserted = tensor.insert %ct_34 into %0[%c0] : tensor<1x!ct>
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
  func.func @main__decrypt__result0(%cc: !cc, %arg0: tensor<1x!ct>, %sk: !sk) -> tensor<1x64xf32> attributes {client.dec_func = {func_name = "main", index = 0 : i64}} {
    %cst = arith.constant dense<0.000000e+00> : tensor<1x64xf32>
    %c0_i32 = arith.constant 0 : i32
    %c1_i32 = arith.constant 1 : i32
    %c64_i32 = arith.constant 64 : i32
    %c1024_i32 = arith.constant 1024 : i32
    %c0 = arith.constant 0 : index
    %extracted = tensor.extract %arg0[%c0] : tensor<1x!ct>
    %pt = openfhe.decrypt %cc, %extracted, %sk : (!cc, !ct, !sk) -> !pt
    %0 = openfhe.decode_ckks %pt : !pt -> tensor<1x1024xf32>
    %1 = scf.for %arg1 = %c0_i32 to %c1024_i32 step %c1_i32 iter_args(%arg2 = %cst) -> (tensor<1x64xf32>)  : i32 {
      %2 = arith.remsi %arg1, %c64_i32 : i32
      %3 = arith.index_cast %arg1 : i32 to index
      %extracted_0 = tensor.extract %0[%c0, %3] : tensor<1x1024xf32>
      %4 = arith.index_cast %2 : i32 to index
      %inserted = tensor.insert %extracted_0 into %arg2[%c0, %4] : tensor<1x64xf32>
      scf.yield %inserted : tensor<1x64xf32>
    }
    return %1 : tensor<1x64xf32>
  }
  func.func @main__generate_crypto_context() -> !cc {
    %params = openfhe.gen_params  {mulDepth = 4 : i64, plainMod = 0 : i64} : () -> !params
    %cc = openfhe.gen_context %params {supportFHE = false} : (!params) -> !cc
    return %cc : !cc
  }
  func.func @main__configure_crypto_context(%cc: !cc, %sk: !sk) -> !cc {
    openfhe.gen_mulkey %cc, %sk : (!cc, !sk) -> ()
    return %cc : !cc
  }
}

