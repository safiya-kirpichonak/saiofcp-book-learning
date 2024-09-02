// Bullshit from ChatGPD:

function checkCarmichaelPrimeNumberOrNot(n) {
  for (let a = 1; a < n; a++) {
    if (gcd(a, n) === 1) {
      if (Math.pow(a, n) % n !== a % n) {
        return false;
      }
    }
  }
  return true;
}

function gcd(x, y) {
  while (y !== 0) {
    let temp = y;
    y = x % y;
    x = temp;
  }
  return x;
}

console.log(checkCarmichaelPrimeNumberOrNot(561)); 
console.log(checkCarmichaelPrimeNumberOrNot(1105)); 
console.log(checkCarmichaelPrimeNumberOrNot(1729)); 
console.log(checkCarmichaelPrimeNumberOrNot(2465)); 
console.log(checkCarmichaelPrimeNumberOrNot(2821)); 
console.log(checkCarmichaelPrimeNumberOrNot(6601));
