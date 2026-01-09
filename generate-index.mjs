import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const srcDir = path.join(__dirname, 'src');
const indexPath = path.join(srcDir, 'index.ts');

// Leer todos los archivos .tsx en src
const files = fs.readdirSync(srcDir)
  .filter(file => file.endsWith('.tsx'))
  .map(file => file.replace('.tsx', ''));

// Generar exports
const exports = files
  .map(file => `export { default as ${file} } from './${file}';`)
  .join('\n');

// Escribir index.ts
fs.writeFileSync(indexPath, exports);

console.log(`✓ Generated index.ts with ${files.length} icon exports`);
