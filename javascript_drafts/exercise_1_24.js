/*
  To check that one number (n) does not divide by the second number (a) use 
  the following formula "Fermat's Little Theorem":

  a ^ (n - 1) ≡ 1 (mod n)

  The following algorithm indirectly uses this principle:
  - doExponentiationModulo function calculates a ^ n mod n.
  - doFermatTest checks is a ^ n mod n === a.
*/

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

function doFermatTest(n) {
  const randomNumber = 1 + Math.floor(Math.random() * (n - 1));
  return doExponentiationModulo(randomNumber, n, n) === randomNumber;
}

function fastPrime(n, times) {
  if (times === 0) {
    return true;
  } else if (doFermatTest(n)) {
    return fastPrime(n, times - 1);
  } else {
    return false;
  }
}

function isPrime(n) {
  return fastPrime(n, 10);
}

function timedPrimeTest(n) {
  const startTime = process.hrtime.bigint();
  if (isPrime(n)) {
    const elapsedTime = process.hrtime.bigint() - startTime;
    const roundToPrecision = (num, precision) => {
      const factor = Math.pow(10, precision);
      return (Math.round(num * factor) / factor).toFixed(precision);
    };
    console.log(`${n} *** ${roundToPrecision(Number(elapsedTime) / 1e9, 4)}`);
  }
}

function searchForPrimesPeriod(start, end) {
  if (start > end || start < 0 || end < 0) {
    throw new Error(
      "Invalid input: start must be less than end and both must be non-negative."
    );
  }

  if (start % 2 === 0 && start !== 2) {
    isPrimeNumber(start + 1, end);
  } else {
    isPrimeNumber(start, end);
  }
}

function isPrimeNumber(start, end) {
  if (start > end) {
    return;
  } else if (start == 1) {
    timedPrimeTest(start);
    isPrimeNumber(start + 1, end);
  } else if (start == 2) {
    timedPrimeTest(start);
    isPrimeNumber(start + 1, end);
  } else {
    timedPrimeTest(start);
    isPrimeNumber(start + 2, end);
  }
}

searchForPrimesPeriod(1000, 1100);
searchForPrimesPeriod(10000, 10100);
searchForPrimesPeriod(100000, 100100);
searchForPrimesPeriod(1000000, 1000100);
searchForPrimesPeriod(10000000, 10000100);
searchForPrimesPeriod(100000000, 100000100);
searchForPrimesPeriod(1000000000, 1000000100);
