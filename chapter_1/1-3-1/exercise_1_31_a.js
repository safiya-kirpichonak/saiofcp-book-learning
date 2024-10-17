const factorial = (n) => {
  const product = (term, a, next, b) =>
    a > b ? 1 : term(a) * product(term, next(a), next, b);
  const identity = (x) => x;
  const increment = (x) => x + 1;
  return product(identity, 1, increment, n);
};

const findPI = (n) => {
  const product = (term, a, next, steps) =>
    steps === 0 ? 1 : term(a) * product(term, next(a), next, steps - 1);

  const term = ({ x }) => x;
  const next = ({ x, repeat }) => ({ x: repeat ? x : x + 2, repeat: !repeat });

  return (
    (4 * product(term, { x: 2, repeat: false }, next, n)) /
    product(term, { x: 3, repeat: true }, next, n)
  );
};

console.log(factorial(5)); // 120
console.log(factorial(3)); // 6
console.log(findPI(100)); // 3.1570301764551667
