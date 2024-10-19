/**
 * The goal is to find the minimum number of elements of the chain fraction (k),
 * at which the result approaches the value 1/φ with an accuracy of up to 4
 * decimal places (0.6180).
 */

const contFracRecursive = (n, d, k) => {
  const recursive = (i) =>
    i === k ? n(i) / d(i) : n(i) / (d(i) + iter(i + 1));
  return recursive(1);
};

const contFracIter = (n, d, k) => {
  const iter = (i, result) =>
    i === 0 ? result : iter(i - 1, n(i) / (d(i) + result));
  return iter(k, 0);
};

const TOLERANCE = 0.0001;
const GOLDEN_RATIO = 0.618;

const findMimK = (f, firstGuess) => {
  const closeEnough = (result) => Math.abs(result - GOLDEN_RATIO) < TOLERANCE;

  const tryGuess = (guess) => {
    const result = f(guess);
    return closeEnough(result) ? guess + 1 : tryGuess(guess + 1);
  };

  return tryGuess(firstGuess);
};

const transformation = (guess) =>
  contFracIter(
    () => 1,
    () => 1,
    guess
  );

console.log(findMimK(transformation, 1));
