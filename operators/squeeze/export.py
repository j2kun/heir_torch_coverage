import torch
import torch.nn as nn
import torch_mlir
from torch_mlir.fx import OutputType
import os

class SqueezeModel(nn.Module):
    def __init__(self):
        super(SqueezeModel, self).__init__()

    def forward(self, x):
        return torch.squeeze(x)

model = SqueezeModel()
model.eval()

# Example input with a dimension of size 1
sample_input = torch.randn(1, 3, 1, 16)

# Export to MLIR
mlir = torch_mlir.fx.export_and_import(
    model,
    sample_input,
    output_type=OutputType.LINALG_ON_TENSORS)

# Save to file in the same directory as the script
script_dir = os.path.dirname(os.path.abspath(__file__))
output_path = os.path.join(script_dir, "model.mlir")

with open(output_path, "w") as f:
    f.write(str(mlir))

print(f"Exported MLIR to {output_path}")
