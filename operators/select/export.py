import torch
import torch.nn as nn
import torch_mlir
from torch_mlir.fx import OutputType
import os

class SelectModel(nn.Module):
    def __init__(self):
        super(SelectModel, self).__init__()

    def forward(self, x):
        return torch.select(x, dim=1, index=0)

model = SelectModel()
model.eval()

# Example input
sample_input = torch.randn(1, 64)

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
