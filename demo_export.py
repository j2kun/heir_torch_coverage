import torch
import model
import torch_mlir
from torch_mlir.fx import OutputType


# Instantiate the model
model = SomeModel()
model.eval()

input_dim = 123
sample_input = torch.randn(1, input_dim)

# Export to MLIR
mlir = torch_mlir.fx.export_and_import(
    model,
    sample_input,
    output_type=OutputType.LINALG_ON_TENSORS)

print(mlir)
