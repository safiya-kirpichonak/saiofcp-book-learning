const iterativeImprove = (isGoodEnough, improve) => {
  const iter = (guess) => {
    const next = improve(guess);
    return isGoodEnough(guess, next) ? next : iter(next);
  };
  return iter;
};

const TOLERANCE = 0.00001;
const transformation = (x) => 1 + 1 / x;
const closeEnough = (v1, v2) => Math.abs(v1 - v2) < TOLERANCE;

const fixedPoint = (f, firstGuess) =>
  iterativeImprove(closeEnough, f)(firstGuess);

console.log(fixedPoint(transformation, 1.0)); // 1.6180327868852458
