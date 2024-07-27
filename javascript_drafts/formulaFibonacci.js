const phi = (1 + Math.sqrt(5)) / 2;
const psi = (1 - Math.sqrt(5)) / 2;

const x = (n) => phi ** n / Math.sqrt(5);
const y = (n) => (phi ** n - psi ** n) / Math.sqrt(5);

const fibonacciIteration = (n) => fibonacci(1, 0, n);

const fibonacci = (a, b, count) =>
  count === 0 ? b : fibonacci(a + b, a, count - 1);

for (i = 1; i < 11; i++) {
  fr = fibonacciIteration(i);
  xr = x(i);
  yr = y(i);
  console.log(`${fr} ${xr} ${yr}`);
}