// generateImages.js
const sharp = require("sharp");
const fs = require("fs");
const path = require("path");

// Paths
const inputDir = path.join(__dirname, "backend", "public", "images", "original");
const outputDir = path.join(__dirname, "backend", "public", "images", "responsive");

// Define responsive sizes (widths)
const sizes = [400, 800, 1200, 1600, 2400]; // you can adjust/remove 2400

// Ensure output directory exists
if (!fs.existsSync(outputDir)) {
  fs.mkdirSync(outputDir, { recursive: true });
}

// Step 1: get all original basenames (without extension)
const originals = fs.readdirSync(inputDir).map(file =>
  path.basename(file, path.extname(file))
);

// Step 2: cleanup responsive folder (remove orphans)
fs.readdirSync(outputDir).forEach(file => {
  const baseName = file.split("-")[0]; // everything before the first "-"
  if (!originals.includes(baseName)) {
    const filePath = path.join(outputDir, file);
    fs.unlinkSync(filePath);
    console.log(`🗑️ Removed orphaned file: ${filePath}`);
  }
});

// Step 3: generate images
fs.readdirSync(inputDir).forEach(file => {
  const inputPath = path.join(inputDir, file);

  const ext = path.extname(file);              // preserves original (".JPG")
  const baseName = path.basename(file, ext);   // "kk-photo-1"
  const extLower = ext.toLowerCase();          // ".jpg", ".png", ".webp"

  if (![".jpg", ".jpeg", ".png", ".webp"].includes(extLower)) {
    console.log(`Skipping unsupported file: ${file}`);
    return;
  }

  sizes.forEach(width => {
    // JPEG version
    const jpegOutputPath = path.join(outputDir, `${baseName}-${width}.jpg`);
    sharp(inputPath)
      .resize({ width, withoutEnlargement: true })
      .jpeg({ quality: 80 })
      .toFile(jpegOutputPath)
      .then(() => console.log(`✅ Created ${jpegOutputPath}`))
      .catch(err => console.error(`❌ Error with ${jpegOutputPath}`, err));

    // WebP version
    const webpOutputPath = path.join(outputDir, `${baseName}-${width}.webp`);
    sharp(inputPath)
      .resize({ width, withoutEnlargement: true })
      .webp({ quality: 80 })
      .toFile(webpOutputPath)
      .then(() => console.log(`✅ Created ${webpOutputPath}`))
      .catch(err => console.error(`❌ Error with ${webpOutputPath}`, err));
  });
});
