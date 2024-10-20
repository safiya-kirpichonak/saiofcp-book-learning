const compose = (f, g) => (x) => f(g(x));
const repeated = (f, n) => (n === 1 ? f : compose(f, repeated(f, n - 1)));

const dx = 0.0001;
const smooth = (f) => (x) => (f(x - dx) + f(x) + f(x + dx)) / 3;

const multiSmooth = (n) => repeated(smooth, n);

const square = (x) => x * x;

console.log(multiSmooth(2)(square)(2));
console.log(multiSmooth(4)(square)(2));
console.log(multiSmooth(8)(square)(2));
console.log(multiSmooth(16)(square)(2));
