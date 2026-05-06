import torch
import torch.nn as nn
import torch_mlir
from torch_mlir.fx import OutputType
import os

class Conv3dModel(nn.Module):
    def __init__(self):
        super(Conv3dModel, self).__init__()
        self.conv = nn.Conv3d(3, 16, kernel_size=3, stride=1, padding=1)

    def forward(self, x):
        return self.conv(x)

model = Conv3dModel()
model.eval()

# Example input: (batch_size, channels, depth, height, width)
sample_input = torch.randn(1, 3, 4, 4, 4)

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
