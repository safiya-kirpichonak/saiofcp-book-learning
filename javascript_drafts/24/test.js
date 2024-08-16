function smallestDivisor(n) {
  return findDivisor(n, 2);
}

function findDivisor(n, testDivisor) {
  if (square(testDivisor) > n) {
    return n;
  } else if (divides(testDivisor, n)) {
    return testDivisor;
  } else {
    return findDivisor(n, testDivisor + 1);
  }
}

function divides(a, b) {
  return b % a === 0;
}

function prime(n) {
  return n === smallestDivisor(n);
}













function timedPrimeTest(n) {
  startPrimeTest(n, performance.now());
}

function startPrimeTest(n, startTime) {
  if (prime(n)) {
    reportPrime(n, performance.now() - startTime);
  }
}

function roundToPrecision(n, precision) {
  const factor = Math.pow(10, precision);
  const rounded = Math.round(n * factor) / factor;
  return rounded.toFixed(precision);
}

function reportPrime(n, elapsedTime) {
  console.log(`${n} *** ${roundToPrecision(elapsedTime / 1000, 4)}`);
}

function preparePeriod(start, end) {
  if (start > end || start < 0 || end < 0) {
    throw new Error(
      "Invalid input: start must be less than end and both must be non-negative"
    );
  }
  if (start % 2 === 0) {
    searchForPrimes(start + 1, end);
  } else {
    searchForPrimes(start, end);
  }
}

function searchForPrimes(start, end) {
  if (start > end) {
    return start;
  } else {
    timedPrimeTest(start);
    searchForPrimes(start + 2, end);
  }
}

function square(n) {
  return n * n;
}

preparePeriod(1000000, 1000100);
// console.log("");
// preparePeriod(10000000000, 10000000100);
// console.log("");
// preparePeriod(100000000000, 100000000100);
// console.log("");
// preparePeriod(1000000000000, 1000000000100);
