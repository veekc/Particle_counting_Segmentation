// Set input and output folders

inputDir = "C:/Users/vaska/OneDrive/Desktop/yeilding Time sweep Imaging/9.95e-3/";

outputDir = inputDir + "Processed/";
File.makeDirectory(outputDir);


// Get list of all TIFF images
list = getFileList(inputDir);

// --- Step 1: Ask user to select crop area on the first image ---
for (i = 0; i < list.length; i++) {
    if (endsWith(list[i], ".TIF") || endsWith(list[i], ".tif")) {
        open(inputDir + list[i]);
        imgTitle = getTitle();
        Stack.setXUnit("um");
        Stack.setYUnit("um");

        // Ask user to select ROI
        waitForUser("Select crop area, then click OK to continue.");

        // Store the ROI coordinates
        getSelectionBounds(x, y, width, height);

        // Close image and proceed to processing all images
        run("Close All");
        break;
    }
}

// --- Step 2: Process all images using the selected crop area ---
for (i = 0; i < list.length; i++) {
    if (endsWith(list[i], ".TIF") || endsWith(list[i], ".tif")) {
        open(inputDir + list[i]);
        imgTitle = getTitle();

        // Set pixel dimensions
        Stack.setXUnit("");
        Stack.setYUnit("");
        run("Properties...", "channels=1 slices=1 frames=1 pixel_width=1 pixel_height=1 voxel_depth=1 frame=1");

        // Apply stored ROI
        makeRectangle(x, y, width, height);
        run("Crop");

        // Apply Gaussian Blur to duplicate
        run("Duplicate...", "title=blurred");
        selectImage("blurred");
        run("Gaussian Blur...", "sigma=20");

        // Divide original by blurred image
        selectImage(imgTitle);
        imageCalculator("Divide create 32-bit", imgTitle, "blurred");
        selectImage("Result of " + imgTitle);

        // Invert
        run("Invert");

        // Bandpass Filter
        run("Bandpass Filter...", "filter_large=4 filter_small=2 suppress=None tolerance=5 autoscale saturate");

        // Minimum filter
        run("Invert");
        run("Minimum...", "radius=2.6");

        // Auto brightness/contrast
        run("Enhance Contrast", "saturated=0.35");

        // Save result
        saveAs("Tiff", outputDir + "Processed_" + list[i]);

        // Close all images to reset
        run("Close All");
    }
}
