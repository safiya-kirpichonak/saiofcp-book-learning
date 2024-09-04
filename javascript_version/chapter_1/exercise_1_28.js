// Bulshit from ChatGPD:

function expmod(number, exponent, modulo) {
  if (exponent === 0) return 1;

  // Recursive exponentiation by squaring
  let halfExponent = expmod(number, Math.floor(exponent / 2), modulo);
  halfExponent = (halfExponent * halfExponent) % modulo;

  if (exponent % 2 !== 0) {
    halfExponent = (halfExponent * number) % modulo;
  }

  // Non-trivial square root check (non-trivial square root of 1 mod n)
  if (halfExponent === 1 && exponent !== modulo - 1) {
    const x = expmod(number, (modulo - 1) / 2, modulo);
    if (x !== 1 && x !== modulo - 1) {
      return 0; // Non-trivial square root of 1 found, signal failure.
    }
  }

  return halfExponent;
}

function millerRabinTest(n, k = 5) {
  if (n === 2 || n === 3) return true;
  if (n % 2 === 0 || n < 2) return false;

  const s = n - 1;
  let d = s;

  // Find d such that n-1 = d * 2^r for some r >= 1
  let r = 0;
  while (d % 2 === 0) {
    d = d / 2;
    r++;
  }

  // Perform the test k times for confidence
  for (let i = 0; i < k; i++) {
    const a = 2 + Math.floor(Math.random() * (n - 4)); // Random number a < n
    let x = expmod(a, d, n);

    if (x === 1 || x === n - 1) continue; // Probably prime

    let composite = true;
    for (let j = 0; j < r - 1; j++) {
      x = expmod(x, 2, n);
      if (x === n - 1) {
        composite = false;
        break;
      }
    }

    if (composite) return false; // Composite
  }

  return true; // Probably prime
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
  return fastPrime(n, 100);
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
