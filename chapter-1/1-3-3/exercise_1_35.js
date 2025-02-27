/**
 * golden ratio (φ) is just a special constant number, like PI, and its = 1.618.
 * 
 * The fixed point is a number that does not change when you put it in function. 
 * Imagine you found a number x so that if you put it in 1+1/x, the result will
 * be the same as x. For example, if you put x=1.618, the result of the function 
 * again will be about 1.618 - and this is a golden ratio.
 * 
 * fixedPoint is a function that looks for fixed points for any given function (f). 
 * It starts with the initial number (firstGuess) and applies the function again 
 * and again until the result is close enough (given the error set by TOLERANCE).
 * 
 * transformation function is itself a simple function. It is related to the golden 
 * section only because its fixed point is the golden section.
 */

const TOLERANCE = 0.00001;

const fixedPoint = (f, firstGuess) => {
  const closeEnough = (v1, v2) => Math.abs(v1 - v2) < TOLERANCE;

  const tryGuess = (guess) => {
    const next = f(guess);
    return closeEnough(guess, next) ? next : tryGuess(next);
  };

  return tryGuess(firstGuess);
};

const transformation = (x) => 1 + 1 / x;

console.log(fixedPoint(transformation, 1.0)); // 1.6180327868852458
