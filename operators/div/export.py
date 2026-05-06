import torch
import torch.nn as nn
import torch_mlir
from torch_mlir.fx import OutputType
import os

class DivModel(nn.Module):
    def __init__(self):
        super(DivModel, self).__init__()

    def forward(self, x, y):
        return x / y

model = DivModel()
model.eval()

# Example input (y must not be zero)
sample_input_x = torch.randn(1, 64)
sample_input_y = torch.randn(1, 64) + 1.0 # Avoid zero

# Export to MLIR
mlir = torch_mlir.fx.export_and_import(
    model,
    sample_input_x,
    sample_input_y,
    output_type=OutputType.LINALG_ON_TENSORS)

# Save to file in the same directory as the script
script_dir = os.path.dirname(os.path.abspath(__file__))
output_path = os.path.join(script_dir, "model.mlir")

with open(output_path, "w") as f:
    f.write(str(mlir))

print(f"Exported MLIR to {output_path}")
