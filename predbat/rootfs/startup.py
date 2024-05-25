import os
print("Bootstrap predai")

if not os.path.exists("/config/dev"):
  print("Copy initial python files")
  os.system("cp /*.py /config")
else:
  print("Development system, keeping current files")
  
if not os.path.exists("/config/predai.yaml"):
  print("Copy template config file")
  os.system("cp /*.yaml /config")

print("Startup")
os.system("python3 /config/predai.py")


