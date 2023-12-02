import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename).replace('\\dist','');

let input = fs.readFileSync(path.join(__dirname, 'exampleinput.txt'), 'utf8');

// input = fs.readFileSync(path.join(__dirname, 'input.txt'), 'utf8');

let chars = input.split('');

export const day = chars;