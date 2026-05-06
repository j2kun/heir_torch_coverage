# heir-opt Coverage Results

| Operator    | Status  | Notes                                                |
| :---------- | :------ | :--------------------------------------------------- |
| Add         | Success |                                                      |
| AvgPool2d   | Failed  | Rank mismatch during lowering to conv_2d             |
| BatchNorm2d | Failed  | Layout assignment error during conversion: rank 1 vs |
:             :         : domain size 3                                        :
| Cat         | Failed  | Layout assignment error: rank 4 vs domain size 5     |
| Conv2d      | Success | Reduced input size to 16x16 to fit ciphertext degree |
:             :         : 1024                                                 :
| Flatten     | Failed  | Error: No mgmt attribute found in the module for     |
:             :         : B/FV                                                 :
| GELU        | Failed  | Failed to legalize secret.generic containing         |
:             :         : arith.divf                                           :
| LeakyReLU   | Failed  | Layout assignment error: rank 1 vs domain size 0     |
| Linear      | Success |                                                      |
| Matmul      | Failed  | Rank mismatch in linalg.vecmat: rank 2 vs indexing   |
:             :         : map rank 1                                           :
| MaxPool2d   | Failed  | Layout assignment error: rank 2 vs domain size 4     |
| Mean        | Failed  | Layout assignment error: rank 1 vs domain size 0     |
| Mul         | Success |                                                      |
| PReLU       | Failed  | Layout assignment error: rank 0 vs domain size 1     |
| Permute     | Failed  | Layout assignment error: rank 2 vs permutation size  |
:             :         : 4                                                    :
| ReLU        | Success |                                                      |
| SiLU        | Success |                                                      |
| Sigmoid     | Success |                                                      |
| Sum         | Failed  | Error: 'tensor.extract' op incorrect number of       |
:             :         : indices for extract_element                          :
| Tanh        | Success |                                                      |
| bmm         | Failed  | Rank mismatch in linalg.batch_matmul: rank 2 vs      |
:             :         : indexing map rank 3                                  :
| chunk       | Failed  | Segmentation fault during heir-opt                   |
| div         | Failed  | Failed to legalize secret.generic containing         |
:             :         : arith.divf                                           :
| eq          | Failed  | Failed to legalize secret.generic containing         |
:             :         : arith.cmpf                                           :
| exp         | Success |                                                      |
| gt          | Success | Legalized with high-degree polynomial approximation  |
| log         | Success |                                                      |
| lt          | Success | Legalized with high-degree polynomial approximation  |
| mm          | Failed  | Type mismatch in arith.mulf during lowering: 1x1024  |
:             :         : vs 2x1024                                            :
| neg         | Success |                                                      |
| prod        | Failed  | Error: 'tensor.extract' op incorrect number of       |
:             :         : indices for extract_element                          :
| select      | Success | Implemented as multiplication by mask                |
| softmax     | Failed  | Error in linalg.reduce: expected equal number of     |
:             :         : inputs and outputs                                   :
| sqrt        | Success |                                                      |
| squeeze     | Failed  | Error: No mgmt attribute found in the module for     |
:             :         : B/FV                                                 :
| sub         | Success |                                                      |
| transpose   | Failed  | Layout assignment error: rank 2 vs permutation size  |
:             :         : 4                                                    :
