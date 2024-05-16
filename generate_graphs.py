import os

def generate_cycle_file(folder="simple_graphs"):
    for i in range(1000, 5000, 2):  # Loop over odd indices from 7 to 500
      filename = os.path.join(folder, f"cycle_{i}.mtx")
      with open(filename, "w") as file:
          file.write(f"%%MatrixMarket matrix coordinate pattern symmetric\n")
          file.write(f"{i} {i} {i}\n")
          # Write edges for the cycle
          for j in range(1, i + 1):
              file.write(f"{j} {(j % i) + 1}\n")
      print(f"File {filename} created successfully.")
def generate_text_file():
  directory = "simple_graphs/"
  extension = ".mtx"

  with open("simple_files.txt", "a") as file:  # Open in append mode
      for number in range(1000, 5000, 2):  # start from 1, go up to 500, step by 2 (odd numbers)
          filename = f"{directory}cycle_{number}{extension}"
          file.write(filename + "\n")
generate_text_file()
#5k / 1k runs