function expmod(base, exp, mod) {
  if (exp === 0) {
    return 1;
  } else if (exp % 2 === 0) {
    const halfExp = expmod(base, exp / 2, mod);
    return (halfExp * halfExp) % mod;
  } else {
    return (base * expmod(base, exp - 1, mod)) % mod;
  }
}

function fermatTest(n) {
  function tryIt(a) {
    return expmod(a, n, n) === a;
  }
  const a = 1 + Math.floor(Math.random() * (n - 1));
  return tryIt(a);
}

function fastPrime(n, times) {
  if (times === 0) {
    return true;
  } else if (fermatTest(n)) {
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

searchForPrimesPeriod(2, 30);
