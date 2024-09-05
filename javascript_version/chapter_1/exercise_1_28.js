// Trying to understand the code

function doExponentiationModulo(number, exponent, modulo) {
  if (exponent === 0) return 1;

  let result = 1;
  let base = number % modulo;

  while (exponent > 0) {
    if (exponent % 2 === 1) {
      result = (result * base) % modulo;
    }
    exponent = Math.floor(exponent / 2);
    base = (base * base) % modulo;
  }

  return result;
}

function millerRabinTest(n, a) {
  if (n % 2 === 0 || n < 2) return false;

  let d = n - 1;
  while (d % 2 === 0) {
    d /= 2;
  }

  let x = doExponentiationModulo(a, d, n);
  if (x === 1 || x === n - 1) return true;

  while (d !== n - 1) {
    x = (x * x) % n;
    d *= 2;

    if (x === n - 1) return true;
    if (x === 1) return false;
  }

  return false;
}

function isPrime(n, k = 100) {
  for (let i = 0; i < k; i++) {
    const a = 2 + Math.floor(Math.random() * (n - 3));
    if (!millerRabinTest(n, a)) return false;
  }
  return true;
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
