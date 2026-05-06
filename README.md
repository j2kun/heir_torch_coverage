# heir torch coverage

A little repo to record HEIR's coverage for torch operators via torch-mlir

## Dependencies

```bash
python3.12 -m venv venv
source venv/bin/activate
pip install torchvision heir-py

# Download https://github.com/llvm/torch-mlir-release/releases/download/dev-wheels/torch_mlir-20260308.745-cp312-cp312-manylinux_2_27_x86_64.manylinux_2_28_x86_64.whl
pip install /path/to/torch_mlir-20260308.745-cp312-cp312-manylinux_2_27_x86_64.manylinux_2_28_x86_64.whl
```

## For each torch operator

Create a torch model in a standalone file with a single torch operator, and then
populate any necessary weights with arbitrary data. Add an export call similar
to the one in `demo_export.py` and for this model and run it to produce an MLIR
file for linalg on tensors.

Manually add `{secret.secret}` annotation to all function arguments in input
mlir file and manually add `domain_lower`, `domain_upper`, and `degree`
annotation to each activation op in `model.mlir`. E.g., a ReLU looks like this:

```mlir
%11 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%10 : tensor<1x64xf32>) outs(%7 : tensor<1x64xf32>) {
^bb0(%in: f32, %out: f32):
  %17 = arith.cmpf ugt, %in, %cst : f32
  %18 = arith.select %17, %in, %cst : f32
  linalg.yield %18 : f32
} -> tensor<1x64xf32>
```

And should be annotated as

```mlir
%11 = linalg.generic {
    // new stuff start
    domain_lower = -2.0 : f64,
    domain_upper = 3.0 : f64,
    degree = 3 : i32,
    // new stuff end
    indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]
} ins(%10 : tensor<1x64xf32>) outs(%7 : tensor<1x64xf32>) {
^bb0(%in: f32, %out: f32):
  %17 = arith.cmpf ugt, %in, %cst : f32
  %18 = arith.select %17, %in, %cst : f32
  linalg.yield %18 : f32
} -> tensor<1x64xf32>
```

Then

```bash
./venv/bin/heir-opt \
--annotate-module=backend=openfhe scheme=ckks \
--torch-linalg-to-ckks="ciphertext-degree=1024" \
--scheme-to-openfhe \
model.mlir > model_openfhe.mlir
```

If this succeeds, we're done for that op.

If it fails, record the failure in a log file and add the failing torch op to a
list of ops that need to be supported.

## heir-opt Coverage Results

| Operator    | Status  | Notes                                                |
| :---------- | :------ | :--------------------------------------------------- |
| Add         | Success |                                                      |
| AvgPool2d   | Failed  | Rank mismatch during lowering to conv_2d             |
| BatchNorm2d | Failed  | Layout assignment error during conversion: rank 1 vs domain size 3 |
| Cat         | Failed  | Layout assignment error: rank 4 vs domain size 5     |
| Conv2d      | Success | Reduced input size to 16x16 to fit ciphertext degree 1024 |
| Flatten     | Failed  | Error: No mgmt attribute found in the module for B/FV |
| GELU        | Failed  | Failed to legalize secret.generic containing arith.divf |
| LeakyReLU   | Failed  | Layout assignment error: rank 1 vs domain size 0     |
| Linear      | Success |                                                      |
| Matmul      | Failed  | Rank mismatch in linalg.vecmat: rank 2 vs indexing map rank 1 |
| MaxPool2d   | Failed  | Layout assignment error: rank 2 vs domain size 4     |
| Mean        | Failed  | Layout assignment error: rank 1 vs domain size 0     |
| Mul         | Success |                                                      |
| PReLU       | Failed  | Layout assignment error: rank 0 vs domain size 1     |
| Permute     | Failed  | Layout assignment error: rank 2 vs permutation size 4 |
| ReLU        | Success |                                                      |
| SiLU        | Success |                                                      |
| Sigmoid     | Success |                                                      |
| Sum         | Failed  | Error: 'tensor.extract' op incorrect number of indices for extract_element |
| Tanh        | Success |                                                      |
| bmm         | Failed  | Rank mismatch in linalg.batch_matmul: rank 2 vs indexing map rank 3 |
| chunk       | Failed  | Segmentation fault during heir-opt                   |
| div         | Failed  | Failed to legalize secret.generic containing arith.divf |
| eq          | Failed  | Failed to legalize secret.generic containing arith.cmpf |
| exp         | Success |                                                      |
| gt          | Success | Legalized with high-degree polynomial approximation  |
| log         | Success |                                                      |
| lt          | Success | Legalized with high-degree polynomial approximation  |
| mm          | Failed  | Type mismatch in arith.mulf during lowering: 1x1024 vs 2x1024 |
| neg         | Success |                                                      |
| prod        | Failed  | Error: 'tensor.extract' op incorrect number of indices for extract_element |
| select      | Success | Implemented as multiplication by mask                |
| softmax     | Failed  | Error in linalg.reduce: expected equal number of inputs and outputs |
| sqrt        | Success |                                                      |
| squeeze     | Failed  | Error: No mgmt attribute found in the module for B/FV |
| sub         | Success |                                                      |
| transpose   | Failed  | Layout assignment error: rank 2 vs permutation size 4 |
