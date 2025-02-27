function filteredAccumulate(a, b, combiner, nullValue, filter, term, next) {
  const iter = (a, result) => {
    if (a > b) return result;
    return filter(a, b)
      ? iter(next(a), combiner(term(a), result))
      : iter(next(a), result);
  };
  return iter(a, nullValue);
}

const identity = (x) => x;
const sum = (a, b) => a + b;
const increment = (x) => x + 1;
const product = (a, b) => a * b;
const isEven = (x) => x % 2 === 0;

const isPrime = (n) => {
  if (n <= 1) return false;
  if (n === 2 || n === 3) return true;
  if (isEven(n)) return false;
  const end = Math.sqrt(n);

  const iter = (i) => {
    if (n % i === 0) return false;
    if (i > end) return true;
    return iter(i + 2);
  };

  return iter(3);
};

const areCoPrime = (a, b) => {
  const gcd = (a, b) => {
    if (b === 0) return a;
    return gcd(b, a % b);
  };

  return gcd(a, b) === 1;
};

console.log(filteredAccumulate(1, 10, sum, 0, isEven, identity, increment)); // 2 + 4 + 6 + 8 + 10 = 30
console.log(filteredAccumulate(1, 10, sum, 0, isPrime, identity, increment)); // 2 + 3 + 5 + 7 = 17
console.log(filteredAccumulate(1, 10, product, 1, areCoPrime, identity, increment)); // 1 * 3 * 7 * 9 = 189
