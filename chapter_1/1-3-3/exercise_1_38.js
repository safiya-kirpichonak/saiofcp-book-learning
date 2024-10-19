/**
 * e is a constant, roughly equal to 2.71828. It is as important a
 * mathematical constant as π and the golden ratio. e is the basis of
 * natural logarithms. The point of this task is to show how one can
 * approximate the number e (base of natural logarithms) by means
 * of chain fraction.
 */

const contFracIter = (n, d, k) => {
  const iter = (i, result) =>
    i === 0 ? result : iter(i - 1, n(i) / (d(i) + result));
  return iter(k, 0);
};

const e =
  2 +
  contFracIter(
    () => 1,
    (i) => (i % 3 === 0 ? 2 * (i / 3) : 1),
    100
  );

console.log(e); // 2.5819767068693262
