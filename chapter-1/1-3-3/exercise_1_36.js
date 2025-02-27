/**
 * We are looking for a value of x that does not change when you set the
 * function x-> log(1000)/log(x). This number solves the equation x ** x =1000.
 *
 * Averaging: When we find a new approximation, we do not take it immediately,
 * but average it with the previous value. This helps the algorithm to converge
 * faster, making each new value more stable and reducing jumps.
 */

const TOLERANCE = 0.00001;

const fixedPoint = (f, firstGuess, isAveraging) => {
  const closeEnough = (v1, v2) => Math.abs(v1 - v2) < TOLERANCE;

  const tryGuess = (guess, count) => {
    console.log(`${count} : ${guess}`);
    const next = isAveraging ? (guess + f(guess)) / 2 : f(guess);
    return closeEnough(guess, next)
      ? { next, count }
      : tryGuess(next, count + 1);
  };

  return tryGuess(firstGuess, 1);
};

const transformation = (x) => Math.log(1000) / Math.log(x);

console.log(fixedPoint(transformation, 2.0, false)); // { next: 4.555532270803653, count: 34 }
console.log(fixedPoint(transformation, 2.0, true)); // { next: 4.555537551999825, count: 9 }
