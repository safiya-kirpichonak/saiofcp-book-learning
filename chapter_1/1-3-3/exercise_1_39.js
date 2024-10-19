/**
 * Calculate the approximation for the tangent tan(x) by chain
 * fraction of the Lambert formula.
 */

const contFracRecursive = (n, d, k) => {
  const recursive = (i) =>
    i === k ? n(i) / d(i) : n(i) / (d(i) - recursive(i + 1));
  return recursive(1);
};

const tanCF = (x, k) => {
  const n = (i) => (i === 1 ? x : x * x);
  const d = (i) => 2 * i - 1;
  return contFracRecursive(n, d, k);
};

console.log(tanCF(1, 10)); // 1.557407724654902
