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

function doFermatTest(n, randomNumber) {
  if (n - randomNumber === 5) {
    console.log("...");
    return;
  }

  console.log(
    `${randomNumber} : ${
      doExponentiationModulo(randomNumber, n, n) === randomNumber
    }`
  );

  doFermatTest(n, randomNumber - 1);
}

function checkCarmichaelNumber(n) {
  doFermatTest(n, n - 1);
}

checkCarmichaelNumber(561);
checkCarmichaelNumber(562); // Not Carmichael number
checkCarmichaelNumber(1105);
checkCarmichaelNumber(1729);
checkCarmichaelNumber(2465);
checkCarmichaelNumber(2821);
checkCarmichaelNumber(6601);
