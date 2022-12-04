import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename).replace('\\dist',''); 
console.log(__dirname);

let input = fs.readFileSync(path.join(__dirname, 'exampleinput.txt'), 'utf8');

input = fs.readFileSync(path.join(__dirname, 'input.txt'), 'utf8');

let lines = input.split('\n');
let max : number = 0
let sum : number = 0
lines.forEach(
    function (line) {
        if (line == '') {
            if (sum > max) {
                max = sum;
            }
            sum = 0;
        }

        sum += +line;
    });

let result = max; 
export const day1 = result;
