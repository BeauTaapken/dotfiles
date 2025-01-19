from pynvml import *
nvmlInit()

# This sets the GPU to adjust - if this gives you errors or you have multiple GPUs, set to 1 or try other values.
myGPU = nvmlDeviceGetHandleByIndex(0)

# The GPU frequency offset value should replace the "80" in the line below.
nvmlDeviceSetGpcClkVfOffset(myGPU, 60)

# The Mem frequency Offset should be **multiplied by 2** to replace the "2500" below
# for example, an offset of 500 in GWE means inserting a value of 1000 in the next line
nvmlDeviceSetMemClkVfOffset(myGPU, 2800)

# NOTE: I don't need this, already done with a separate script
# The power limit should be set below in mW - 216W becomes 216000, etc. May not work for laptops. Remove the below line if you don't want to adjust power limits.
# nvmlDeviceSetPowerManagementLimit(myGPU, 216000)
