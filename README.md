# Particle Segmentation Automation

This project automates the process of particle segmentation on `.tif` images using a macro script. The script processes a directory of `.tif` images, applies segmentation to detect particle boundaries, and outputs the results as images and data.

## Requirements

- **Software**: ImageJ/Fiji with macro support
- **Libraries**: (list any required libraries or plugins, e.g., `Bio-Formats`, `Particle Analyzer`)

## Workflow

1. Load all `.tif` images from the specified directory.
2. Apply preprocessing steps (e.g., noise reduction, normalization).
3. Use thresholding and edge detection to segment particles.
4. Detect particle boundaries and output segmented images.
5. Optionally, extract and save particle data (e.g., area, perimeter, number of particles).

## Installation

1. Clone this repository:

2. Place your `.tif` images in the `/images` folder.

3. Run the macro on ImageJ/Fiji:
- Open ImageJ/Fiji and run the macro from the script editor.

## Example Usage

To process all `.tif` images in the `/images` folder:

- Open the macro in ImageJ/Fiji.
- Run the macro to automatically process and segment the images.

The results will be saved in the `/outputs` folder.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
