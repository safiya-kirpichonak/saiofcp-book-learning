/**
Results:
0.24998750000000042
0.249999875000001

0.24999999999999992
0.2500000000000003

Simpson's method is indeed more accurate.
*/

const sum = (term, a, next, b) =>
  a > b ? 0 : term(a) + sum(term, next(a), next, b);

const integral = (f, a, b, dx) => {
  const addDx = (x) => x + dx;
  return sum(f, a + dx / 2, addDx, b) * dx;
};

const integralSimpson = (f, a, b, n) => {
  const h = (b - a) / n;
  const term = (i) => {
    const x = a + i * h;
    return i === 0 || i === n ? f(x) : (i % 2 === 0 ? 2 : 4) * f(x);
  };
  const next = (i) => i + 1;
  return (h / 3) * sum(term, 0, next, n);
};

console.log(integral((x) => x * x * x, 0, 1, 0.01));
console.log(integral((x) => x * x * x, 0, 1, 0.001));

console.log(integralSimpson((a) => a * a * a, 0, 1, 100));
console.log(integralSimpson((a) => a * a * a, 0, 1, 1000));
