let rawInput = document.body.innerText;
const grid = rawInput
    .trim()
    .split("\n")
    .map(line => line.split(""));

const turnRight = d => (d + 1) % 4;

const n = grid.length;
const m = grid[0].length;

const delta = [
    [-1, 0],
    [0, 1],
    [1, 0],
    [0, -1],
];

const findGuard = () => {
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < m; j++) {
            if (grid[i][j] === "^") {
                return { i, j };
            }
        }
    }
};
const { i: startI, j: startJ } = findGuard();

// Assess possible starting locations
let dir = 0;
const traversed = new Set();

const walk = () => {
    let ii = startI;
    let jj = startJ;
    while (true) {
        traversed.add(`${ii},${jj}`);

        const [deltaI, deltaJ] = delta[dir];
        const next_i = ii + deltaI;
        const next_j = jj + deltaJ;

        if (!grid[next_i]?.[next_j]) {
            break;
        }

        if (grid[next_i][next_j] === "#") {
            dir = turnRight(dir);
        } else {
            ii = next_i;
            jj = next_j;
        }
    }
};

walk();
console.log("Part1", traversed.size); // 5269

function canHaveObstacle(oi, oj) {
    if (grid[oi][oj] === "#") {
        return false;
    }

    grid[oi][oj] = "#";
    let i = startI;
    let j = startJ;

    dir = 0;
    const traversed_part2 = new Set();

    while (true) {
        if (traversed_part2.has(`${i},${j},${dir}`)) {
            grid[oi][oj] = ".";
            return true;
        }
        traversed_part2.add(`${i},${j},${dir}`);

        const [deltaI, deltaJ] = delta[dir];
        const next_i = i + deltaI;
        const next_j = j + deltaJ;

        if (!grid[next_i]?.[next_j]) {
            grid[oi][oj] = ".";
            break;
        }

        if (grid[next_i][next_j] === "#") {
            dir = turnRight(dir);
        } else {
            i = next_i;
            j = next_j;
        }
    }
}

let part2 = 0;
for (const pos of traversed) {
    const [oi, oj] = pos.split(",").map(Number);
    const loop = canHaveObstacle(oi, oj);
    if (loop) part2 += 1;
}

console.log("Part2", part2); // 1957