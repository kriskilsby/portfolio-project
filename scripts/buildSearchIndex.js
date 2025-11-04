const fs = require('fs');
const path = require('path');
const cheerio = require('cheerio');

// ----------------------
// Config: folders to index
// ----------------------
const foldersToIndex = [
  path.join(__dirname, '../backend/views'),          // Portfolio pages
  path.join(__dirname, '../stork-app/frontend/views') // Stork app pages
];

// Output file
const outputFile = path.join(__dirname, '../backend/public/searchIndex.json');

// ----------------------
// Helper: get all .ejs files recursively
// ----------------------
function getAllEJSFiles(dir) {
  let results = [];
  const list = fs.readdirSync(dir);

  list.forEach(file => {
    const filePath = path.join(dir, file);
    const stat = fs.statSync(filePath);
    if (stat && stat.isDirectory()) {
      results = results.concat(getAllEJSFiles(filePath));
    } else if (file.endsWith('.ejs')) {
      results.push(filePath);
    }
  });

  return results;
}


// ----------------------
// Helper: extract visible text from HTML
// ----------------------
function extractText(html) {
  const $ = cheerio.load(html);
  return $('body').text().replace(/\s+/g, ' ').trim();
}

// ----------------------
// Build search index
// ----------------------
let index = [];

foldersToIndex.forEach(folder => {
  const files = getAllEJSFiles(folder);

  files.forEach(filePath => {
    // Skip partials, includes, and layout files
    const skipPatterns = [
      'partials', 'includes', 'components', 'layouts',
      'navbar', 'footer', 'head', 'header'
    ];
    if (skipPatterns.some(pattern => filePath.toLowerCase().includes(pattern))) {
      return; // skip this file
    }

    let html = fs.readFileSync(filePath, 'utf-8');

    // Remove EJS tags
    html = html.replace(/<%=?[\s\S]*?%>/g, '');

    const text = extractText(html);

    // Skip very small or empty pages
    if (text.length < 30) return;

    // Get page title or fallback to file name
    const titleMatch = html.match(/<title>(.*?)<\/title>/i);
    const title = titleMatch ? titleMatch[1] : path.basename(filePath, '.ejs');

    // Normalize path separators for Windows
    const normalizedPath = filePath.replace(/\\/g, '/');

    // Build URL
    let url = '';
    if (normalizedPath.includes('backend/views')) {
      const pageName = path.basename(normalizedPath, '.ejs');
      url = '/' + (pageName === 'index' ? '' : pageName);
    } else {
      const relativePath = path.relative(
        path.join(__dirname, '../stork-app/frontend/views'),
        filePath
      ).replace(/\\/g, '/').replace('.ejs', '');
      url = '/stork-app/' + relativePath;
    }

    index.push({ title, url, text });
  });
});

// ----------------------
// Write JSON
// ----------------------
fs.writeFileSync(outputFile, JSON.stringify(index, null, 2));
console.log(`✅ Search index created: ${outputFile}`);
console.log(`Indexed ${index.length} pages.`);