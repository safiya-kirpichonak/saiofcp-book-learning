const iterativeImprove = (isGoodEnough, improve, x) => {
  const iter = (guess) => {
    const next = improve(guess, x);
    return isGoodEnough(guess, next) ? next : iter(next);
  };
  return iter;
};

const improve = (guess, x) => (guess + x / guess) / 2;
const isGoodEnough = (guess, next) => Math.abs(guess - next) < 0.001;
const sqrt = (guess, x) => iterativeImprove(isGoodEnough, improve, x)(guess);

console.log(sqrt(1.0, 27)); // 5.19615242285917
console.log(sqrt(1.0, 8)); // 2.8284271250498643
console.log(sqrt(1.0, 16)); // 4.000000000000051
console.log(sqrt(1.0, 2)); // 1.4142135623746899
