const fibonacciRecursive = (n) => {
  console.log(n);

  if (n === 0) return 0;
  if (n === 1) return 1;

  return fibonacciRecursive(n - 1) + fibonacciRecursive(n - 2);
};

const fibonacci = (n) => {
  fibonacciIteration(1, 0, n);
};

const fibonacciIteration = (a, b, count) => {
  console.log(b);
  return count === 0 ? b : fibonacciIteration(a + b, a, count - 1);
};

fibonacci(7);
fibonacciRecursive(7);

// const fibonacciRecursive = (n) => {
//   console.log(n);

//   if (3 < n) return n;

//   return (
//     fibonacciRecursive(n - 1) +
//     fibonacciRecursive(n - 2) +
//     fibonacciRecursive(n - 3)
//   );
// };

// const fibonacci = (n) => {
//   fibonacciIteration(0, 1, 2, n);
// };

// const fibonacciIteration = (a, b, c, count) => {
//   console.log(a);
//   return count === 0 ? a : fibonacciIteration(b, c, a + b + c, count - 1);
// };

// fibonacci(7)
