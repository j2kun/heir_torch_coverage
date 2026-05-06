## Dependencies (done)

```bash
python3.12 -m venv venv
source venv/bin/activate
pip install torchvision heir-py

# Download https://github.com/llvm/torch-mlir-release/releases/download/dev-wheels/torch_mlir-20260308.745-cp312-cp312-manylinux_2_27_x86_64.manylinux_2_28_x86_64.whl
pip install /path/to/torch_mlir-20260308.745-cp312-cp312-manylinux_2_27_x86_64.manylinux_2_28_x86_64.whl
```

## For each torch operator

Create a torch model in a standalone file with a single torch operator, and then
populate any necessary weights with arbitrary data. Add an export call
similar to the one in `demo_export.py` and for this model and run it
to produce an MLIR file for linalg on tensors.

Manually add `{secret.secret}` annotation to all function arguments in
input mlir file and manually add `domain_lower`, `domain_upper`, and `degree`
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
