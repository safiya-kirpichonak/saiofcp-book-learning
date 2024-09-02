function findDivisor(n, testDivisor) {
  if (testDivisor * testDivisor > n) {
    return n;
  } else if (n % testDivisor === 0) {
    return testDivisor;
  } else {
    const nextDivisor = testDivisor === 2 ? 3 : testDivisor + 2;
    return findDivisor(n, nextDivisor);
  }
}

function isPrime(n) {
  return n === findDivisor(n, 2);
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

searchForPrimesPeriod(2, 30);
