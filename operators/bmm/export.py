import torch
import torch.nn as nn
import torch_mlir
from torch_mlir.fx import OutputType
import os

class BMMModel(nn.Module):
    def __init__(self):
        super(BMMModel, self).__init__()

    def forward(self, x, y):
        return torch.bmm(x, y)

model = BMMModel()
model.eval()

# Example input: (batch_size, n, m), (batch_size, m, p)
sample_input_x = torch.randn(2, 64, 32)
sample_input_y = torch.randn(2, 32, 10)

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
