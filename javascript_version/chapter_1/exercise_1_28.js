/* 
Let's take number = 7 (we'll test it for primally using this algorithm):

1. If an even number is provided, return false immediately, because all even numbers are composite,
except 2, which is prime.
2. Compute number - 1. Keep dividing number - 1 by 2 until you get an odd number:
   6 / 2 = 3 => remainder = 3, 
   divisions = 1 (the number of divisions).

3. Repeat this algorithm x times, let's say 10 times. If any iteration returns false, the number is composite:
  1. Pick a random number (randomNumber) from the range 2 to number - 2 (exclusive).
  2. Compute randomNumber ^ remainder mod number. If the result is 1 or number - 1, the number might be prime, and 
  we move to the next randomNumber.
  3. Otherwise, compute randomNumber ^ ((2 ^ exponentCoefficient) * remainder) mod number, where exponentCoefficient 
  goes from 0 to divisions - 1 inclusive. If any result equals number - 1, the number might be prime, so return true, 
  otherwise return false.
*/

function isEven(number) {
  return number % 2 === 0;
}

function getRandomBetween(start, end) {
  return Math.floor(Math.random() * (end - start)) + start;
}

function doExponentiationModulo(number, exponent, modulo) {
  if (exponent === 0) return 1;

  if (exponent % 2 === 0) {
    const halfExponent = doExponentiationModulo(number, exponent / 2, modulo);
    return (halfExponent * halfExponent) % modulo;
  } else {
    const evenExponent = doExponentiationModulo(number, exponent - 1, modulo);
    return (number * evenExponent) % modulo;
  }
}

function findRemainderAndDivisions(remainder, divisions) {
  if (!isEven(remainder)) {
    return { remainder, divisions };
  } else {
    return findRemainderAndDivisions(remainder / 2, divisions + 1);
  }
}

function doSecondRoundOfCheck(
  number,
  randomNumber,
  exponentCoefficient,
  divisions,
  remainder
) {
  if (exponentCoefficient === divisions) return false;

  const newExponent = 2 ** exponentCoefficient * remainder;
  const secondCheck = doExponentiationModulo(randomNumber, newExponent, number);
  if (secondCheck === number - 1) return true;
  return doSecondRoundOfCheck(
    number,
    randomNumber,
    exponentCoefficient + 1,
    divisions,
    remainder
  );
}

function doMillerRabinTest(number, remainder, divisions) {
  const randomNumber = Math.floor(Math.random() * (number - 2 - 2)) + 2;
  const firstCheck = doExponentiationModulo(randomNumber, remainder, number);
  if (firstCheck === number - 1 || firstCheck === 1) return true;
  return doSecondRoundOfCheck(number, randomNumber, 0, divisions, remainder);
}

function fastPrime(number, times, remainder, divisions) {
  if (times === 0) {
    return true;
  } else if (doMillerRabinTest(number, remainder, divisions)) {
    return fastPrime(number, times - 1, remainder, divisions);
  } else {
    return false;
  }
}

function isPrime(number) {
  const TIMES = 100;
  if (number === 2) return true;
  if (isEven(number)) return false;

  const { remainder, divisions } = findRemainderAndDivisions(number - 1, 0);
  return fastPrime(number, TIMES, remainder, divisions);
}

/*
1001: false
1002: false
1003: false
1004: false
1005: false
1009: true
1013: true
1019: true
1021: true
1031: true
 */

console.log(`1001: ${isPrime(1001)}`);
console.log(`1002: ${isPrime(1002)}`);
console.log(`1003: ${isPrime(1003)}`);
console.log(`1004: ${isPrime(1004)}`);
console.log(`1005: ${isPrime(1005)}`);

console.log(`1009: ${isPrime(1009)}`);
console.log(`1013: ${isPrime(1013)}`);
console.log(`1019: ${isPrime(1019)}`);
console.log(`1021: ${isPrime(1021)}`);
console.log(`1031: ${isPrime(1031)}`);
