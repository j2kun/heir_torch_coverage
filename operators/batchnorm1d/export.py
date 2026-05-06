import torch
import torch.nn as nn
import torch_mlir
from torch_mlir.fx import OutputType
import os

class BatchNorm1dModel(nn.Module):
    def __init__(self):
        super(BatchNorm1dModel, self).__init__()
        self.bn = nn.BatchNorm1d(3)

    def forward(self, x):
        return self.bn(x)

model = BatchNorm1dModel()
model.eval()

# Example input
sample_input = torch.randn(1, 3, 16)

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
