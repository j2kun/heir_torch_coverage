!cc = !openfhe.crypto_context
!ct = !openfhe.ciphertext
!digit_decomp = !openfhe.digit_decomp
!params = !openfhe.cc_params
!pk = !openfhe.public_key
!pt = !openfhe.plaintext
!sk = !openfhe.private_key
#layout = #tensor_ext.layout<"{ [i0, i1] -> [ct, slot] : i0 = 0 and ct = 0 and (-i1 + slot) mod 16 = 0 and 0 <= i1 <= 9 and 0 <= slot <= 1023 }">
#original_type = #tensor_ext.original_type<originalType = tensor<1x10xf32>, layout = #layout>
module attributes {backend.openfhe, scheme.actual_slot_count = 8192 : i64, scheme.ckks, scheme.requested_slot_count = 1024 : i64} {
  func.func private @_assign_layout_1909150731925866293() -> tensor<1x1024xf32> attributes {client.pack_func = {func_name = "main"}} {
    %cst = arith.constant dense_resource<torch_tensor_10_torch.float32> : tensor<10xf32>
    %c1024_i32 = arith.constant 1024 : i32
    %c1_i32 = arith.constant 1 : i32
    %c0_i32 = arith.constant 0 : i32
    %cst_0 = arith.constant dense<0.000000e+00> : tensor<1x1024xf32>
    %c6_i32 = arith.constant 6 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0 = arith.constant 0 : index
    %0 = scf.for %arg0 = %c0_i32 to %c1024_i32 step %c1_i32 iter_args(%arg1 = %cst_0) -> (tensor<1x1024xf32>)  : i32 {
      %1 = arith.addi %arg0, %c6_i32 : i32
      %2 = arith.remsi %1, %c16_i32 : i32
      %3 = arith.cmpi sge, %2, %c6_i32 : i32
      %4 = scf.if %3 -> (tensor<1x1024xf32>) {
        %5 = arith.remsi %arg0, %c16_i32 : i32
        %6 = arith.index_cast %5 : i32 to index
        %extracted = tensor.extract %cst[%6] : tensor<10xf32>
        %7 = arith.index_cast %arg0 : i32 to index
        %inserted = tensor.insert %extracted into %arg1[%c0, %7] : tensor<1x1024xf32>
        scf.yield %inserted : tensor<1x1024xf32>
      } else {
        scf.yield %arg1 : tensor<1x1024xf32>
      }
      scf.yield %4 : tensor<1x1024xf32>
    }
    return %0 : tensor<1x1024xf32>
  }
  func.func private @_assign_layout_7630498091691519140() -> tensor<16x1024xf32> attributes {client.pack_func = {func_name = "main"}} {
    %cst = arith.constant dense_resource<torch_tensor_10_64_torch.float32> : tensor<10x64xf32>
    %c1_i32 = arith.constant 1 : i32
    %c0_i32 = arith.constant 0 : i32
    %cst_0 = arith.constant dense<0.000000e+00> : tensor<16x1024xf32>
    %c16_i32 = arith.constant 16 : i32
    %c9_i32 = arith.constant 9 : i32
    %c6_i32 = arith.constant 6 : i32
    %c1087_i32 = arith.constant 1087 : i32
    %c64_i32 = arith.constant 64 : i32
    %c1018_i32 = arith.constant 1018 : i32
    %c63_i32 = arith.constant 63 : i32
    %0 = scf.for %arg0 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg1 = %cst_0) -> (tensor<16x1024xf32>)  : i32 {
      %1 = scf.for %arg2 = %c0_i32 to %c1018_i32 step %c1_i32 iter_args(%arg3 = %arg1) -> (tensor<16x1024xf32>)  : i32 {
        %2 = arith.remsi %arg2, %c16_i32 : i32
        %3 = arith.cmpi sle, %2, %c9_i32 : i32
        %4 = scf.if %3 -> (tensor<16x1024xf32>) {
          %5 = arith.addi %arg2, %c6_i32 : i32
          %6 = arith.remsi %5, %c16_i32 : i32
          %7 = arith.subi %6, %c6_i32 : i32
          %8 = arith.subi %c0_i32, %arg0 : i32
          %9 = arith.subi %8, %arg2 : i32
          %10 = arith.addi %9, %c1087_i32 : i32
          %11 = arith.remsi %10, %c64_i32 : i32
          %12 = arith.subi %c63_i32, %11 : i32
          %13 = arith.index_cast %7 : i32 to index
          %14 = arith.index_cast %12 : i32 to index
          %extracted = tensor.extract %cst[%13, %14] : tensor<10x64xf32>
          %15 = arith.index_cast %arg0 : i32 to index
          %16 = arith.index_cast %arg2 : i32 to index
          %inserted = tensor.insert %extracted into %arg3[%15, %16] : tensor<16x1024xf32>
          scf.yield %inserted : tensor<16x1024xf32>
        } else {
          scf.yield %arg3 : tensor<16x1024xf32>
        }
        scf.yield %4 : tensor<16x1024xf32>
      }
      scf.yield %1 : tensor<16x1024xf32>
    }
    return %0 : tensor<16x1024xf32>
  }
  func.func @main(%cc: !cc, %arg0: tensor<1x!ct> {tensor_ext.original_type = #tensor_ext.original_type<originalType = tensor<1x64xf32>, layout = #tensor_ext.layout<"{ [i0, i1] -> [ct, slot] : i0 = 0 and ct = 0 and (-i1 + slot) mod 64 = 0 and 0 <= i1 <= 63 and 0 <= slot <= 1023 }">>}) -> (tensor<1x!ct> {tensor_ext.original_type = #original_type}) {
    %cst = arith.constant dense<[2, 1, 3]> : tensor<3xindex>
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %c4 = arith.constant 4 : index
    %c8 = arith.constant 8 : index
    %c12 = arith.constant 12 : index
    %c32 = arith.constant 32 : index
    %c16 = arith.constant 16 : index
    %0 = call @_assign_layout_7630498091691519140() : () -> tensor<16x1024xf32>
    %1 = call @_assign_layout_1909150731925866293() : () -> tensor<1x1024xf32>
    %extracted_slice = tensor.extract_slice %0[4, 0] [1, 1020] [1, 1] : tensor<16x1024xf32> to tensor<1x1020xf32>
    %extracted_slice_0 = tensor.extract_slice %0[4, 1020] [1, 4] [1, 1] : tensor<16x1024xf32> to tensor<1x4xf32>
    %2 = tensor.empty() : tensor<1x1024xf32>
    %inserted_slice = tensor.insert_slice %extracted_slice into %2[0, 4] [1, 1020] [1, 1] : tensor<1x1020xf32> into tensor<1x1024xf32>
    %inserted_slice_1 = tensor.insert_slice %extracted_slice_0 into %inserted_slice[0, 0] [1, 4] [1, 1] : tensor<1x4xf32> into tensor<1x1024xf32>
    %extracted_slice_2 = tensor.extract_slice %0[5, 0] [1, 1020] [1, 1] : tensor<16x1024xf32> to tensor<1x1020xf32>
    %extracted_slice_3 = tensor.extract_slice %0[5, 1020] [1, 4] [1, 1] : tensor<16x1024xf32> to tensor<1x4xf32>
    %inserted_slice_4 = tensor.insert_slice %extracted_slice_2 into %2[0, 4] [1, 1020] [1, 1] : tensor<1x1020xf32> into tensor<1x1024xf32>
    %inserted_slice_5 = tensor.insert_slice %extracted_slice_3 into %inserted_slice_4[0, 0] [1, 4] [1, 1] : tensor<1x4xf32> into tensor<1x1024xf32>
    %extracted_slice_6 = tensor.extract_slice %0[6, 0] [1, 1020] [1, 1] : tensor<16x1024xf32> to tensor<1x1020xf32>
    %extracted_slice_7 = tensor.extract_slice %0[6, 1020] [1, 4] [1, 1] : tensor<16x1024xf32> to tensor<1x4xf32>
    %inserted_slice_8 = tensor.insert_slice %extracted_slice_6 into %2[0, 4] [1, 1020] [1, 1] : tensor<1x1020xf32> into tensor<1x1024xf32>
    %inserted_slice_9 = tensor.insert_slice %extracted_slice_7 into %inserted_slice_8[0, 0] [1, 4] [1, 1] : tensor<1x4xf32> into tensor<1x1024xf32>
    %extracted_slice_10 = tensor.extract_slice %0[7, 0] [1, 1020] [1, 1] : tensor<16x1024xf32> to tensor<1x1020xf32>
    %extracted_slice_11 = tensor.extract_slice %0[7, 1020] [1, 4] [1, 1] : tensor<16x1024xf32> to tensor<1x4xf32>
    %inserted_slice_12 = tensor.insert_slice %extracted_slice_10 into %2[0, 4] [1, 1020] [1, 1] : tensor<1x1020xf32> into tensor<1x1024xf32>
    %inserted_slice_13 = tensor.insert_slice %extracted_slice_11 into %inserted_slice_12[0, 0] [1, 4] [1, 1] : tensor<1x4xf32> into tensor<1x1024xf32>
    %extracted_slice_14 = tensor.extract_slice %0[8, 0] [1, 1016] [1, 1] : tensor<16x1024xf32> to tensor<1x1016xf32>
    %extracted_slice_15 = tensor.extract_slice %0[8, 1016] [1, 8] [1, 1] : tensor<16x1024xf32> to tensor<1x8xf32>
    %inserted_slice_16 = tensor.insert_slice %extracted_slice_14 into %2[0, 8] [1, 1016] [1, 1] : tensor<1x1016xf32> into tensor<1x1024xf32>
    %inserted_slice_17 = tensor.insert_slice %extracted_slice_15 into %inserted_slice_16[0, 0] [1, 8] [1, 1] : tensor<1x8xf32> into tensor<1x1024xf32>
    %extracted_slice_18 = tensor.extract_slice %0[9, 0] [1, 1016] [1, 1] : tensor<16x1024xf32> to tensor<1x1016xf32>
    %extracted_slice_19 = tensor.extract_slice %0[9, 1016] [1, 8] [1, 1] : tensor<16x1024xf32> to tensor<1x8xf32>
    %inserted_slice_20 = tensor.insert_slice %extracted_slice_18 into %2[0, 8] [1, 1016] [1, 1] : tensor<1x1016xf32> into tensor<1x1024xf32>
    %inserted_slice_21 = tensor.insert_slice %extracted_slice_19 into %inserted_slice_20[0, 0] [1, 8] [1, 1] : tensor<1x8xf32> into tensor<1x1024xf32>
    %extracted_slice_22 = tensor.extract_slice %0[10, 0] [1, 1016] [1, 1] : tensor<16x1024xf32> to tensor<1x1016xf32>
    %extracted_slice_23 = tensor.extract_slice %0[10, 1016] [1, 8] [1, 1] : tensor<16x1024xf32> to tensor<1x8xf32>
    %inserted_slice_24 = tensor.insert_slice %extracted_slice_22 into %2[0, 8] [1, 1016] [1, 1] : tensor<1x1016xf32> into tensor<1x1024xf32>
    %inserted_slice_25 = tensor.insert_slice %extracted_slice_23 into %inserted_slice_24[0, 0] [1, 8] [1, 1] : tensor<1x8xf32> into tensor<1x1024xf32>
    %extracted_slice_26 = tensor.extract_slice %0[11, 0] [1, 1016] [1, 1] : tensor<16x1024xf32> to tensor<1x1016xf32>
    %extracted_slice_27 = tensor.extract_slice %0[11, 1016] [1, 8] [1, 1] : tensor<16x1024xf32> to tensor<1x8xf32>
    %inserted_slice_28 = tensor.insert_slice %extracted_slice_26 into %2[0, 8] [1, 1016] [1, 1] : tensor<1x1016xf32> into tensor<1x1024xf32>
    %inserted_slice_29 = tensor.insert_slice %extracted_slice_27 into %inserted_slice_28[0, 0] [1, 8] [1, 1] : tensor<1x8xf32> into tensor<1x1024xf32>
    %extracted_slice_30 = tensor.extract_slice %0[12, 0] [1, 1012] [1, 1] : tensor<16x1024xf32> to tensor<1x1012xf32>
    %extracted_slice_31 = tensor.extract_slice %0[12, 1012] [1, 12] [1, 1] : tensor<16x1024xf32> to tensor<1x12xf32>
    %inserted_slice_32 = tensor.insert_slice %extracted_slice_30 into %2[0, 12] [1, 1012] [1, 1] : tensor<1x1012xf32> into tensor<1x1024xf32>
    %inserted_slice_33 = tensor.insert_slice %extracted_slice_31 into %inserted_slice_32[0, 0] [1, 12] [1, 1] : tensor<1x12xf32> into tensor<1x1024xf32>
    %extracted_slice_34 = tensor.extract_slice %0[13, 0] [1, 1012] [1, 1] : tensor<16x1024xf32> to tensor<1x1012xf32>
    %extracted_slice_35 = tensor.extract_slice %0[13, 1012] [1, 12] [1, 1] : tensor<16x1024xf32> to tensor<1x12xf32>
    %inserted_slice_36 = tensor.insert_slice %extracted_slice_34 into %2[0, 12] [1, 1012] [1, 1] : tensor<1x1012xf32> into tensor<1x1024xf32>
    %inserted_slice_37 = tensor.insert_slice %extracted_slice_35 into %inserted_slice_36[0, 0] [1, 12] [1, 1] : tensor<1x12xf32> into tensor<1x1024xf32>
    %extracted_slice_38 = tensor.extract_slice %0[14, 0] [1, 1012] [1, 1] : tensor<16x1024xf32> to tensor<1x1012xf32>
    %extracted_slice_39 = tensor.extract_slice %0[14, 1012] [1, 12] [1, 1] : tensor<16x1024xf32> to tensor<1x12xf32>
    %inserted_slice_40 = tensor.insert_slice %extracted_slice_38 into %2[0, 12] [1, 1012] [1, 1] : tensor<1x1012xf32> into tensor<1x1024xf32>
    %inserted_slice_41 = tensor.insert_slice %extracted_slice_39 into %inserted_slice_40[0, 0] [1, 12] [1, 1] : tensor<1x12xf32> into tensor<1x1024xf32>
    %extracted_slice_42 = tensor.extract_slice %0[15, 0] [1, 1012] [1, 1] : tensor<16x1024xf32> to tensor<1x1012xf32>
    %extracted_slice_43 = tensor.extract_slice %0[15, 1012] [1, 12] [1, 1] : tensor<16x1024xf32> to tensor<1x12xf32>
    %inserted_slice_44 = tensor.insert_slice %extracted_slice_42 into %2[0, 12] [1, 1012] [1, 1] : tensor<1x1012xf32> into tensor<1x1024xf32>
    %inserted_slice_45 = tensor.insert_slice %extracted_slice_43 into %inserted_slice_44[0, 0] [1, 12] [1, 1] : tensor<1x12xf32> into tensor<1x1024xf32>
    %extracted_slice_46 = tensor.extract_slice %0[0, 0] [1, 1024] [1, 1] : tensor<16x1024xf32> to tensor<1024xf32>
    %3 = arith.extf %extracted_slice_46 : tensor<1024xf32> to tensor<1024xf64>
    %pt = openfhe.make_ckks_packed_plaintext %cc, %3 : (!cc, tensor<1024xf64>) -> !pt
    %extracted = tensor.extract %arg0[%c0] : tensor<1x!ct>
    %digit_decomp = openfhe.fast_rotation_precompute %cc, %extracted : (!cc, !ct) -> !digit_decomp
    %ct = openfhe.mul_plain %cc, %extracted, %pt : (!cc, !ct, !pt) -> !ct
    %extracted_slice_47 = tensor.extract_slice %0[1, 0] [1, 1024] [1, 1] : tensor<16x1024xf32> to tensor<1024xf32>
    %4 = arith.extf %extracted_slice_47 : tensor<1024xf32> to tensor<1024xf64>
    %pt_48 = openfhe.make_ckks_packed_plaintext %cc, %4 : (!cc, tensor<1024xf64>) -> !pt
    %extracted_slice_49 = tensor.extract_slice %0[2, 0] [1, 1024] [1, 1] : tensor<16x1024xf32> to tensor<1024xf32>
    %5 = arith.extf %extracted_slice_49 : tensor<1024xf32> to tensor<1024xf64>
    %pt_50 = openfhe.make_ckks_packed_plaintext %cc, %5 : (!cc, tensor<1024xf64>) -> !pt
    %6 = tensor.empty() : tensor<3x!ct>
    %7 = scf.forall (%arg1) in (3) shared_outs(%arg2 = %6) -> (tensor<3x!ct>) {
      %extracted_121 = tensor.extract %cst[%arg1] : tensor<3xindex>
      %ct_122 = openfhe.fast_rotation %cc, %extracted, %extracted_121, %digit_decomp {cyclotomicOrder = 0 : index} : (!cc, !ct, index, !digit_decomp) -> !ct
      %from_elements = tensor.from_elements %ct_122 : tensor<1x!ct>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %from_elements into %arg2[%arg1] [1] [1] : tensor<1x!ct> into tensor<3x!ct>
      }
    }
    %extracted_51 = tensor.extract %7[%c0] : tensor<3x!ct>
    %extracted_52 = tensor.extract %7[%c1] : tensor<3x!ct>
    %extracted_53 = tensor.extract %7[%c2] : tensor<3x!ct>
    %extracted_slice_54 = tensor.extract_slice %0[3, 0] [1, 1024] [1, 1] : tensor<16x1024xf32> to tensor<1024xf32>
    %8 = arith.extf %extracted_slice_54 : tensor<1024xf32> to tensor<1024xf64>
    %pt_55 = openfhe.make_ckks_packed_plaintext %cc, %8 : (!cc, tensor<1024xf64>) -> !pt
    %ct_56 = openfhe.mul_plain %cc, %extracted_53, %pt_55 : (!cc, !ct, !pt) -> !ct
    %extracted_slice_57 = tensor.extract_slice %inserted_slice_1[0, 0] [1, 1024] [1, 1] : tensor<1x1024xf32> to tensor<1024xf32>
    %9 = arith.extf %extracted_slice_57 : tensor<1024xf32> to tensor<1024xf64>
    %pt_58 = openfhe.make_ckks_packed_plaintext %cc, %9 : (!cc, tensor<1024xf64>) -> !pt
    %ct_59 = openfhe.mul_plain %cc, %extracted, %pt_58 : (!cc, !ct, !pt) -> !ct
    %extracted_slice_60 = tensor.extract_slice %inserted_slice_5[0, 0] [1, 1024] [1, 1] : tensor<1x1024xf32> to tensor<1024xf32>
    %10 = arith.extf %extracted_slice_60 : tensor<1024xf32> to tensor<1024xf64>
    %pt_61 = openfhe.make_ckks_packed_plaintext %cc, %10 : (!cc, tensor<1024xf64>) -> !pt
    %ct_62 = openfhe.mul_plain %cc, %extracted_52, %pt_61 : (!cc, !ct, !pt) -> !ct
    %extracted_slice_63 = tensor.extract_slice %inserted_slice_9[0, 0] [1, 1024] [1, 1] : tensor<1x1024xf32> to tensor<1024xf32>
    %11 = arith.extf %extracted_slice_63 : tensor<1024xf32> to tensor<1024xf64>
    %pt_64 = openfhe.make_ckks_packed_plaintext %cc, %11 : (!cc, tensor<1024xf64>) -> !pt
    %ct_65 = openfhe.mul_plain %cc, %extracted_51, %pt_64 : (!cc, !ct, !pt) -> !ct
    %extracted_slice_66 = tensor.extract_slice %inserted_slice_13[0, 0] [1, 1024] [1, 1] : tensor<1x1024xf32> to tensor<1024xf32>
    %12 = arith.extf %extracted_slice_66 : tensor<1024xf32> to tensor<1024xf64>
    %pt_67 = openfhe.make_ckks_packed_plaintext %cc, %12 : (!cc, tensor<1024xf64>) -> !pt
    %ct_68 = openfhe.mul_plain %cc, %extracted_53, %pt_67 : (!cc, !ct, !pt) -> !ct
    %ct_69 = openfhe.add_inplace %cc, %ct_59, %ct_62 : (!cc, !ct, !ct) -> !ct
    %ct_70 = openfhe.add_inplace %cc, %ct_65, %ct_68 : (!cc, !ct, !ct) -> !ct
    %ct_71 = openfhe.add_inplace %cc, %ct_69, %ct_70 : (!cc, !ct, !ct) -> !ct
    %ct_72 = openfhe.rot %cc, %ct_71, %c4 : (!cc, !ct, index) -> !ct
    %extracted_slice_73 = tensor.extract_slice %inserted_slice_17[0, 0] [1, 1024] [1, 1] : tensor<1x1024xf32> to tensor<1024xf32>
    %13 = arith.extf %extracted_slice_73 : tensor<1024xf32> to tensor<1024xf64>
    %pt_74 = openfhe.make_ckks_packed_plaintext %cc, %13 : (!cc, tensor<1024xf64>) -> !pt
    %ct_75 = openfhe.mul_plain %cc, %extracted, %pt_74 : (!cc, !ct, !pt) -> !ct
    %extracted_slice_76 = tensor.extract_slice %inserted_slice_21[0, 0] [1, 1024] [1, 1] : tensor<1x1024xf32> to tensor<1024xf32>
    %14 = arith.extf %extracted_slice_76 : tensor<1024xf32> to tensor<1024xf64>
    %pt_77 = openfhe.make_ckks_packed_plaintext %cc, %14 : (!cc, tensor<1024xf64>) -> !pt
    %ct_78 = openfhe.mul_plain %cc, %extracted_52, %pt_77 : (!cc, !ct, !pt) -> !ct
    %extracted_slice_79 = tensor.extract_slice %inserted_slice_25[0, 0] [1, 1024] [1, 1] : tensor<1x1024xf32> to tensor<1024xf32>
    %15 = arith.extf %extracted_slice_79 : tensor<1024xf32> to tensor<1024xf64>
    %pt_80 = openfhe.make_ckks_packed_plaintext %cc, %15 : (!cc, tensor<1024xf64>) -> !pt
    %ct_81 = openfhe.mul_plain %cc, %extracted_51, %pt_80 : (!cc, !ct, !pt) -> !ct
    %extracted_slice_82 = tensor.extract_slice %inserted_slice_29[0, 0] [1, 1024] [1, 1] : tensor<1x1024xf32> to tensor<1024xf32>
    %16 = arith.extf %extracted_slice_82 : tensor<1024xf32> to tensor<1024xf64>
    %pt_83 = openfhe.make_ckks_packed_plaintext %cc, %16 : (!cc, tensor<1024xf64>) -> !pt
    %ct_84 = openfhe.mul_plain %cc, %extracted_53, %pt_83 : (!cc, !ct, !pt) -> !ct
    %ct_85 = openfhe.add_inplace %cc, %ct_75, %ct_78 : (!cc, !ct, !ct) -> !ct
    %ct_86 = openfhe.add_inplace %cc, %ct_81, %ct_84 : (!cc, !ct, !ct) -> !ct
    %ct_87 = openfhe.add_inplace %cc, %ct_85, %ct_86 : (!cc, !ct, !ct) -> !ct
    %ct_88 = openfhe.rot %cc, %ct_87, %c8 : (!cc, !ct, index) -> !ct
    %extracted_slice_89 = tensor.extract_slice %inserted_slice_33[0, 0] [1, 1024] [1, 1] : tensor<1x1024xf32> to tensor<1024xf32>
    %17 = arith.extf %extracted_slice_89 : tensor<1024xf32> to tensor<1024xf64>
    %pt_90 = openfhe.make_ckks_packed_plaintext %cc, %17 : (!cc, tensor<1024xf64>) -> !pt
    %ct_91 = openfhe.mul_plain %cc, %extracted, %pt_90 : (!cc, !ct, !pt) -> !ct
    %extracted_slice_92 = tensor.extract_slice %inserted_slice_37[0, 0] [1, 1024] [1, 1] : tensor<1x1024xf32> to tensor<1024xf32>
    %18 = arith.extf %extracted_slice_92 : tensor<1024xf32> to tensor<1024xf64>
    %pt_93 = openfhe.make_ckks_packed_plaintext %cc, %18 : (!cc, tensor<1024xf64>) -> !pt
    %ct_94 = openfhe.mul_plain %cc, %extracted_52, %pt_93 : (!cc, !ct, !pt) -> !ct
    %extracted_slice_95 = tensor.extract_slice %inserted_slice_41[0, 0] [1, 1024] [1, 1] : tensor<1x1024xf32> to tensor<1024xf32>
    %19 = arith.extf %extracted_slice_95 : tensor<1024xf32> to tensor<1024xf64>
    %pt_96 = openfhe.make_ckks_packed_plaintext %cc, %19 : (!cc, tensor<1024xf64>) -> !pt
    %ct_97 = openfhe.mul_plain %cc, %extracted_51, %pt_96 : (!cc, !ct, !pt) -> !ct
    %extracted_slice_98 = tensor.extract_slice %inserted_slice_45[0, 0] [1, 1024] [1, 1] : tensor<1x1024xf32> to tensor<1024xf32>
    %20 = arith.extf %extracted_slice_98 : tensor<1024xf32> to tensor<1024xf64>
    %pt_99 = openfhe.make_ckks_packed_plaintext %cc, %20 : (!cc, tensor<1024xf64>) -> !pt
    %ct_100 = openfhe.mul_plain %cc, %extracted_53, %pt_99 : (!cc, !ct, !pt) -> !ct
    %ct_101 = openfhe.add_inplace %cc, %ct_91, %ct_94 : (!cc, !ct, !ct) -> !ct
    %ct_102 = openfhe.add_inplace %cc, %ct_97, %ct_100 : (!cc, !ct, !ct) -> !ct
    %ct_103 = openfhe.add_inplace %cc, %ct_101, %ct_102 : (!cc, !ct, !ct) -> !ct
    %ct_104 = openfhe.rot %cc, %ct_103, %c12 : (!cc, !ct, index) -> !ct
    %ct_105 = openfhe.add_inplace %cc, %ct_56, %ct_72 : (!cc, !ct, !ct) -> !ct
    %ct_106 = openfhe.add_inplace %cc, %ct_88, %ct_104 : (!cc, !ct, !ct) -> !ct
    %ct_107 = openfhe.add_inplace %cc, %ct_105, %ct_106 : (!cc, !ct, !ct) -> !ct
    %extracted_slice_108 = tensor.extract_slice %1[0, 0] [1, 1024] [1, 1] : tensor<1x1024xf32> to tensor<1024xf32>
    %21 = arith.extf %extracted_slice_108 : tensor<1024xf32> to tensor<1024xf64>
    %pt_109 = openfhe.make_ckks_packed_plaintext %cc, %21 : (!cc, tensor<1024xf64>) -> !pt
    %22 = tensor.empty() : tensor<1x!ct>
    %ct_110 = openfhe.mul_plain %cc, %extracted_52, %pt_48 : (!cc, !ct, !pt) -> !ct
    %ct_111 = openfhe.mul_plain %cc, %extracted_51, %pt_50 : (!cc, !ct, !pt) -> !ct
    %ct_112 = openfhe.add_inplace %cc, %ct, %ct_110 : (!cc, !ct, !ct) -> !ct
    %ct_113 = openfhe.add_inplace %cc, %ct_112, %ct_111 : (!cc, !ct, !ct) -> !ct
    %ct_114 = openfhe.add_inplace %cc, %ct_113, %ct_107 : (!cc, !ct, !ct) -> !ct
    %ct_115 = openfhe.rot %cc, %ct_114, %c32 : (!cc, !ct, index) -> !ct
    %ct_116 = openfhe.add_inplace %cc, %ct_114, %ct_115 : (!cc, !ct, !ct) -> !ct
    %ct_117 = openfhe.rot %cc, %ct_116, %c16 : (!cc, !ct, index) -> !ct
    %ct_118 = openfhe.add_inplace %cc, %ct_116, %ct_117 : (!cc, !ct, !ct) -> !ct
    %ct_119 = openfhe.add_plain_inplace %cc, %ct_118, %pt_109 : (!cc, !ct, !pt) -> !ct
    %ct_120 = openfhe.mod_reduce_inplace %cc, %ct_119 : (!cc, !ct) -> !ct
    %inserted = tensor.insert %ct_120 into %22[%c0] : tensor<1x!ct>
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
  func.func @main__decrypt__result0(%cc: !cc, %arg0: tensor<1x!ct>, %sk: !sk) -> tensor<1x10xf32> attributes {client.dec_func = {func_name = "main", index = 0 : i64}} {
    %cst = arith.constant dense<0.000000e+00> : tensor<1x10xf32>
    %c0_i32 = arith.constant 0 : i32
    %c1_i32 = arith.constant 1 : i32
    %c6_i32 = arith.constant 6 : i32
    %c16_i32 = arith.constant 16 : i32
    %c1024_i32 = arith.constant 1024 : i32
    %c0 = arith.constant 0 : index
    %extracted = tensor.extract %arg0[%c0] : tensor<1x!ct>
    %pt = openfhe.decrypt %cc, %extracted, %sk : (!cc, !ct, !sk) -> !pt
    %0 = openfhe.decode_ckks %pt : !pt -> tensor<1x1024xf32>
    %1 = scf.for %arg1 = %c0_i32 to %c1024_i32 step %c1_i32 iter_args(%arg2 = %cst) -> (tensor<1x10xf32>)  : i32 {
      %2 = arith.addi %arg1, %c6_i32 : i32
      %3 = arith.remsi %2, %c16_i32 : i32
      %4 = arith.cmpi sge, %3, %c6_i32 : i32
      %5 = scf.if %4 -> (tensor<1x10xf32>) {
        %6 = arith.remsi %arg1, %c16_i32 : i32
        %7 = arith.index_cast %arg1 : i32 to index
        %extracted_0 = tensor.extract %0[%c0, %7] : tensor<1x1024xf32>
        %8 = arith.index_cast %6 : i32 to index
        %inserted = tensor.insert %extracted_0 into %arg2[%c0, %8] : tensor<1x10xf32>
        scf.yield %inserted : tensor<1x10xf32>
      } else {
        scf.yield %arg2 : tensor<1x10xf32>
      }
      scf.yield %5 : tensor<1x10xf32>
    }
    return %1 : tensor<1x10xf32>
  }
  func.func @main__generate_crypto_context() -> !cc {
    %params = openfhe.gen_params  {mulDepth = 1 : i64, plainMod = 0 : i64} : () -> !params
    %cc = openfhe.gen_context %params {supportFHE = false} : (!params) -> !cc
    return %cc : !cc
  }
  func.func @main__configure_crypto_context(%cc: !cc, %sk: !sk) -> !cc {
    openfhe.gen_rotkey %cc, %sk {indices = array<i64: 2, 16, 4, 32, 1, 8, 3, 12>} : (!cc, !sk) -> ()
    return %cc : !cc
  }
}

{-#
  dialect_resources: {
    builtin: {
      torch_tensor_10_torch.float32: "0x04000000C82C93BCB0A5E43DF06DDC3C380DDA3C2800E23C48C6F23DBCE7343D20A291BD04CC763DF21388BD",
      torch_tensor_10_64_torch.float32: "0x04000000288DA7BDBC8A753DF6738ABD3411AEBD0C8A7A3DE06964BC0C7E6EBD4077F8BDD889673D5AF9D5BDE0542A3D9653D13D4CB0613D8886A7BC648A4FBDA6A984BD50FA5E3DF0DA5D3C28F31C3D50AB9F3D78A5C53C10B29FBC18327DBD94AA5ABD2A398CBD1EBFD23DC4738CBDD062F7BDB64B933DD81A8C3C9C33913D7CF63EBD7ED7F5BD141067BD2867CC3D420F90BD9498913D74B07FBD3014AD3DA848C43C68E4483D12578EBDC2A18D3DAC1D663D0687C6BDE8A6C53D082B1D3D10E149BD6AFDC23D00B5213D8AD6CBBDF875953D888A673DD40403BD2473523D48678FBCECE4FCBD54EC743DF4DE24BD1CB110BD3ADAD1BD3A21B43DE29DB13DB8D3DFBC1A5FDCBDE6CA8C3DDE81C3BD52EEA3BD720A963DE0C11CBCB00F743D883C44BDE8F7B13D9837CCBD14FBE6BDBC137F3D809CF33DE42A293D3C5FD93D900FA5BDEC67E8BD64B04DBDA8919DBCE25887BD603479BC58D6C23D408890BC346CBA3D30A5C1BC28D8223D1419E73D1CE8663D00A203BCC826D73D643E10BDC875ABBC1839C3BCA63BC7BDE6D9DABDBEB6F53D44CA313D362CA83D44FF0B3DC214BCBD103C8A3CE85A75BD0081653C9657AB3DAAE79FBD8805EABD20EE9A3DE8B0FEBC4CEC0D3D54F7CDBDEAF7863DD88F883C6CF5B2BDC6E2953D1E30F43D1211C03D648751BD686DF13D7C5EB1BD8060DE3D7E9CC1BD003FAABC90D8F8BC9AD3A83D70EC553DD611B6BD2883D9BD08CE9EBCF8A1943D88FDA1BCAE88FFBDC4481EBD8060F43B5A8FEA3D30B95C3C10440E3CE23CD2BD8074ECBD407F5B3B0C18D63DC8113F3D1A75E83D10E4C23D4E17DBBDF0B570BD4C9C40BDD06B41BC2614BEBD5C41EA3DC044323C78EFDD3D184C6F3D08186D3D2AC39B3DA881ACBC604AB83D909F6ABD1EBFBABDE80CC33D105CA1BDDE00B23D0028393D30973CBDF4A4083D8AFD9DBDA4B70D3D4845FD3D1CF1393D18E3CE3D0CDA89BDC60EFB3D786699BD920B88BD56A7D23D78BEA43C0041423B2C9BD2BDB8D80F3DBEDCCDBD5011F2BC54B7F83DC0F682BB60282F3C5E9496BD00900338688FD2BC421CB9BD805E01BB809AC43A788EB5BD5859F03C1027023D0404AD3DD89C963C5C4FEE3DA2B9EDBDE016F7BBB0868FBC1EA9A9BD0878643D481D90BCC089723C003F3A3C10A265BDE0F649BC801B3D3BEC7C7EBDF057C53C243B513DB2FE913D80C68C3DD696ED3D8CD40BBD889838BD40552DBC8819B83C40EC39BCFEA9EFBD5E07BC3D18B1DEBCA4CEC63DE81EF73DACF1413DB0A3413C9C37C7BD308E6BBD589DC7BC323B98BDD0F7A93CEC3088BDC0297FBD36DFE9BDA0DD1BBC2A26F2BDEA6DA83D003796BAEC25CA3D863BD23DC067453D70C7F7BCF0F2093C0CD9543DE057C4BCCC43713D18D4DEBCF4CC35BD94B6B73DC8D28CBC0051383AE41ED63D4C489BBDCE12F73D8650CE3DC065C13C00AEC83D7091933DA8D4B9BD88CEDCBDA8D0523DC0F4CBBC88F66DBD54ACBA3D30BD1F3C3C11B8BDCC2DDFBD085883BCECC3F53DF08CDFBC34AE513D9419503DBA3EADBD08E8C2BC50FB743D04C8BE3D8CA1323DE471FB3D60A4D4BB1043563C08CF91BDF268813DF010853DF489B33D801806BDB8E1C3BD36E1CE3D0CA4CFBDD685FEBD8080E1BDA0B9CB3DB84162BD2CF90CBD84B4373D2AD8903DE000F13B80F9F83C089038BDF44B28BDA4106B3DA8C39E3DA843113DB8A2AF3DFEADC1BD9C67B93D1865A43D0A67803D68C65FBD28E5E53D246E453DD4BAECBD2CA25FBD200DBABD2417203D906191BCE4430BBD58E8DC3CD472133D581EEC3C7C5A1E3D30B4AC3CC039163C7C14BB3D3273DABD207CDABD48138D3CE8C191BC30BE6BBDA63AD23DC0D65B3C7CC9543D2024633D60D986BBB007DE3D847F23BD665BE83D848020BD12AAF83D00A894B9F8535B3D6037E93B469AFE3D64B5203D0E41833D24B2593D80481C3BC202CDBDF08F99BCB86DE93D4CDD38BD4C33A0BD20ACDF3B980DF53D00BC8B3D48ED733DE6D4C6BDF03BA0BD1617983D5C0CF0BDE25EF43D009DB93C8A6FD73DC868803C4062E83C9CA4EC3D441A7BBD3653EF3DA0876E3DA881B23CC025553C94E245BD7E4AF1BDBC8844BDF0CE3DBC78B7073D0AD193BDBAF7D63DA29491BDDEA2FB3D5078373D3E71C1BD20F65B3CD041F63DFCEF8E3D20182BBD907F47BD00D732BD50BA803C6860EABCF0D1E3BC1ABC933DD483CCBD50820EBDF01B3C3C289B8E3C2C482B3D94AA15BD48CECC3C14167DBD143CD53D8855D93D78F8C23D88FA55BD7450803D18F8BABDCA7595BD866BB8BDB006053D96A98E3D66F0A83D2041193DE07CE0BD5C312EBDC47F5E3D7C34DA3D44BD89BDA222B2BD7C9FECBDB4FC3C3D924DEC3DAAB7E2BD4806F23C1E69A2BD2899D0BD80BDCFBD74D58EBD1857BC3D28B5733DC8083D3D8A35C53DFCD942BDA23BCDBD3884ABBDA052343DB0C7603DBCF80F3D1C5988BDE8FE073D9E27BF3D5860633DE05637BC40D2C23B2E2CC1BD149DF3BDEE12F6BD6000123DF0C2F53D2011B93DE40CD6BD7852063DC05137BB60A6E83D7A73953D986293BDCE13DCBDF0F4463D985E5FBD604A823CC48A173DA4A3263DD813483D788A02BD8050A6BAE698E5BDC0DDA63DAEDEB73D940ED43D928AE0BDC443B7BDEC151DBDB03D0DBDFEA5FB3D08BCF8BD242F953DBCF9E7BD4EFEC83D043EF0BDE0CA5E3D08BA273DB6A5C13D10861E3C783B7BBDFC525F3D20FBB7BB50FF06BD64E360BDD8D086BD4035933CEE648FBDC019443CC276B93D14F0243D64E963BD24BB243DE61A8B3DBC5E60BD18F685BDA8D87A3D403A5F3D80BABF3AA40F9F3D704407BD00B39A3C6CB3A83D8A998DBDE4962CBD502F0ABD889912BD54FEC2BDE887BA3C8C1BDEBDEA8AAABDA08C81BD20636ABC70B9BA3DD0A91E3C6CDDADBDAA33C43D02FEA03D029AFABD00DBB03BDAD1A0BDB86D82BCC8863CBD7AF4DA3DFCC209BD56A9BE3D14EB97BDD4D16DBDF418F03DB2A985BDC0B2693BC0EB1E3BE0F54BBC20151D3DD0A53DBD9C6B723D980CF3BD982CEF3DCABFF2BD30EF3E3C18F7B2BDE0C6E13C0070AB3C14F72B3D066D94BDACDB363DB463193DF89F7D3D2674F9BD1AFECABD967DF7BDE47F323D383EDDBD708B7A3C6878FE3D889547BDA0EBB2BBE2BADB3DF6A2F9BDCC147EBD8CE1213D50D3643C4A92A8BD3A3BB53D8E5BE63D364788BD5C0B6ABDB4ABDDBDF07394BD88F8FFBC40E116BD1427EA3DF28AB33DF4AE113D004CF73B48A8563DCCC66B3DF08D49BD84C72FBD6EA5F0BD72C5D63DF0B5F1BC80FBC43BB4D1F4BDDA30F5BDC052B0BC3426E73DD0A77C3DD8BEFE3CA8909BBC04F98ABD96F4F7BDECBF0ABD3C6791BD84D19ABDC80B23BD84DD00BDE22FEDBD2C843B3D24ECDD3D74C1F9BD6AC7CD3D34E51C3D008BE4BBAA7CA6BDB0FD35BCE4FCDE3D6CD470BD38E3C23CF6F9B9BD342124BD464B953D50A45CBDC07D4C3B7C79253DA4451B3D40D5443D64897DBD184DB73D646F993DE4632CBDAC12BC3D2630D0BDA08E993CE05F92BD00F6D73C24B7903D009C0FBC7083F4BD80CE013D7CC2263D6636EA3D389D97BCE00F88BD6EEAB83DC69DE5BD88C99FBC"
    }
  }
#-}

