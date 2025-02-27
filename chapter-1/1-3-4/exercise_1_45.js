// (define (average a b)
//     (/ (+ a b) 2))

const average = (a, b) => (a + b) / 2;

// (define (average-damp f)
//     (lambda (x) (average x (f x))))

const averageDamp = (f) => (x) => average(x, f(x));

// (define (compose f g)
//     (lambda (x) (f (g x))))

const compose = (f, g) => (x) => f(g(x));

// (define (repeated f n)
//     (if (= n 1)
//         f
//         (compose f (repeated f (- n 1)))))

const repeated = (f, n) => (n === 1 ? f : compose(f, repeated(f, n - 1)));

const multiAverageDamp = (n) => repeated(averageDamp, n);

// (define tolerance 0.00001)
// (define (fixed-point f first-guess)
//   (define (close-enough? v1 v2)
//     (< (abs (- v1 v2)) tolerance))
//   (define (try guess)
//     (let ((next (f guess)))
//       (if (close-enough? guess next)
//           next
//           (try next))))
//   (try first-guess))

const TOLERANCE = 0.00001;
const fixedPoint = (f, firstGuess) => {
  const closeEnough = (v1, v2) => Math.abs(v1 - v2) < TOLERANCE;
  const tryGuess = (guess) => {
    const next = f(guess);
    return closeEnough(guess, next) ? next : tryGuess(next);
  };
  return tryGuess(firstGuess);
};

const findNthRoot = (n, x) => {
  const findRoot = (y) => x / y ** (n - 1);
  const smooth = multiAverageDamp(10)(findRoot);
  return fixedPoint(smooth, 1.0);
};

console.log(findNthRoot(2, 9)); // 2.994900059703668
console.log(findNthRoot(3, 27)); // 2.9966029329879635
console.log(findNthRoot(4, 16)); // 1.9974638345970477
console.log(findNthRoot(5, 32)); // 1.997970736431276
